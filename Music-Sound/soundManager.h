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

//--------------------------------------------------------------------------------------
// PlayStartSound: Play the main sound used when dismissing the start screen.
//--------------------------------------------------------------------------------------
void PlayStartSound(void);

//--------------------------------------------------------------------------------------
// PlayEnemyDeathSound: Play the sound associated with the enemies death.
//--------------------------------------------------------------------------------------
void PlayEnemyDeathSound(void);

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

// Close the Header.
#endif