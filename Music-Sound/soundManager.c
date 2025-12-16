//--------------------------------------------------------------------------------------
// Purpose: SoundManager object. Used to play sounds throughout the game. Declare 
// audio here once to save ROM space.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "../Music-Sound/soundManager.h"
#include "../Data-Systems/helpers.h"
#include "hUGEDriver.h"

//--------------------------------------------------------------------------------------
// PlayStartSound: Play the main sound used when dismissing the start screen.
//--------------------------------------------------------------------------------------
void PlayStartSound(void)
{
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86;
}

//--------------------------------------------------------------------------------------
// PlayStartSoundReversed: Play the main sound used when dismissing the start 
// screen, but reversed.
//--------------------------------------------------------------------------------------
void PlayStartSoundReversed(void)
{
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86;
}

//--------------------------------------------------------------------------------------
// PlayPlayerDamageSound: Play the sound associated with the player damage.
//--------------------------------------------------------------------------------------
void PlayPlayerDamageSound(void)
{
    // Play damage sounmd for player.
    NR10_REG = 0x4B; NR11_REG = 0x98; NR12_REG = 0x63; NR13_REG = 0xFB; NR14_REG = 0x80;
    NR21_REG = 0x4E; NR22_REG = 0x63; NR23_REG = 0xFE; NR24_REG = 0x80;
}

//--------------------------------------------------------------------------------------
// PlayGameOverSound: Play the sound associated with the players death.
//--------------------------------------------------------------------------------------
void PlayPlayerDeathSound(void)
{
    // Play death sound.
    NR41_REG = 0x15; NR42_REG = 0xFF; NR43_REG = 0x73; NR44_REG = 0xC0;
}

//--------------------------------------------------------------------------------------
// PlaySplashScreenSound: Play the sound associated with the splashscreen.
//--------------------------------------------------------------------------------------
void PlaySplashScreenSound(void)
{
    // Play the splash screen sound
    NR10_REG = 0x78; NR11_REG = 0x81; NR12_REG = 0x42; NR13_REG = 0x9E; NR14_REG = 0x87; PerformantDelay(10);
    NR10_REG = 0x78; NR11_REG = 0x81; NR12_REG = 0x42; NR13_REG = 0x72; NR14_REG = 0x86; PerformantDelay(8);
    NR10_REG = 0x78; NR11_REG = 0x81; NR12_REG = 0x42; NR13_REG = 0xAA; NR14_REG = 0x85;
}

//--------------------------------------------------------------------------------------
// PlayGameOverSound: Play the sound associated with the gameover sequence.
//--------------------------------------------------------------------------------------
void PlayGameOverSound(void)
{
    // Play the gameover jingle note by note.
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84; PerformantDelay(15);
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84; PerformantDelay(15);
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x20; NR14_REG = 0x83; PerformantDelay(15);
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x20; NR14_REG = 0x83; PerformantDelay(15);
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x78; NR14_REG = 0x85; PerformantDelay(15);
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84; PerformantDelay(15);
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x90; NR14_REG = 0x81; PerformantDelay(15);
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x78; NR14_REG = 0x85;
}

//--------------------------------------------------------------------------------------
// PlayButtonMoveSound: Play the sound associated with the joypad movement in menus
//--------------------------------------------------------------------------------------
void PlayButtonMoveSound(void)
{
    // Play the button dinging sound.
    NR10_REG = 0x00; NR11_REG = 0x81; NR12_REG = 0x43; NR13_REG = 0x73; NR14_REG = 0x86; PerformantDelay(3);
}

//--------------------------------------------------------------------------------------
// PlayBonkSound: Play the sound associated with being unable to move in a menu.
//--------------------------------------------------------------------------------------
void PlayBonkSound(void)
{
    // Play the button dinging sound.
    NR10_REG = 0x7A; NR11_REG = 0x81; NR12_REG = 0x43; NR13_REG = 0x73; NR14_REG = 0x86;
}

//--------------------------------------------------------------------------------------
// PlayLifeSpawnSound: Play the sound associated with an extra life spawning.
//--------------------------------------------------------------------------------------
void PlayLifeSpawnSound(void)
{
    // Play the sound for life spawn.
    NR10_REG = 0x25; NR11_REG = 0xC9; NR12_REG = 0x78; NR13_REG = 0x71; NR14_REG = 0x84;
    NR21_REG = 0xC5; NR22_REG = 0x94; NR23_REG = 0x9E; NR24_REG = 0x85;
}

//--------------------------------------------------------------------------------------
// PlayKillAllEnemySound: Play the sound associated with all enemies on screen dying.
//--------------------------------------------------------------------------------------
void PlayKillAllEnemySound(void)
{
    // Play the sound for expolding all enemies.
    NR41_REG = 0x2B; NR42_REG = 0x87; NR43_REG = 0x66; NR44_REG = 0x80;
}

//--------------------------------------------------------------------------------------
// PlayLifeCollectSound: Play the sound associated with collecting the extra life.
//--------------------------------------------------------------------------------------
void PlayLifeCollectSound(void)
{
    // Play the sound for life collection.
    NR21_REG = 0xD2; NR22_REG = 0xA2; NR23_REG = 0xD3; NR24_REG = 0x86;
    NR21_REG = 0xD2; NR22_REG = 0xA2; NR23_REG = 0x37; NR24_REG = 0x87;
    PerformantDelay(3);
    NR21_REG = 0xD2; NR22_REG = 0xA2; NR23_REG = 0x9B; NR24_REG = 0x87;
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86;
}

//--------------------------------------------------------------------------------------
// PlayHealthRecoverSound: Play the sound associated with health regen in gamemode B
//--------------------------------------------------------------------------------------
void PlayHealthRecoverSound(void)
{
    // Play the sound for life collection.
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x24; NR14_REG = 0x84;
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x88; NR14_REG = 0x85;
    //NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xEC; NR14_REG = 0x85;
    PerformantDelay(3);
}
