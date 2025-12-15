//--------------------------------------------------------------------------------------
// Purpose: Header class for the SoundManager object. Used to play sounds throughout
// the game. Declare audio here once to save ROM space.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef SOUNDMANAGER_H
#define SOUNDMANAGER_H

// includes, using, etc
#include <gb/gb.h>
#include "hUGEDriver.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New const huge song variable for the main song file of the game.
extern const hUGESong_t m_sSong1;

// New const huge song variable for the lose lifge song file of the game.
extern const hUGESong_t m_sLoseLife;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// PlayStartSound: Play the main sound used when dismissing the start screen.
//--------------------------------------------------------------------------------------
void PlayStartSound(void);

//--------------------------------------------------------------------------------------
// PlayStartSoundReversed: Play the main sound used when dismissing the start 
// screen, but reversed.
//--------------------------------------------------------------------------------------
void PlayStartSoundReversed(void);

//--------------------------------------------------------------------------------------
// PlayPlayerDamageSound: Play the sound associated with the player damage.
//--------------------------------------------------------------------------------------
void PlayPlayerDamageSound(void);

//--------------------------------------------------------------------------------------
// PlayGameOverSound: Play the sound associated with the players death.
//--------------------------------------------------------------------------------------
void PlayPlayerDeathSound(void);

//--------------------------------------------------------------------------------------
// PlaySplashScreenSound: Play the sound associated with the splashscreen.
//--------------------------------------------------------------------------------------
void PlaySplashScreenSound(void);

//--------------------------------------------------------------------------------------
// PlayGameOverSound: Play the sound associated with the gameover sequence.
//--------------------------------------------------------------------------------------
void PlayGameOverSound(void);

//--------------------------------------------------------------------------------------
// PlayButtonMoveSound: Play the sound associated with the joypad movement in menus
//--------------------------------------------------------------------------------------
void PlayButtonMoveSound(void);

//--------------------------------------------------------------------------------------
// PlayBonkSound: Play the sound associated with being unable to move in a menu.
//--------------------------------------------------------------------------------------
void PlayBonkSound(void);

//--------------------------------------------------------------------------------------
// PlayLifeSpawnSound: Play the sound associated with an extra life spawning.
//--------------------------------------------------------------------------------------
void PlayLifeSpawnSound(void);

//--------------------------------------------------------------------------------------
// PlayKillAllEnemySound: Play the sound associated with all enemies on screen dying.
//--------------------------------------------------------------------------------------
void PlayKillAllEnemySound(void);

//--------------------------------------------------------------------------------------
// PlayEnemySpawnSoundA: Play the sound associated with enemies flying into scene for mode A
//--------------------------------------------------------------------------------------
void PlayEnemySpawnSoundA(void);

//--------------------------------------------------------------------------------------
// PlayLifeCollectSound: Play the sound associated with collecting the extra life.
//--------------------------------------------------------------------------------------
void PlayLifeCollectSound(void);

//--------------------------------------------------------------------------------------
// PlayHealthRecoverSound: Play the sound associated with health regen in gamemode B
//--------------------------------------------------------------------------------------
void PlayHealthRecoverSound(void);

// Close the Header.
#endif