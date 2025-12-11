//--------------------------------------------------------------------------------------
// Purpose: EnemiesManager object for GameMode B. This manager is used to spawn 
// enemy objects in scene for the desired gamemode.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "../Gamemodes/enemyManagerB.h"
#include "../Entities/enemies.h"
#include <rand.h>

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// New array of unsigned int 8s for the spawn queue.
static UINT8 m_anSpawnQueue[SPAWN_QUEUE_SIZEB];

// New unsigned int 8 for the current spawn position that is unused.
static UINT8 m_nSpawnQueuePos = 0;

// New Unsigned int 8 for keeping track of kill requirements for speed increase
static UINT16 m_nKillsForNextSpeed = 15;

// New unsigned int 8 for keeping track of the kill requirements for spawn increase
static UINT16 m_nKillsForNextSpawnRate = 15;

// New bool value for marking of the max speed has been reached.
static BOOLEAN m_bMaxSpeedReached = FALSE;

// New bool value for marking the spawn rate as max reached.
static BOOLEAN m_bMaxSpawnRateReached = FALSE;

// New unsigned int 16 for keeping track of the previous kill count from last spawn rate update.
static UINT16 m_nLastSpawnRateKillCount = 0;

// New private array of unsigned int 8 for spawn positions/directions.
static const UINT8 m_anSpawnPositionsMode0[8][2] = 
{
    {43, 44},       // TOP-LEFT
    {84, 41},       // Top-MIDDLE
    {130, 37},      // Top-RIGHT
    {14, 84},       // LEFT-MIDDLE
    {154, 84},      // RIGHT-MIDDLE
    {14, 154},       // BOTTOM-LEFT
    {84, 154},      // BOTTOM-MIDDLE
    {156, 156}      // BOTTOM-RIGHT
};

// New private array of unsigned int 8 for x axis movement directions
static const INT8 m_anMovementDirX[8] = {1,  0, -1,  1, -1,  1,  0, -1};

// New private array of unsigned int 8 for y axis movement directions
static const INT8 m_anMovementDirY[8] = {1,  1,  1,  0,  0, -1, -1, -1};
//--------------------------------------------------------------------------------------

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 8 for keeping track of the current spawn tick.
UINT8 m_nSpawnTimer = 0;

// New unsigned int 8 for keeping track of the current spawn delay for all enemies.
UINT8 m_nSpawnDelay = 100;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitEnemiesSpawnQueue: Prepare the spawn queue before starting the game. This uses
// random number generation, then a shuffle and then checks to ensure no long streaks, 
// which can result in some slow down depending on RNG.
//--------------------------------------------------------------------------------------
void InitEnemiesSpawnQueue(void) 
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i; UINT8 j;
    UINT8 o; UINT8 k;

    // Declare vars needed for shuffling.
    UINT8 nIndex = 0;
    UINT8 nTemp;
    BOOLEAN bValidShuffle = FALSE;
    UINT8 nStreak;

    // Fill with 0-7 repeated 8 times each (64 total)
    for (o = 0; o < 8; o++) 
    {
        for (k = 0; k < 8; k++) 
        {
            m_anSpawnQueue[nIndex++] = k;
        }
    }

    // Start main shuffling with Fisher-Yates and ensuring no more
    // than 3 of the same spawn position can appear in a row. 
    while (!bValidShuffle) 
    {
        // Fisher-Yates shuffle
        for (i = SPAWN_QUEUE_SIZEB - 1; i > 0; i--) 
        {
            j = rand() % (i + 1);
            nTemp = m_anSpawnQueue[i];
            m_anSpawnQueue[i] = m_anSpawnQueue[j];
            m_anSpawnQueue[j] = nTemp;
        }

        // Mark suffle as valid for now,
        // before starting the streaks check.
        bValidShuffle = TRUE;
        nStreak = 1;

        // Check to make sure no more than 3 consecutive same numbers

        // Loop through the spawn queue
        for (i = 1; i < SPAWN_QUEUE_SIZEB; i++) 
        {
            // Check if the same location appears in a row
            if (m_anSpawnQueue[i] == m_anSpawnQueue[i-1]) 
            {
                // Increase the streak index.
                nStreak++;

                // If streak is more than 3
                if (nStreak > 3) 
                {
                    // Set the shuffle as unsucessful
                    // break out and restart the shuffle.
                    bValidShuffle = FALSE;
                    break;
                }
            } 

            // If we dont have a streak reset the counter.
            else 
            {
                nStreak = 1;
            }
        }
    }

    // Set the current position of spawn queue as first entry.
    m_nSpawnQueuePos = 0;
}

//--------------------------------------------------------------------------------------
// GetNextSpawnIndex: Get the next spawn position in the queue.
//
// Returns:
//      UINT8: Returns unsigned int 8 for the index for the next spawn pos.
//--------------------------------------------------------------------------------------
UINT8 GetNextSpawnIndex(void) 
{
    // Get a new spawn position from the random queue and return.
    UINT8 nIndex = m_anSpawnQueue[m_nSpawnQueuePos];
    m_nSpawnQueuePos = (m_nSpawnQueuePos + 1) % SPAWN_QUEUE_SIZEB;
    return nIndex;
}

//--------------------------------------------------------------------------------------
// SpawnEnemyOnEdge: Spawn an Enemy in the scene from one of 8 edges.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      nSpawnIndex: The spawn position to spawn this enemy.
//--------------------------------------------------------------------------------------
void SpawnEnemyOnEdge(UINT8 nEnemyIndex, UINT8 nSpawnIndex) 
{  
    // Get the current enemy being updated.
    Enemy* ptrEnemy = &m_aoEnemies[nEnemyIndex];

    // Declare variables for temp storing direction values.
    INT8 nMoveventX;
    INT8 nMovementY;

    // If the spawnIndex is higher than what is
    // avaliable then set back to 2 position. (Top-Right).
    if (nSpawnIndex > 7) nSpawnIndex = 2;
    
    // Assign spawn position
    ptrEnemy->nX = m_anSpawnPositionsMode0[nSpawnIndex][0];
    ptrEnemy->nY = m_anSpawnPositionsMode0[nSpawnIndex][1];

    // Reset the subPixel values.
    ptrEnemy->nSubPixelX = 0;
    ptrEnemy->nSubPixelY = 0;
    
    // Mark as alive and cantMove
    ptrEnemy->bAlive = TRUE;
    ptrEnemy->bCantMove = FALSE;
    ptrEnemy->bMainSpriteSet = FALSE;
    
    // Set the movement direction
    nMoveventX = m_anMovementDirX[nSpawnIndex];
    nMovementY = m_anMovementDirY[nSpawnIndex];
    ptrEnemy->nDirX = nMoveventX;
    ptrEnemy->nDirY = nMovementY;

    // Set the current speed.
    ptrEnemy->nSpeed = m_nCurrentSpeed;
    
    // Assign a sprite ID based on all other enemies active.
    ptrEnemy->nSpriteID = m_nNextSpriteID++;
    
    // If the next sprite id ends up too large we can reset.
    if (m_nNextSpriteID >= 38) m_nNextSpriteID = 7;
    
    // Store the spawnIndex.
    ptrEnemy->nIndex = nSpawnIndex;
 
    // Get a sprite tile from a random position in the enemey sprite 
    // area of the sprite sheet. Store this as the main sprite.
    ptrEnemy->nSpriteNumber = GetSprite((rand() >> 4) % 3) + nSpawnIndex;

    // Set a new sprite at the current ID, this will be the inital spawn sprite.
    set_sprite_tile(ptrEnemy->nSpriteID, 32);

    // Move the sprite into position.
    move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
}

//--------------------------------------------------------------------------------------
// IncreaseDifficulty: Increase the spawn rate and speed of enemies based on progress.
//
// Param:
//      nDamgeToPlayer: The damage value to apply to the player.
//--------------------------------------------------------------------------------------
void IncreaseDifficulty(UINT8* nDamgeToPlayer)
{
    // Check if the amount of kills required to increase the speed has been hit.
    if (!m_bMaxSpeedReached)
    {
        // Increase the speed and calculate the 
        // next speed increase requirement.
        if (m_nTotalKilled >= m_nKillsForNextSpeed) 
        {
            m_nCurrentSpeed++;
            if (m_nCurrentSpeed == 2) m_nKillsForNextSpeed = 50;
            else if (m_nCurrentSpeed == 3) m_nKillsForNextSpeed = 125;
            else if (m_nCurrentSpeed == 4) m_nKillsForNextSpeed = 250;
            else if (m_nCurrentSpeed == 5) m_nKillsForNextSpeed = 600;
            else m_nKillsForNextSpeed += 150;  // Gradual increase after

            // Check if the speed hits the max.
            if (m_nCurrentSpeed >= MAX_SPEED) 
            {
                // Cap the speed, stop this check from
                // hitting again.
                m_nCurrentSpeed = MAX_SPEED;
                m_bMaxSpeedReached = TRUE;
            }
        }
    }

    // Only make calculation checks when needed.
    if (!m_bMaxSpawnRateReached && m_nTotalKilled != 0 && m_nTotalKilled % m_nKillsForNextSpawnRate == 0)
    {
        // Only update once per kill count objective reached.
        if (m_nTotalKilled != m_nLastSpawnRateKillCount) 
        {
            // Change the spawnRate depending on how many total kills.
            if (m_nTotalKilled < 150) m_nSpawnDelay -= 5;
            else if (m_nTotalKilled < 300) m_nSpawnDelay -= 2;
            else m_nSpawnDelay -= 1;

            // Change the kills required to change the kill rate. really want to slow it down.
            if (m_nTotalKilled < 450) m_nKillsForNextSpawnRate = 15;
            else if (m_nTotalKilled < 650) { m_nKillsForNextSpawnRate = 200; *nDamgeToPlayer = 40; }
            else if (m_nTotalKilled < 950) { m_nKillsForNextSpawnRate = 400; *nDamgeToPlayer = 50; }
            else if (m_nTotalKilled < 2000) { m_nKillsForNextSpawnRate = 500; m_nCurrentSpeed = 9; }
            else { m_bMaxSpawnRateReached= TRUE; m_nCurrentSpeed = 10; }

            // Save last processed kill count
            m_nLastSpawnRateKillCount = m_nTotalKilled;
        }
    }
}

//--------------------------------------------------------------------------------------
// SpawnNext: Attempt to spawn a new Enemy object in the scene.
//--------------------------------------------------------------------------------------
void SpawnNext(void) 
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;

    // Declare variables from getting the
    // next avaliable enemy. SpawnIndex for
    // the spawn position of the enemy.
    // And FreeSlot is the first avaliable
    // enemy in the enemies list.
    UINT8 nFreeSlot = MAX_ENEMIES;
    UINT8 nSpawnIndex;
    
    // Loop through each of the enemies
    for (i = 0; i < MAX_ENEMIES; i++) 
    {
        // Find the first enemy that is not alive.
        // and assign this is the avaliable enemy for
        // spawning.
        if (!m_aoEnemies[i].bAlive) 
        {
            nFreeSlot = i;
            break;
        }
    }
    
    // If the freeSlot is the same as the max enemies it
    // means we are at capacity, dont spawn this time.
    if (nFreeSlot == MAX_ENEMIES) return;
    
    // Else if we can spawn, lets get the next random spawn position.
    nSpawnIndex = GetNextSpawnIndex();
    
    // Initiate and spawn a new enemy in the scene.
    SpawnEnemyOnEdge(nFreeSlot, nSpawnIndex);
}

//--------------------------------------------------------------------------------------
// TickSpawnTimer: Tick the spawn timer used for checking when to spawn new enemies.
//--------------------------------------------------------------------------------------
void TickSpawnTimer(void) 
{
    if (m_nSpawnTimer > 0) 
    {
        m_nSpawnTimer--;
    }
}
