@echo off
echo Building BugSprayer ROM ...

REM
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o Entities/player.o Entities/player.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o Entities/enemies.o Entities/enemies.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o Gamemodes/enemyManagerA.o Gamemodes/enemyManagerA.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o Gamemodes/enemyManagerB.o Gamemodes/enemyManagerB.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o UI/hud.o UI/hud.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o Data-Systems/save.o Data-Systems/save.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o Music-Sounds/song1.o Music-Sounds/song1.c
c:\gbdk2020\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Ihugedriver/include -c -o main.o main.c

REM
c:\gbdk2020\bin\lcc -Wm-yt3 -Wl-lhugedriver/gbdk/hUGEDriver.lib -o BugSprayer main.o Entities/player.o Entities/enemies.o Gamemodes/enemyManagerA.o Gamemodes/enemyManagerB.o UI/hud.o Data-Systems/save.o Music-Sounds/song1.o

REM
c:\gbdk2020\bin\lcc -Wm-yt3 -Wm-yoA -Wm-ya1 -Wl-lhugedriver/gbdk/hUGEDriver.lib -o BugSprayer.gb main.o Entities/player.o Entities/enemies.o Gamemodes/enemyManagerA.o Gamemodes/enemyManagerB.o UI/hud.o Data-Systems/save.o Music-Sounds/song1.o

echo Done! BugSprayer.gb created.
pause
