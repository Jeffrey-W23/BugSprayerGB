//--------------------------------------------------------------------------------------
// Purpose: Header class for the Enemies object. Used for setting and updating the enemies
// sprite, positions, and statuses.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef ENEMIES_H
#define ENEEMIES_H

// includes, using, etc
#include <gb/gb.h>
#include "player.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for magic numbers used through out spawn logic.
#define MAX_ENEMIES 16
#define NUM_SPAWNPOINTS 8
#define SPAWN_QUEUE_SIZE 64
#define MAX_SPEED 8

// New unsigned int 8 for keeping track of the current spawn tick.
extern UINT8 m_nSpawnTimer;

// New unsigned int 8 for keeping track of the current spawn delay for all enemies.
extern UINT8 m_nSpawnDelay;

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
} Enemy;

//--------------------------------------------------------------------------------------
// InitEnemiesSpawnQueue: Prepare the spawn queue before starting the game. This uses
// random number generation, then a shuffle and then checks to ensure no long streaks, 
// which can result in some slow down depending on RNG.
//--------------------------------------------------------------------------------------
void InitEnemiesSpawnQueue(void);

//--------------------------------------------------------------------------------------
// GetNextSpawnIndex: Get the next spawn position in the queue.
//
// Returns:
//      UINT8: Returns unsigned int 8 for the index for the next spawn pos.
//--------------------------------------------------------------------------------------
UINT8 GetNextSpawnIndex(void);

//--------------------------------------------------------------------------------------
// InitEnemies: Initiate an Enemy object, updating all its stats and information.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//--------------------------------------------------------------------------------------
void InitEnemy(UINT8 nEnemyIndex);

//--------------------------------------------------------------------------------------
// SpawnEnemy: Spawn an Enemy in the scene.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      nSpawnIndex: The spawn position to spawn this enemy.
//--------------------------------------------------------------------------------------
void SpawnEnemy(UINT8 nEnemyIndex, UINT8 nSpawnIndex);

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
// UpdateEnemy: Update an Enemy object, updating position and status based on inputs.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdateEnemy(UINT8 nEnemyIndex, Player* ptrPlayer);

//--------------------------------------------------------------------------------------
// KillEnemy: Kill an Enemy object, marking its position in the array as free.
//
// Params:
//      ptrEnemy: Pointer to the current enemy getting killed.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void KillEnemy(Enemy* ptrEnemy, Player* ptrPlayer);

//--------------------------------------------------------------------------------------
// IncreaseDifficulty: Increase the spawn rate and speed of enemies based on progress.
//
// Param:
//      nDamgeToPlayer: The damage value to apply to the player.
//--------------------------------------------------------------------------------------
void IncreaseDifficulty(UINT8 nDamgeToPlayer);

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
// SpawnNext: Attempt to spawn a new Enemy object in the scene.
//--------------------------------------------------------------------------------------
void SpawnNext(void);

//--------------------------------------------------------------------------------------
// TickSpawnTimer: Tick the spawn timer used for checking when to spawn new enemies.
//--------------------------------------------------------------------------------------
void TickSpawnTimer(void);

// Close the Header.
#endif