//--------------------------------------------------------------------------------------
// Purpose: Header class for the Enemy object. Used for setting and updating the enemies
// sprite, positions, and statuses.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef ENEMY_H
#define ENEMY_H

// includes, using, etc
#include <gb/gb.h>
#include "player.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 8 value for storing the sprite id of the enemyt that hurt the player.
extern UINT8 m_bEnemyHurtPlayer;

// New bool value for if the kill auido has been requested for playing.
extern BOOLEAN m_bPlayKillSoundEffect;

// New bool value for if we need to show the spray affect from the player.
extern BOOLEAN m_bShowSpray;
//--------------------------------------------------------------------------------------

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

// Close the Header.
#endif