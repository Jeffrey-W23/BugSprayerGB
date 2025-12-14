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
#include "../Entities/player.h"

//--------------------------------------------------------------------------------------
// Enemy struct for setting the main information needed for building the enemies.
//--------------------------------------------------------------------------------------
typedef struct 
{
    UINT8 nX; 
    UINT8 nY;
    UINT8 nSpriteID;
    BOOLEAN bAlive;
    INT8 nDirX;
    INT8 nDirY;
    BOOLEAN bCantMove;
    UINT8 nSpeed;
    UINT8 nIndex;
    UINT8 nSubPixelX;
    UINT8 nSubPixelY;
    UINT8 nSpriteNumber;
    BOOLEAN bMainSpriteSet;
    BOOLEAN bHitByBullet;
    UINT8 nType;
    UINT8 nState;
    UINT8 nTargetX;
    UINT8 nEnterCounter;
} Enemy;

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for magic numbers used through out spawn logic.
#define MAX_ENEMIES 16
#define SPRITE_SHEET_EMPTY_SLOT 81

// New unsigned int 8 for storing the next avaliable spriteID, used during spawning.
extern UINT8 m_nNextSpriteID;

// New array of Enemy struct, used to store and manager all enemies currently active.
extern Enemy m_aoEnemies[];

// New unsigned int 8 for the current speed of all enemies in the game.
extern UINT8 m_nCurrentSpeed;

// New unsigned int 16 for tracking the total enemies killed in the game.
extern UINT16 m_nTotalKilled;

// New unsigned int 8 value for storing the sprite id of the enemyt that hurt the player.
extern UINT8 m_bEnemyHurtPlayer;

// New bool value for if the kill auido has been requested for playing.
extern BOOLEAN m_bPlayKillSoundEffect;

// New bool value for if we need to show the spray affect from the player.
extern BOOLEAN m_bShowSpray;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitEnemies: Initiate an Enemy object, updating all its stats and information.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//--------------------------------------------------------------------------------------
void InitEnemy(UINT8 nEnemyIndex);

//--------------------------------------------------------------------------------------
// UpdateEnemyModeA: Update an Enemy object, updating position and status based on inputs.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdateEnemyModeA(UINT8 nEnemyIndex, Player* ptrPlayer);

//--------------------------------------------------------------------------------------
// UpdateEnemyModeB: Update an Enemy object, updating position and status based on inputs.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdateEnemyModeB(UINT8 nEnemyIndex, Player* ptrPlayer);

//--------------------------------------------------------------------------------------
// KillEnemy: Kill an Enemy object, marking its position in the array as free.
//
// Params:
//      bDoesPlayerScore: Does the player score from this kill?
//      ptrEnemy: Pointer to the current enemy getting killed.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void KillEnemy(BOOLEAN bDoesPlayerScore, Enemy* ptrEnemy, Player* ptrPlayer);

//--------------------------------------------------------------------------------------
// IsEnemyAlive: Check the status of an Enemy object.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//
// Returns:
//      BOOLEAN: Returns the alive status of the passed enemy index.
//--------------------------------------------------------------------------------------
BOOLEAN IsEnemyAlive(UINT8 nEnemyIndex);

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
