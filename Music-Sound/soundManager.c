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
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86;
}

//--------------------------------------------------------------------------------------
// PlayEnemyDeathSound: Play the sound associated with the enemies death.
//--------------------------------------------------------------------------------------
void PlayEnemyDeathSound(void)
{
    hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

    // Play enemy death sound.
    NR21_REG = 0x84; NR22_REG = 0x26; NR23_REG = 0x2D; NR24_REG = 0x81;
    NR41_REG = 0x05; NR41_REG = 0xA7; NR41_REG = 0xC0; NR41_REG = 0xC0;

    hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
}

//--------------------------------------------------------------------------------------
// PlayPlayerDamageSound: Play the sound associated with the player damage.
//--------------------------------------------------------------------------------------
void PlayPlayerDamageSound(void)
{
    hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

    // Play damage sounmd for player.
    NR10_REG = 0x0D; NR11_REG = 0xC2; NR12_REG = 0x54; NR13_REG = 0x63; NR14_REG = 0x82;

    hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
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
