//--------------------------------------------------------------------------------------
// Purpose: Header class for the Enemies object. Used for storing the current enemies
// array, and other global values applied to all enemies.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef ENEMIES_H
#define ENEMIES_H

// includes, using, etc
#include <gb/gb.h>
#include "enemy.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for magic numbers used through out spawn logic.
#define MAX_ENEMIES 16

// New unsigned int 8 for storing the next avaliable spriteID, used during spawning.
extern UINT8 m_nNextSpriteID;

// New array of Enemy struct, used to store and manager all enemies currently active.
extern Enemy m_aoEnemies[];

// New unsigned int 8 for the current speed of all enemies in the game.
extern UINT8 m_nCurrentSpeed;

// New unsigned int 16 for tracking the total enemies killed in the game.
extern UINT16 m_nTotalKilled ;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// GetSprite: Get an enemy sprite set starting position in the sprite sheet, based
// on a random number to determine which bug to display.
//
// Params:
//      nRandNumber: The random number for getting a bug type.
//
// Returns:
//      INT8: Returns the starting sprite number based on random.
//--------------------------------------------------------------------------------------
INT8 GetSprite(INT8 nRandNumber);

//--------------------------------------------------------------------------------------
// KillAllEnemies: Start initial steps to Kill all enemies currently alive in the scene.
//--------------------------------------------------------------------------------------
void KillAllEnemies(void);

//--------------------------------------------------------------------------------------
// CompleteKillAllEnemies: Complete the kill all enemies currently alive in the scene.
//--------------------------------------------------------------------------------------
void CompleteKillAllEnemies(void);

// Close the Header.
#endif
