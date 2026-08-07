# Mimux Extra

Non-essential, opt-in packages that are **not** part of the core bootable rootfs.
These build on top of `core/` and are intended for a graphical environment.

Nothing here is implemented yet — this document is the scouting output that
scopes the work.

## Scope (current milestone)

A minimal **Xorg + floating window manager + terminal emulator** stack. A
browser is deliberately deferred until the X stack is proven to boot (it forces
a choice between the lightweight own-engine route and the heavy GTK/mesa route).

### Design decisions that keep this small

- **Video via `xf86-video-fbdev`** (writes to `/dev/fb0`, which the shipped
  kernel exposes through `CONFIG_DRM_FBDEV_EMULATION=y` over virtio-gpu). This
  lets us **skip mesa / libdrm / libgbm / LLVM entirely** — no GL.
- **Suckless apps (st, cwm/dwm)** so we **skip the entire GLib / GTK / Cairo /
  Pango / gdk-pixbuf stack**.
- Reuse from `core/`: zlib, openssl, ncurses, libffi, python3, perl, eudev
  (input hotplug).

### Kernel / build-env status (already satisfied — no changes needed)

- `nomodules.config` already has: `DRM=y`, `DRM_KMS_HELPER=y`,
  `DRM_VIRTIO_GPU_KMS=y`, `DRM_QXL=y`, `DRM_SIMPLEDRM=y`,
  `DRM_FBDEV_EMULATION=y`, `INPUT_EVDEV=y`, `VT=y`.
- Docker build image already has `pkg-config`, `meson`, `ninja`, autotools.
  Only NLS/docs tooling (`gettext`, `xmlto`) is absent — disable those like the
  rest of mimux does.

## Package list (build order — deps first)

### X protocol + base libraries
1. util-macros        (build-time autoconf macros)
2. xorgproto          (protocol headers)
3. libXau
4. libXdmcp
5. xcb-proto          (python-generated)
6. libxcb
7. xtrans             (headers/build dep)

### Xlib client libraries
8.  libX11
9.  libXext
10. libXrender
11. libXfixes
12. libXi
13. libXrandr
14. libXcursor
15. libXinerama

### Fonts / text rendering
16. freetype          (build first without harfbuzz to break the cycle)
17. libpng
18. expat             (XML backend for fontconfig)
19. fontconfig
20. libXft
21. font-util
22. dejavu (or similar TTF)   (at least one real font for st/WM)

### X server support libraries + data
23. pixman
24. libpciaccess
25. libxshmfence
26. libfontenc
27. libXfont2
28. libxkbfile
29. xkeyboard-config  (keymap data)
30. xkbcomp

### Input + video drivers
31. libevdev
32. xf86-input-evdev
33. xf86-video-fbdev

### The server
34. xorg-server

### Applications
35. st                (suckless terminal; deps = libX11, libXft, fontconfig, freetype)
36. cwm  *(recommended, true floating)*  OR  dwm *(tiling-first, has floating layer)*
    - cwm deps: libX11, libXft, libXinerama, libXrandr
    - dwm deps: libX11, libXft, libXinerama

**Total: ~36 packages**, almost all small autotools/meson builds (the modular
libX* libs compile in seconds each).

## Deferred: browser

Revisit after the X stack boots. Options, cheapest to heaviest:

- **links -g** — renders straight to X. ~1-2 pkgs (add libjpeg-turbo). No JS.
- **NetSurf (fb/X frontend)** — own engine, basic CSS + limited JS (Duktape).
  ~11-13 tiny NetSurf libs, still **no GTK/mesa**.
- **Firefox/Chromium** — needs rust+clang+nodejs in the build image plus the
  full GTK+mesa+LLVM stack; multi-GB/multi-hour. Ruled out for a <600MB distro.

## Open questions before implementation

- WM pick: **cwm** (true floating) vs **dwm** (tiling with floating layer).
- Fonts: ship DejaVu only, or add a cursor/bitmap font too.
- Video: stick with `fbdev` (no GL), or later invest in mesa+libdrm for the
  `modesetting` DDX (needed if we ever want GL apps / a real browser).
- Startup: how X gets launched (xinit/startx vs a runit service) and whether
  it's opt-in at boot.
