//--------------------------------------------------------------------------------------
// Purpose: EnemiesManager object for GameMode A. This manager is used to spawn 
// enemy objects in scene for the desired gamemode.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#include "../Gamemodes/enemyManagerA.h"
#include <stdio.h>
#include <stdlib.h>
#include <gb/gb.h>
#include <rand.h>
#include "../Entities/enemies.h"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for magic numbers used through out spawn logic.
#define SPAWN_QUEUE_SIZEA 100
#define ROUND_KILL_THRESHOLD 100
#define SPEED_STEPS 5
#define SPAWN_STEPS 4

// New unsigned int 8 for keeping track of the current sub tick to make a single spawn tick.
static UINT8 m_nSubTickCounter = 0;

// New bool value for if the current spawn tick has completed.
static BOOLEAN m_bNewTick = FALSE;

// New array of unsigned int 8s for the spawn queue.
static UINT8 m_anQueue[SPAWN_QUEUE_SIZEA] = {0};

// New array of unsigned int 8s for the spawn type queue.
static UINT8 m_anQueueType[SPAWN_QUEUE_SIZEA] = {0};

// New unsigned int 8 for the current position in the queues.
static UINT8 m_nCurrentQueuePos = 0;

// New unsigned int 8 for the current round.
static UINT8 m_nCurrentRound = 0;

// New unsigned int 8 for the current speed step, used to determine speed during a round.
static UINT8 m_nCurrentSpeedStep = 0;

// New unsigned int 8 for the current spawn step, used to determine spawn rate during a round.
static UINT8 m_nCurrentSpawnStep = 0;

// New unsigned int 8 for the current speed position, used for getting all the speed values for a set round.
static UINT8 m_nCurrentRoundSpeedsPos = 0;

// New unsigned int 8 for the current spawn rate position, used for getting all the spawn rate values for a set round.
static UINT8 m_nCurrentRoundSpawnRatesPos = 0;

// New unsigned int 8 for the current random number seed for this manager.
static UINT32 m_nSeed = 1;

// New private array of unsigned int 8 for spawn positions/directions.
static const UINT8 m_anSpawnPositionsMode1[3] = 
{
    {56},   // LEFT
    {84},   // MIDDLE 
    {112}   // RIGHT
};

// Each enemy will have a base speed based on
// their enemy type randomly assigned during queuing.
const UINT8 m_anBaseSpeeds[3] = {5, 2, 9};

// Const array of unsigned int 8s, used for storing the speed throughout each round.
const UINT8 m_anRoundSpeeds[20][5] = 
{
    {5, 6, 7, 8, 8},        // ROUND 1 (0-100 points)
    {5, 6, 7, 8, 9},        // ROUND 2 (100-200 points)
    {6, 7, 8, 9, 9},        // ROUND 3 (200-300 points)
    {6, 7, 8, 9, 10},       // ROUND 4 (300-400 points)
    {7, 8, 9, 10, 10},      // ROUND 5 (500-600 points)
    {7, 8, 9, 10, 11},      // ROUND 6 (600-700 points)
    {8, 9, 10, 11, 11},     // ROUND 7 (700-800 points)
    {8, 9, 10, 11, 12},     // ROUND 8 (800-900 points)
    {9, 10, 11, 12, 12},    // ROUND 9 (900-1000 points)
    {9, 10, 11, 12, 13},    // ROUND 10 (1000-1100 points)
    {10, 11, 12, 13, 13},   // ROUND 11 (1100-1200 points)
    {10, 11, 12, 13, 14},   // ROUND 12 (1200-1300 points)
    {11, 12, 13, 14, 14},   // ROUND 13 (1300-1400 points)
    {11, 12, 13, 14, 15},   // ROUND 14 (1400-1500 points)
    {12, 13, 14, 15, 15},   // ROUND 15 (1500-1600 points)
    {12, 13, 14, 15, 16},   // ROUND 16 (1600-1700 points)
    {13, 14, 15, 16, 16},   // ROUND 17 (1700-1800 points)
    {13, 14, 15, 16, 17},   // ROUND 18 (1800-1900 points)
    {14, 15, 16, 17, 17},   // ROUND 19 (1900-2000 points)
    {14, 15, 16, 17, 18},   // ROUND 20 (2000-2100 points)
};

// Const array of unsigned int 8s, used for storing the spawn rate throughout each round.
const UINT8 m_anRoundSpawnRates[20][4] = 
{
    {20, 16, 16, 14},       // ROUND 1 (0-100 points)
    {18, 16, 16, 14},       // ROUND 2 (100-200 points)
    {16, 14, 14, 12},       // ROUND 3 (200-300 points)
    {14, 12, 12, 10},       // ROUND 4 (300-400 points)
    {12, 10, 10, 10},       // ROUND 5 (500-600 points)
    {12, 10, 8, 8},         // ROUND 6 (600-700 points)
    {10, 10, 8, 6},         // ROUND 7 (700-800 points)
    {10, 8, 8, 6},          // ROUND 8 (800-900 points)
    {8, 8, 6, 6},           // ROUND 9 (900-1000 points)
    {8, 8, 6, 4},           // ROUND 10 (1000-1100 points)
    {7, 6, 6, 4},           // ROUND 11 (1100-1200 points)
    {7, 6, 5, 4},           // ROUND 12 (1200-1300 points)
    {6, 5, 4, 4},           // ROUND 13 (1300-1400 points)
    {6, 5, 4, 3},           // ROUND 14 (1400-1500 points)
    {5, 5, 4, 3},           // ROUND 15 (1500-1600 points)
    {5, 4, 4, 3},           // ROUND 16 (1600-1700 points)
    {4, 4, 3, 3},           // ROUND 17 (1700-1800 points)
    {4, 4, 3, 2},           // ROUND 18 (1800-1900 points)
    {3, 3, 2, 2},           // ROUND 19 (1900-2000 points)
    {3, 3, 2, 1}            // ROUND 20 (2000-2100 points)
};
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitiateSpawner: Initiate the spawner for this gameMode.
//
// Params:
//      bDiff: The difficulty setting select, 0 meaning easy mode.
//--------------------------------------------------------------------------------------
void InitiateSpawner(BYTE bDiff) 
{
    // Declare variables
    // for later use
    UINT8 i;
    UINT8 o;

    // Reset all values.
    m_nSubTickCounter = 0;
    m_bNewTick = FALSE;
    m_nCurrentQueuePos = 0;
    m_nCurrentRound = 0;
    m_nCurrentSpeedStep = 0;
    m_nCurrentSpawnStep = 0;
    m_nSeed = 1;

    // Set difficulty for Easy
    if (bDiff == 0)
    {
        m_nCurrentRoundSpeedsPos = 0;
        m_nCurrentRoundSpawnRatesPos = 0;
    }

    // Set difficulty for Hard
    else
    {
        m_nCurrentRoundSpeedsPos = 8;
        m_nCurrentRoundSpawnRatesPos = 8;
    }

    // Reset the queue arrays.
    for (i = 0; i < SPAWN_QUEUE_SIZEA; i++) { m_anQueue[i] = 0; }
    for (o = 0; o < SPAWN_QUEUE_SIZEA; o++) { m_anQueueType[o] = 0; }

    // Fill the first rounds spawn queue.
    RefillQueue();
}

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
void RefillQueue(void)
{        
    // Various variables declared
    // for use throughout this method.
    UINT8 i = 0;
    UINT8 o = 0;
    UINT8 b = 0;
    UINT8 nQueueIndex = 0;
    UINT8 nEnemyCount;
    UINT8 nBreakCount;
    UINT8 nEnemyType;
    UINT8 nGroupBreakCount;
    UINT8 nSlot = 1;
    UINT8 nNewLane;
    UINT8 nPrevLane = 0;

    // While loop to ensure we fill the entire queue
    while (nSlot < SPAWN_QUEUE_SIZEA - 1) 
    {
        // Get a random number for how many enemies to spawn in a row.
        nEnemyCount = 1 + (rand() % 4);
        
        // Loop through the amounf of desired enemies. Ensure we dont go over queue length
        for (i = 0; i < nEnemyCount && nSlot < SPAWN_QUEUE_SIZEA - 1; i++) 
        {
            // Get a random lane, but ensure different lane than last enemy
            do { nNewLane = 1 + (rand() % 3); } 
            while (nNewLane == nPrevLane && nEnemyCount > 1);
            
            // Assign lane number to the queue.
            m_anQueue[nSlot] = nNewLane;

            // Assign a random number for the enemyType to type queue.
            m_anQueueType[nSlot] = nEnemyType = rand() % 3;

            // Store the previous lane for next loop through.
            nPrevLane = nNewLane;

            // step to next slot.
            nSlot++;
            
            // Apply a different break between enemies based on what type of enemy.
            nBreakCount = (nEnemyType == 0) ? 1 : (nEnemyType == 1) ? 2 : 3;

            // Loop through the queue and apply the amount of breaks needed.
            for (b = 0; b < nBreakCount && nSlot < SPAWN_QUEUE_SIZEA - 1; b++) 
            {
                m_anQueue[nSlot] = 0;
                m_anQueueType[nSlot] = 0;
                nSlot++;
            }
        }
        
        // Apply a different break between groups of enemies 
        nGroupBreakCount = (nEnemyCount == 4) ? 8 : 4;
        
        // Loop through the queue and apply the amount of group breaks needed
        for (o = 0; o < nGroupBreakCount && nSlot < SPAWN_QUEUE_SIZEA - 1; o++) 
        {
            m_anQueue[nSlot] = 0;
            m_anQueueType[nSlot] = 0;
            nSlot++;
        }
    }
    
    // Set the first and final slot of the queue to breaks
    m_anQueue[0] = 0;
    m_anQueue[SPAWN_QUEUE_SIZEA - 1] = 0;
}

//--------------------------------------------------------------------------------------
// TickSpawner: Move the spawner into the next tick, used to time spawns and breaks.
//--------------------------------------------------------------------------------------
void TickSpawner(void) 
{
    // Decalre variables for later use.    
    UINT8 nSpawnMultiplier;
    
    // progress the spawn sub tick.
    m_nSubTickCounter++;
    
    // Get the current spawn rate for this portion of the round.
    nSpawnMultiplier = GetCurrentSpawnMultiplier();
    
    // If the tick counter meets the multiplier then
    // we have succesfully completed one spawn tick. 
    if (m_nSubTickCounter >= nSpawnMultiplier) 
    {
        // Reset the subTick coutner
        m_nSubTickCounter = 0;

        // Set tick as complete and increase current spawn
        // queue position, spawning the next enemy or a break.
        m_bNewTick = TRUE;
        m_nCurrentQueuePos++;
        
        // If the queue position is over the size of the queue
        // then we are at the end of the queue, rest it and
        // prepare new enemies for the next round.
        if (m_nCurrentQueuePos >= SPAWN_QUEUE_SIZEA) 
        {
            m_nCurrentQueuePos = 0;
            RefillQueue();
        }
    } 
    
    // Else we are still completing a tick.
    else 
    {
        m_bNewTick = FALSE;
    }
}

//--------------------------------------------------------------------------------------
// IncreaseRoundDifficulty: Slightly increase the difficulty each kill throughout round.
//--------------------------------------------------------------------------------------
void IncreaseRoundDifficulty(UINT16 nTotalKills) 
{
    // Determine round progress
    UINT8 nRound = nTotalKills / ROUND_KILL_THRESHOLD;
    UINT16 nKillsInRound;
    
    // Check if the round has finished.
    if (nRound != m_nCurrentRound) 
    {
        // If finished prepare a new round.
        AdvanceRound();
    }
    
    // Calculate diffiuclty movement for current round progress
    nKillsInRound = nTotalKills % ROUND_KILL_THRESHOLD; 
    m_nCurrentSpeedStep = (nKillsInRound * SPEED_STEPS) / ROUND_KILL_THRESHOLD;
    m_nCurrentSpawnStep = (nKillsInRound * SPAWN_STEPS) / ROUND_KILL_THRESHOLD;
}

//--------------------------------------------------------------------------------------
// AdvanceRound: Progress the spawner to the next round, increasing the overall difficulty.
//--------------------------------------------------------------------------------------
void AdvanceRound(void) 
{
    // Progress the round.
    m_nCurrentRound++;
    m_nCurrentRoundSpeedsPos++;
    m_nCurrentRoundSpawnRatesPos++;
    
    // Ensure that if we run out of data for rounds that we keep dificulty where it is
    if (m_nCurrentRoundSpeedsPos >= 20) m_nCurrentRoundSpeedsPos = 19;
    if (m_nCurrentRoundSpawnRatesPos >= 20) m_nCurrentRoundSpawnRatesPos = 19;
}

//--------------------------------------------------------------------------------------
// SpawnEnemyInLane: Spawn a new Enemy in the scene in one of 3 lanes.
//--------------------------------------------------------------------------------------
void SpawnEnemyInLane(UINT8 nLane, UINT8 nType) 
{    
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;

    // First first dead enemy in the enemies array
    for (i = 0; i < MAX_ENEMIES; i++) 
    {
        if (!m_aoEnemies[i].bAlive) break;
    }

    // If all slots are full than return
    // Cant spawn a new enemy right now.
    if (i >= MAX_ENEMIES) return;

    // Get the current enemy being updated.
    Enemy* ptrEnemy = &m_aoEnemies[i];
    
    // Set initial values needed for a new Enemy object.
    ptrEnemy->bAlive = TRUE;
    ptrEnemy->nType = nType;
    ptrEnemy->nState = 0;
    ptrEnemy->nTargetX = m_anSpawnPositionsMode1[nLane - 1];
    ptrEnemy->bCantMove = FALSE;
    ptrEnemy->bMainSpriteSet = FALSE;
    ptrEnemy->nX = 160;
    ptrEnemy->nY = 131;
    ptrEnemy->nEnterCounter = 0;
    ptrEnemy->nDirX = 0;
    ptrEnemy->nDirY = -1;
    ptrEnemy->nSpeed = 2;
    ptrEnemy->nSpriteID = m_nNextSpriteID++;
    ptrEnemy->nSubPixelY = 0;

    // Apply the base speed plus multipler to new Enemy object.
    ptrEnemy->nSpeed = m_anBaseSpeeds[nType] + GetCurrentSpeedMultiplier();
    
    // If the next sprite id ends up too large we can reset.
    if(m_nNextSpriteID >= 38) m_nNextSpriteID = 7;

    // Get a sprite tile from a type position in the enemey sprite 
    // area of the sprite sheet. Store this as the main sprite.
    ptrEnemy->nSpriteNumber = GetSprite(nType+3) + 1;
    
    // Move sprite into position, set the sprite to the 
    // left facing sprite for inital spawn
    set_sprite_tile(ptrEnemy->nSpriteID, ptrEnemy->nSpriteNumber-1);
    move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
}

//--------------------------------------------------------------------------------------
// GetCurrentSpeedMultiplier: Get the current speed during a round.
//
// Returns:
//      UINT8: Returns unsigned int 8 for the current speed.
//--------------------------------------------------------------------------------------
UINT8 GetCurrentSpeedMultiplier(void) 
{
    return m_anRoundSpeeds[m_nCurrentRoundSpeedsPos][m_nCurrentSpeedStep];
}

//--------------------------------------------------------------------------------------
// GetCurrentSpawnMultiplier: Get the current spawn rate during a round.
//
// Returns:
//      UINT8: Returns unsigned int 8 for the current spawn rate.
//--------------------------------------------------------------------------------------
UINT8 GetCurrentSpawnMultiplier(void) 
{
    return m_anRoundSpawnRates[m_nCurrentRoundSpawnRatesPos][m_nCurrentSpawnStep];
}

//--------------------------------------------------------------------------------------
// ShouldSpawnThisTick: Check if an Enemy can spawn in the current spawner tick.
//
// Returns:
//      BOOLEAN: Returns if this tick allows new spawn.
//--------------------------------------------------------------------------------------
BOOLEAN ShouldSpawnThisTick(void) 
{
    return m_bNewTick && m_anQueue[m_nCurrentQueuePos] != 0;
}

//--------------------------------------------------------------------------------------
// GetNextSpawn: Gets the next entry in the queue at the next spawner tick.
//
// Returns:
//      UINT8: Returns unsigned int 8 for what the next spawn will be in queue.
//--------------------------------------------------------------------------------------
UINT8 GetNextSpawn(void) 
{
    return m_anQueue[m_nCurrentQueuePos];
}

//--------------------------------------------------------------------------------------
// GetNextSpawnType: Gets the next entry type in the queue at the next spawner tick.
//
// Returns:
//      UINT8: Returns unsigned int 8 for what the next spawn type will be in queue.
//--------------------------------------------------------------------------------------
UINT8 GetNextSpawnType(void) 
{
    return m_anQueueType[m_nCurrentQueuePos];
}
