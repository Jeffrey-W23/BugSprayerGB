@echo off
echo Building BugSprayer ROM...

set GBDK=c:\gbdk2020
set LCC=%GBDK%\bin\lcc
set HUGEDIR=hugedriver

REM
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Gamemodes\gamemodes.o Gamemodes\gamemodes.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Data-Systems\helpers.o Data-Systems\helpers.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o UI\menuScreens.o UI\menuScreens.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Music-Sound\soundManager.o Music-Sound\soundManager.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Entities\player.o Entities\player.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Entities\enemies.o Entities\enemies.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Gamemodes\enemyManagerA.o Gamemodes\enemyManagerA.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Gamemodes\enemyManagerB.o Gamemodes\enemyManagerB.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o UI\hud.o UI\hud.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Data-Systems\save.o Data-Systems\save.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Music-Sound\song1.o Music-Sound\song1.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o Music-Sound\loseLife.o Music-Sound\loseLife.c
%LCC% -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -I%HUGEDIR%/include -c -o main.o main.c

REM
REM
REM

REM
%LCC% -Wm-yt0x03 -Wm-yo2 -Wm-ya1 -autobank -Wl-j -Wl-l%HUGEDIR%/gbdk/hUGEDriver.lib -o BugSprayer.gb ^
  main.o ^
  Gamemodes\gamemodes.o ^
  Data-Systems\helpers.o ^
  UI\menuScreens.o ^
  Music-Sound\soundManager.o ^
  Entities\player.o ^
  Entities\enemies.o ^
  Gamemodes\enemyManagerA.o ^
  Gamemodes\enemyManagerB.o ^
  UI\hud.o ^
  Data-Systems\save.o ^
  Music-Sound\song1.o ^
  Music-Sound\loseLife.o

REM
REM
REM

echo.
echo Success, BugSprayer.gb created!
pause
