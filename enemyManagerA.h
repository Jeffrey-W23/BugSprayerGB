//--------------------------------------------------------------------------------------
// Purpose: Header class for the EnemiesManager object for GameMode A. This manager is
// used to spawn enemy objects in scene for the desired gamemode.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef ENEMYMANAGERA_H
#define ENEMYMANAGERA_H

// includes, using, etc
#include <gb/gb.h>

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for magic numbers used through out spawn logic.
#define SPAWN_QUEUE_SIZEA 100
#define ROUND_KILL_THRESHOLD 100
#define SPEED_STEPS 5
#define SPAWN_STEPS 4
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitiateSpawner: Initiate the spawner for this gameMode.
//--------------------------------------------------------------------------------------
void InitiateSpawner(void);

//--------------------------------------------------------------------------------------
// RefillQueue: Refill the spawn queue after a complete round. 
//
// How The Queue Works:
// The queue works in ticks, each tick will either be an enemy or a break. Enemies are
// randomly assigned a lane and type, and then a break applies depending on what type of 
// enemy. The queue also support groups of enemies, which will still have their breaks
// based on the above system but will also have their own rules. During a group of enemies
// no one enemy in a row will share the same lane, and a break will be applied between
// each group depending on how many enemies are within. This system has made a satisfying
// spawner that feels fair but challenging.
//
// Legend For Break Logic:.
//
// - Type 0:        1 Breaks.
// - Type 1:        2 Breaks.
// - Type 2:        3 Breaks.
// - Group 1-3:     4 Breaks.
// - Group 4:       8 Breaks.
//
// Examples Of How It Works:
// 
// Enemy Group 1:               Enemy Group 2:
// - ID0 = Type0 : Lane0        - ID0 = Type0 : Lane0
// - ID1 = Type2 : Lane2        - ID1 = Type2 : Lane2
// - ID2 = Type0 : Lane1
// - ID3 = Type1 : Lane2
//
// Result In Queue (0 is Break, 1 is Entry): 
//
// ID0   ID1         ID2   ID3                              ID0   ID1
// [1][B][1][B][B][B][1][B][1][B][B][B][B][B][B][B][B][B][B][1][0][1][B][B][B]
//--------------------------------------------------------------------------------------
void RefillQueue(void);

//--------------------------------------------------------------------------------------
// TickSpawner: Move the spawner into the next tick, used to time spawns and breaks.
//--------------------------------------------------------------------------------------
void TickSpawner(void);

//--------------------------------------------------------------------------------------
// IncreaseRoundDifficulty: Slightly increase the difficulty each kill throughout round.
//--------------------------------------------------------------------------------------
void IncreaseRoundDifficulty(UINT16 nTotalKills);

//--------------------------------------------------------------------------------------
// AdvanceRound: Progress the spawner to the next round, increasing the overall difficulty.
//--------------------------------------------------------------------------------------
void AdvanceRound(void);

//--------------------------------------------------------------------------------------
// SpawnEnemyInLane: Spawn a new Enemy in the scene in one of 3 lanes.
//--------------------------------------------------------------------------------------
void SpawnEnemyInLane(UINT8 nLane, UINT8 nType);

//--------------------------------------------------------------------------------------
// GetCurrentSpeedMultiplier: Get the current speed during a round.
//
// Returns:
//      UINT8: Returns unsigned int 8 for the current speed.
//--------------------------------------------------------------------------------------
UINT8 GetCurrentSpeedMultiplier(void);

//--------------------------------------------------------------------------------------
// GetCurrentSpawnMultiplier: Get the current spawn rate during a round.
//
// Returns:
//      UINT8: Returns unsigned int 8 for the current spawn rate.
//--------------------------------------------------------------------------------------
UINT8 GetCurrentSpawnMultiplier(void);

//--------------------------------------------------------------------------------------
// ShouldSpawnThisTick: Check if an Enemy can spawn in the current spawner tick.
//
// Returns:
//      BOOLEAN: Returns if this tick allows new spawn.
//--------------------------------------------------------------------------------------
BOOLEAN ShouldSpawnThisTick(void);

//--------------------------------------------------------------------------------------
// GetNextSpawn: Gets the next entry in the queue at the next spawner tick.
//
// Returns:
//      UINT8: Returns unsigned int 8 for what the next spawn will be in queue.
//--------------------------------------------------------------------------------------
UINT8 GetNextSpawn(void);

//--------------------------------------------------------------------------------------
// GetNextSpawnType: Gets the next entry type in the queue at the next spawner tick.
//
// Returns:
//      UINT8: Returns unsigned int 8 for what the next spawn type will be in queue.
//--------------------------------------------------------------------------------------
UINT8 GetNextSpawnType(void);

// Close the Header.
#endif
