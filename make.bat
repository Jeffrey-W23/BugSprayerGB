@echo off
echo Building BugSprayer ROM ...

REM Compile your source files WITH include path
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o player.o player.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o enemies.o enemies.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o hud.o hud.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o save.o save.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o song1.o song1.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o main.o main.c

REM Link with hUGEDriver library
c:\gbdk2020\bin\lcc -Wm-yt3 -Wl-lhugedriver/gbdk/hUGEDriver.lib -o BugSprayer main.o player.o enemies.o hud.o save.o song1.o

REM Final ROM
c:\gbdk2020\bin\lcc -Wm-yt3 -Wm-yoA -Wm-ya1 -Wl-lhugedriver/gbdk/hUGEDriver.lib -o BugSprayer.gb main.o player.o enemies.o hud.o save.o song1.o

echo Done! BugSprayer.gb created.
pause
