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

- **`extra/xorg/buildall`** — builds every package in `extra/xorg/` in dependency
  order.
- **`extra/apps/buildall`** — builds the `extra/apps/` layer on top and installs
  the default session config.

Both run each package's `./build` through **`coco`** (`core/coco`) by default, so
they work on a booted mimux with no build environment set up:

```sh
doas ./extra/xorg/buildall              # installs into the running system
ROOTFS="$HOME/stage" ./extra/apps/buildall   # or stage it somewhere
```

Set **`DISABLE_COCO=1`** to skip coco and use the caller's environment instead.
That is the dev-container path: `tools/env.sh` has already exported the cross
toolchain and a sysroot at `$ROOTFS`, and re-deriving a native environment on top
of it would be wrong. In that mode the scripts guard on `$INOSENV` and add the
sysroot `-rpath-link` / `PKG_CONFIG_PATH` wiring that coco would otherwise
supply. `tools/graphical.sh` and `tools/apps.sh` are one-line stubs that do
exactly this, so the container flow is unchanged:

```sh
./tools/graphical.sh   # X11 stack       (= DISABLE_COCO=1 extra/xorg/buildall)
./tools/apps.sh        # WM + terminal + fonts + wallpaper + config
./tools/bootable.sh    # repackage dist/bootable.img
```

Note that `coco` refuses to run when a non-coco build environment is already
active, so running the container flow without `DISABLE_COCO=1` fails loudly
rather than mixing the two toolchains.

Individual packages use the same standalone `./build` contract as `core/`
(`download` / `extract` / `makeinstall` / `clear`, plus `all`). See
[`../core/README.md`](../core/README.md) for the details — everything there
applies here too, including the `version` script convention (all `extra/`
packages now ship one).

## Design decisions that keep this small

- **Video via the in-tree `modesetting` DDX**, driving the DRM/KMS node
  directly via `libdrm`. Built with glamor/GLX/DRI disabled, so its
  GBM/EGL paths compile out and it falls back to plain KMS dumb buffers —
  we **skip mesa / libgbm / LLVM entirely**, there is **no GL**. Only
  `--enable-dri2` (the protocol extension, not mesa) is needed to get it
  built at all.
- **Suckless st** for the terminal, so we **skip the entire GLib / GTK / Cairo /
  Pango stack**.
- **Reuse from `core/`**: zlib, openssl, ncurses, libffi, python3, perl, eudev
  (input hotplug), util-linux (libblkid).
- **No display manager / logind.** X is started by hand from a VT via `xinit`
  (not startx/xauth, avoiding the libXmu/libXt/libICE/libSM chain). The server
  is installed **setuid root** so it can touch DRM/fb/input/VT under the runit
  init with no seat manager.

## Packages

### `extra/xorg/` — build order (see `extra/xorg/buildall`)

Protocol + base libs: `util-macros`, `xorgproto`, `xcb-proto`, `libXau`,
`libXdmcp`, `libxcb`, `xcb-util`, `xcb-util-keysyms`, `xcb-util-wm`,
`xcb-util-image`, `xcb-util-renderutil` (the last two feed the picom
compositor), `xtrans`.

Xlib client libs: `libX11`, `libXext`, `libXrender`, `libXfixes`, `libXi`,
`libXrandr`, `libXcursor`, `libXinerama`.

Fonts / text: `libpng`, `freetype`, `expat`, `fontconfig`, `libXft`,
`font-util`, `libfontenc`, `libXfont2`.

Keyboard: `libxkbfile`, `xkeyboard-config`, `xkbcomp`.

Server support + drivers: `libpciaccess`, `libxcvt`, `libdrm`, `pixman`,
`libevdev`, then `xorg-server` (the `modesetting` video driver is built into
the server itself — see the design decisions above), then the input driver
`mtdev`, `xf86-input-evdev` (builds against the server's SDK, so it comes
last).

Most are small autotools builds. A handful are meson-only (`xorgproto`,
`xkeyboard-config`, `libpciaccess`, `libxcvt`, `libdrm`, `pixman`); autotools is
preferred wherever a `configure` ships.

### `extra/apps/` — build order (see `extra/apps/buildall`)

- `dejavu-fonts` — one real TTF so st/WM can render text.
- `xinit` — the session launcher.
- `libjpeg` (IJG) → `imlib2` → `feh` — the wallpaper stack (feh renders the
  background; imlib2 needs a JPEG loader, hence libjpeg). Only PNG+JPEG imlib2
  loaders are enabled; feh is built `curl=0` (no libcurl).
- `st` — suckless terminal, pinned to DejaVu Sans Mono. A single vendored diff
  (`extra/apps/st/mimux.diff`) folds in the suckless **scrollback**,
  **scrollback-mouse**, and **alpha** patches: `Shift+PageUp`/`Shift+PageDown`
  and `Shift+MouseWheel` scroll a 10000-line history, a 32-bit ARGB visual
  gives the background transparency that picom composites, and the 16-color
  palette is themed to match the wallpaper (Mimicoco).
- `bspwm` + `sxhkd` — the window manager and its hotkey daemon.
- `lemonbar` + `slstatus` + `xtitle` + `dmenu` — the status bar + launcher.
  lemonbar (Xft fork) renders the panel; slstatus feeds cpu/mem/clock; xtitle
  streams the focused window title; dmenu is the `Alt+Space` launcher. The
  `mimux-panel` script (below) wires them together, in the Mimicoco theme.
- `uthash` → `libev` → `libconfig` → `picom` — the compositor stack. picom is
  built on the **XRender** backend only (`-Dopengl=false -Ddbus=false
  -Dregex=false`), so no mesa/libepoxy, dbus, or pcre2 are pulled in. It draws
  the transparency (st's ARGB background), shadows, and fading.
- `btop` — a resource monitor (CPU/mem/proc/net). Plain Makefile build, no
  `./configure`; `GPU_SUPPORT=false` since there's no GPU passthrough on this
  VM target.
- `libevent` → `tmux` — a terminal multiplexer, so a session survives a
  dropped SSH connection. `ncurses` (`core/ncurses`) only builds the wide-char
  libraries (`libncursesw*`); `core/ncurses/build` now aliases them to the
  plain (non-w) names, since tmux's `configure` unconditionally probes for
  `-lncurses`.
- `neovim` — bundles its own third-party deps (LuaJIT, libuv, msgpack,
  unibilium, libtermkey, libvterm, tree-sitter) via its `cmake.deps` build,
  statically linked into the `nvim` binary. No system package needed for any
  of those.
- `config` — the session config, installed last (see below).

None of `btop`/`tmux`/`neovim` need the X11 stack — they build and run fine
against a `core/`-only rootfs too (e.g. over SSH, see the root
[`AGENTS.md`](../AGENTS.md)); they're just grouped under `extra/apps/` since,
like the rest of this layer, they're opt-in and not part of the minimal
bootable core.

**No `version` script on suckless packages.** `st`, `dmenu`, and `slstatus` are
configured through vendored patches / `config.h`, so their builds are pinned to
a specific release; a blind "latest" bump would break those edits. They are
version-managed by hand and deliberately ship no `version` script (unlike the
rest of the tree).

## Session config (`extra/apps/config/`, installed by its own `build` script)

Unlike the other packages there is nothing to compile here; `config/build` just
drops the files below into the rootfs. `extra/apps/buildall` runs it last.

- **`xstart`** — the launcher; runs `xinit` on the current VT. Installed to
  `/usr/bin/xstart` and also as `/usr/bin/startx`. Log in as `mimi` and run it.
- **`xinitrc`** → `exec bspwm`.
- **`bspwmrc`** — 10 desktops, borders/gaps, focus-follows-pointer, launches the
  compositor (`picom -b`) and the status bar (`mimux-panel`), and sets the
  wallpaper (`/usr/share/mimux/mimicoco.jpg`, shipped by the feh package) via
  `feh --bg-fill`.
- **`mimux-panel`** — the lemonbar panel script (installed to `/usr/bin`).
  In the **Mimicoco** theme (colours matched to the wallpaper — warm charcoal
  base, sage-green accent from the plant, amber from the warm light): clickable
  bspwm desktops on the left (focused = sage, occupied = cream, empty = dim,
  urgent = terracotta), the focused window title in the center, and slstatus
  (cpu/mem/clock) on the right. The alpha in its background colour makes it
  translucent through picom.
- **`picom.conf`** — XRender backend, shadows + fade on, opacity left at 1.0 so
  only st's own background is see-through (forcing opacity would dim text too).
- **`sxhkdrc`** — keybindings. The modifier is **Alt** (`mod1`), not Super: a
  Wayland host such as Hyprland grabs Super globally, so it never reaches the
  guest. Layout mirrors a typical Hyprland setup — `Alt+Return`/`Alt+Shift+A`
  terminal, `Alt+Space`/`Alt+p` launcher (dmenu), `Alt+Shift+Q` close,
  `Alt+V`/`Alt+F` float/fullscreen, `Alt+hjkl` focus, `Alt+Shift+hjkl` swap,
  `Alt+1..0` desktops, `Alt+Shift+1..0` send.
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
