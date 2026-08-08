# Mimux Extra

Non-essential, opt-in packages that are **not** part of the core bootable
rootfs. These build on top of `core/` and provide a minimal graphical
environment: **Xorg + the bspwm window manager + a terminal**. Unlike `core/`,
nothing here is installed by the base `tools/userspace.sh` run — you opt in by
running the graphical build scripts against an already-built rootfs.

## Layout

```
extra/
  xorg/        the X11 stack (protocol libs, Xlib/xcb, fonts, drivers, server)
  apps/        the session: bspwm, sxhkd, st, xinit, fonts, feh wallpaper
    config/    session config installed into the rootfs (see below)
```

Two orchestrators drive the build, mirroring `tools/userspace.sh`:

- **`tools/graphical.sh`** — builds every package in `extra/xorg/` in dependency
  order.
- **`tools/apps.sh`** — builds the `extra/apps/` layer on top and installs the
  default session config.

Both must run **inside the dev container** (they guard on `$INOSENV`) against a
rootfs that already has `core/` built. Typical flow:

```sh
./tools/graphical.sh   # X11 stack
./tools/apps.sh        # WM + terminal + fonts + wallpaper + config
./tools/bootable.sh    # repackage dist/bootable.img
```

Individual packages use the same standalone `./build` contract as `core/`
(`download` / `extract` / `makeinstall` / `clear`, plus `all`). See
[`../core/README.md`](../core/README.md) for the details — everything there
applies here too, including the `version` script convention (all `extra/`
packages now ship one).

## Design decisions that keep this small

- **Video via `xf86-video-fbdev`** (writes to `/dev/fb0`, which the shipped
  kernel exposes over virtio-gpu). This lets us **skip mesa / libgbm / LLVM
  entirely** — there is **no GL**. `xorg-server` is built with glamor, GLX and
  DRI disabled; the `modesetting` DDX auto-disables (it needs gbm). The cost is
  a software-only render path.
- **Suckless st** for the terminal, so we **skip the entire GLib / GTK / Cairo /
  Pango stack**.
- **Reuse from `core/`**: zlib, openssl, ncurses, libffi, python3, perl, eudev
  (input hotplug), util-linux (libblkid).
- **No display manager / logind.** X is started by hand from a VT via `xinit`
  (not startx/xauth, avoiding the libXmu/libXt/libICE/libSM chain). The server
  is installed **setuid root** so it can touch DRM/fb/input/VT under the runit
  init with no seat manager.

## Packages

### `extra/xorg/` — build order (see `tools/graphical.sh`)

Protocol + base libs: `util-macros`, `xorgproto`, `xcb-proto`, `libXau`,
`libXdmcp`, `libxcb`, `xcb-util`, `xcb-util-keysyms`, `xcb-util-wm`, `xtrans`.

Xlib client libs: `libX11`, `libXext`, `libXrender`, `libXfixes`, `libXi`,
`libXrandr`, `libXcursor`, `libXinerama`.

Fonts / text: `libpng`, `freetype`, `expat`, `fontconfig`, `libXft`,
`font-util`, `libfontenc`, `libXfont2`.

Keyboard: `libxkbfile`, `xkeyboard-config`, `xkbcomp`.

Server support + drivers: `libpciaccess`, `libxcvt`, `libdrm`, `pixman`,
`libevdev`, then `xorg-server`, then the drivers `mtdev`, `xf86-input-evdev`,
`xf86-video-fbdev` (drivers build against the server's SDK, so they come last).

Most are small autotools builds. A handful are meson-only (`xorgproto`,
`xkeyboard-config`, `libpciaccess`, `libxcvt`, `libdrm`, `pixman`); autotools is
preferred wherever a `configure` ships.

### `extra/apps/` — build order (see `tools/apps.sh`)

- `dejavu-fonts` — one real TTF so st/WM can render text.
- `xinit` — the session launcher.
- `libjpeg` (IJG) → `imlib2` → `feh` — the wallpaper stack (feh renders the
  background; imlib2 needs a JPEG loader, hence libjpeg). Only PNG+JPEG imlib2
  loaders are enabled; feh is built `curl=0` (no libcurl).
- `st` — suckless terminal, pinned to DejaVu Sans Mono.
- `bspwm` + `sxhkd` — the window manager and its hotkey daemon.

## Session config (`extra/apps/config/`, installed by `tools/apps.sh`)

- **`xstart`** — the launcher; runs `xinit` on the current VT. Installed to
  `/usr/bin/xstart` and also as `/usr/bin/startx`. Log in as `mimi` and run it.
- **`xinitrc`** → `exec bspwm`.
- **`bspwmrc`** — 10 desktops, borders/gaps, focus-follows-pointer, and sets the
  wallpaper (`/usr/share/mimux/mimicoco.jpg`, shipped by the feh package) via
  `feh --bg-fill`.
- **`sxhkdrc`** — keybindings. The modifier is **Alt** (`mod1`), not Super: a
  Wayland host such as Hyprland grabs Super globally, so it never reaches the
  guest. Layout mirrors a typical Hyprland setup — `Alt+Return`/`Alt+Shift+A`
  terminal, `Alt+Shift+Q` close, `Alt+V`/`Alt+F` float/fullscreen, `Alt+hjkl`
  focus, `Alt+Shift+hjkl` swap, `Alt+1..0` desktops, `Alt+Shift+1..0` send.
- **`00-keyboard.conf`** — `us` XkbLayout.

## Testing

`tools/linux_boot.sh` boots `dist/bootable.img` in a graphical QEMU window via
OVMF/UEFI (it runs on the **host**, not in the container; the Linux counterpart
to `tools/macos_boot.sh`). Defaults to 1280×720 (`XRES`/`YRES` overridable) and
uses **paravirtualized virtio input** (`virtio-keyboard-pci`/`virtio-tablet-pci`)
for low pointer latency. `GL=on` routes the scanout through host OpenGL for a
lower-latency present path.

```sh
./tools/linux_boot.sh                 # boot, then log in as mimi / george, run xstart
GL=on ./tools/linux_boot.sh           # optional host-GL present path
XRES=1600 YRES=900 ./tools/linux_boot.sh
```

## Kernel / build-env status (already satisfied — no changes needed)

- `core/kernel/configs/nomodules.config` already has `DRM=y`,
  `DRM_VIRTIO_GPU_KMS=y`, `DRM_SIMPLEDRM=y`, `DRM_FBDEV_EMULATION=y`,
  `INPUT_EVDEV=y`, `VIRTIO_INPUT=y`, `VT=y`.
- The Docker build image has `pkg-config`, `meson`, `ninja`, autotools and
  `gettext`; NLS/docs tooling like `xmlto` is absent, so those are disabled the
  way the rest of mimux does.
