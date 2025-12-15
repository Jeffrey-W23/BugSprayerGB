//--------------------------------------------------------------------------------------
// Purpose: Header class for the Gamemodes object. Used as the main game manager,
// controlling and updated a selected gamemodes main game logic.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef GAMEMODES_H
#define GAMEMODES_H

// includes, using, etc
#include "../Data-Systems/save.h"
#include <gb/gb.h>

//--------------------------------------------------------------------------------------
// InitializeGamemode: Initialize and prepare the desired gamemode.
//
// Params:
//      bMode: The gamemode to be initialized.
//      bDiff: The difficulty of the gamemode.
//--------------------------------------------------------------------------------------
void InitializeGamemode(BYTE bMode, BYTE bDiff);

//--------------------------------------------------------------------------------------
// SetScoreOnHud: Universal mode for both modes, updates the score on the
// hud if the score is changed since last frame.
//--------------------------------------------------------------------------------------
void SetScoreOnHud(void);

//--------------------------------------------------------------------------------------
// AnimatePie: Animate the pie object each frame in the background of gamemode A.
//--------------------------------------------------------------------------------------
void AnimatePie(void);

//--------------------------------------------------------------------------------------
// UpdateExtraLife: Update logic around the extra life system for gamemode A.
//--------------------------------------------------------------------------------------
void UpdateExtraLife(void);

//--------------------------------------------------------------------------------------
// PauseGame: Main logic needed to pause and unpause the gameplay.
//--------------------------------------------------------------------------------------
void PauseGame(void);

//--------------------------------------------------------------------------------------
// SetupPauseCursor: Prepare a new cursor to use for the pause menu.
//--------------------------------------------------------------------------------------
void SetupPauseCursor(void);

//--------------------------------------------------------------------------------------
// UpdatePauseMenu: Update method for the slid down pause menu.
//--------------------------------------------------------------------------------------
void UpdatePauseMenu(void);

//--------------------------------------------------------------------------------------
// PrepareGameOver: Prepare the gameover screen, updating highscore data and showing UI.
//--------------------------------------------------------------------------------------
void PrepareGameOver(void);

//--------------------------------------------------------------------------------------
// UpdateEnemies: Update all the enemies currently alive in the scene.
//--------------------------------------------------------------------------------------
void UpdateEnemies(BYTE bMode);

//--------------------------------------------------------------------------------------
// UpdateLoopGameModeA: Main game loop for the top of screen gamemode.
//--------------------------------------------------------------------------------------
void UpdateLoopGameModeA(void);

//--------------------------------------------------------------------------------------
// UpdateLoopGameModeB: Main game loop for the middle of screen shooting gamemode.
//--------------------------------------------------------------------------------------
void UpdateLoopGameModeB(void);

// Close the Header.
#endif