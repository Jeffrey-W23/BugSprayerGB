//--------------------------------------------------------------------------------------
// Purpose: Header class for the EnemiesManager object for GameMode B. This manager is
// used to spawn enemy objects in scene for the desired gamemode.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef ENEMYMANAGERB_H
#define ENEMYMANAGERB_H

// includes, using, etc
#include <gb/gb.h>
#include "../Entities/player.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 8 for keeping track of the current spawn tick.
extern UINT8 m_nSpawnTimer;

// New unsigned int 8 for keeping track of the current spawn delay for all enemies.
extern UINT8 m_nSpawnDelay;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitEnemiesSpawnQueue: Prepare the spawn queue before starting the game. This uses
// random number generation, then a shuffle and then checks to ensure no long streaks, 
// which can result in some slow down depending on RNG.
//--------------------------------------------------------------------------------------
void InitEnemiesSpawnQueue(void);

//--------------------------------------------------------------------------------------
// SetInitDifficulty: Set the inital difficulty of the gamemode based on Easy or Hard.
//
// Params:
//      bDiff: The difficulty setting select, 0 meaning easy mode.
//--------------------------------------------------------------------------------------
void SetInitDifficulty(BYTE bMode);

//--------------------------------------------------------------------------------------
// GetNextSpawnIndex: Get the next spawn position in the queue.
//
// Returns:
//      UINT8: Returns unsigned int 8 for the index for the next spawn pos.
//--------------------------------------------------------------------------------------
UINT8 GetNextSpawnIndex(void);

//--------------------------------------------------------------------------------------
// SpawnEnemyOnEdge: Spawn an Enemy in the scene from one of 8 edges.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      nSpawnIndex: The spawn position to spawn this enemy.
//--------------------------------------------------------------------------------------
void SpawnEnemyOnEdge(UINT8 nEnemyIndex, UINT8 nSpawnIndex);

//--------------------------------------------------------------------------------------
// IncreaseDifficulty: Increase the spawn rate and speed of enemies based on progress.
//
// Param:
//      nDamgeToPlayer: The damage value to apply to the player.
//--------------------------------------------------------------------------------------
void IncreaseDifficulty(UINT8* nDamgeToPlayer);

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