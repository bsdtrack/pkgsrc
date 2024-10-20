$NetBSD: patch-buildconfig_config__unix.py,v 1.6 2024/09/16 19:14:46 adam Exp $

Detect X11R6 or X11R7; avoid localbase overriding search.
Use correct libpng.
Disable portmidi and porttime; porttime is a part of portmidi.

--- buildconfig/config_unix.py.orig	2024-06-25 13:53:00.473051000 +0000
+++ buildconfig/config_unix.py
@@ -140,8 +140,8 @@ def main(auto_config=False):
     global origincdirs, origlibdirs
 
     #these get prefixes with '/usr' and '/usr/local' or the $LOCALBASE
-    origincdirs = ['/include', '/include/SDL2']
-    origlibdirs = ['/lib', '/lib64', '/X11R6/lib']
+    origincdirs = ['/include', '/include/SDL2', '/X11R6/include', '/X11R7/include']
+    origlibdirs = ['/lib', '/lib64', '/X11R6/lib', '/X11R7/lib']
 
     # If we are on a debian based system, we also need to handle
     # /lib/<multiarch-tuple>
@@ -226,14 +226,12 @@ def main(auto_config=False):
         #Dependency('GFX', 'SDL_gfxPrimitives.h', 'libSDL2_gfx.so', ['SDL2_gfx']),
     ]
     DEPS.extend([
-        Dependency('PNG', 'png.h', 'libpng', ['png']),
+        Dependency('PNG', 'png.h', 'libpng16', ['png']),
         Dependency('JPEG', 'jpeglib.h', 'libjpeg', ['jpeg']),
         Dependency('SCRAP', '', 'libX11', ['X11']),
         #Dependency('GFX', 'SDL_gfxPrimitives.h', 'libSDL_gfx.so', ['SDL_gfx']),
     ])
-    is_freebsd = 'FreeBSD' in platform.system()
-    is_hurd = platform.system() == 'GNU'
-    if not is_freebsd and not is_hurd:
+    if False:
         porttime_dep = get_porttime_dep()
         DEPS.append(
             Dependency('PORTMIDI', 'portmidi.h', 'libportmidi.so', ['portmidi'])
