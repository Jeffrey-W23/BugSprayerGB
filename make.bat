c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o player.o player.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o enemies.o enemies.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o hud.o hud.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o save.o save.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o main.o main.c
c:\gbdk2020\bin\lcc -Wm-yt3 -o BugSprayer main.o player.o enemies.o hud.o save.o
c:\gbdk2020\bin\lcc -Wm-yt3 -Wm-yoA -Wm-ya1 -o BugSprayer.gb main.o player.o enemies.o hud.o save.o