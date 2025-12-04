//--------------------------------------------------------------------------------------
// Purpose: Enemies object. Used for setting/updating the enemey sprite, positions, statuses.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "enemies.h"
#include <rand.h>

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------

// New array of Enemy struct, used to store and manager all enemies currently active.
Enemy m_aoEnemies[MAX_ENEMIES];

// New unsigned int 8 for storing the next avaliable spriteID, used during spawning.
static UINT8 m_nNextSpriteID = 7;

// New unsigned int 8 for the spawn queue.
static UINT8 m_anSpawnQueue[SPAWN_QUEUE_SIZE];

// New unsigned int 8 for the current spawn position that is unused.
static UINT8 m_nSpawnQueuePos = 0;

// New unsigned int 8 for the current speed of all enemies in the game.
static UINT8 m_nCurrentSpeed = 1;

// New unsigned int 16 for tracking the total enemies killed in the game.
static UINT16 m_nTotalKilled = 0;

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
static const UINT8 m_anSpawnPositions[8][2] = 
{
    {39, 43},       // Top-Left
    {80, 41},       // Top-Center
    {130, 33},      // Top-Right
    {14, 82},       // Left-Center
    {154, 82},      // Right-Center
    {6, 154},       // Bottom-Left
    {80, 154},      // Bottom-Center
    {156, 156}      // Bottom-Right
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

// New bool value for if the kill auido has been requested for playing.
BOOLEAN m_bPlayKillSoundEffect = FALSE;

// New bool value for if we need to show the spray affect from the player.
BOOLEAN m_bShowSpray = FALSE;
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
        for (i = SPAWN_QUEUE_SIZE - 1; i > 0; i--) 
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
        for (i = 1; i < SPAWN_QUEUE_SIZE; i++) 
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
    m_nSpawnQueuePos = (m_nSpawnQueuePos + 1) % SPAWN_QUEUE_SIZE;
    return nIndex;
}

//--------------------------------------------------------------------------------------
// InitEnemy: Initiate an Enemy object, updating all its stats and information.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//--------------------------------------------------------------------------------------
void InitEnemy(UINT8 nEnemyIndex) 
{
    // Setup an initial enemy, setting important values only.
    m_aoEnemies[nEnemyIndex].bAlive = FALSE;
    m_aoEnemies[nEnemyIndex].bCantMove = FALSE;
    m_aoEnemies[nEnemyIndex].bMainSpriteSet = FALSE;
    m_aoEnemies[nEnemyIndex].nSpriteID = 0;
    m_aoEnemies[nEnemyIndex].nSpeed = m_nCurrentSpeed;
    m_aoEnemies[nEnemyIndex].nSubPixelX = 0;
    m_aoEnemies[nEnemyIndex].nSubPixelY = 0;
}

//--------------------------------------------------------------------------------------
// SpawnEnemy: Spawn an Enemy in the scene.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      nSpawnIndex: The spawn position to spawn this enemy.
//--------------------------------------------------------------------------------------
void SpawnEnemy(UINT8 nEnemyIndex, UINT8 nSpawnIndex) 
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
    ptrEnemy->nX = m_anSpawnPositions[nSpawnIndex][0];
    ptrEnemy->nY = m_anSpawnPositions[nSpawnIndex][1];

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
    if (m_nNextSpriteID >= 40) m_nNextSpriteID = 7;
    
    // Store the spawnIndex.
    ptrEnemy->nIndex = nSpawnIndex;
 
    // Get a sprite tile from a random position in the enemey sprite 
    // area of the sprite sheet. Store this as the main sprite.
    ptrEnemy->nSpriteNumber = GetSprite((rand() >> 4) % 5) + nSpawnIndex;

    // Set a new sprite at the current ID, this will be the inital spawn sprite.
    set_sprite_tile(ptrEnemy->nSpriteID, 32);

    // Move the sprite into position.
    move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
}

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
INT8 GetSprite(INT8 nRandNumber)
{
    // Switch through each random number, return the
    // first sprite position based on random number.
    switch (nRandNumber)
    {
        case 0:
            return 47;
            break;
        case 1:
            return 55;
            break;
        case 2:
            return 63;
            break;
        case 3:
            return 71;
            break;
        case 4:
            return 79;
            break;
        
        default:
            return 47;
            break;
    }
}

//--------------------------------------------------------------------------------------
// UpdateEnemy: Update an Enemy object, updating position and status based on inputs.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdateEnemy(UINT8 nEnemyIndex, Player* ptrPlayer) 
{  
    // Get the current enemy being updated.
    Enemy* ptrEnemy = &m_aoEnemies[nEnemyIndex];

    // Only update enemy if it is alive.
    if (!ptrEnemy->bAlive) return;
    
    // Only update the position if the enemy can move.
    if (!ptrEnemy->bCantMove) 
    {
        // Move the current enemy.   
        ptrEnemy->nSubPixelX += m_nCurrentSpeed;
        ptrEnemy->nSubPixelY += m_nCurrentSpeed;

        if (ptrEnemy->nSubPixelX >= 16) 
        {
            ptrEnemy->nX += ptrEnemy->nDirX;
            ptrEnemy->nSubPixelX -= 16;
        }
        if (ptrEnemy->nSubPixelY >= 16) 
        {
            ptrEnemy->nY += ptrEnemy->nDirY;
            ptrEnemy->nSubPixelY -= 16;
        }

        // Check if the main sprite has been set.
        if (!ptrEnemy->bMainSpriteSet)
        {
            // Get the borders of the map, this will server as the area to change the intital spawn sprite
            if (ptrEnemy->nX >= 15 && ptrEnemy->nX <= 153 && ptrEnemy->nY >= 44 && ptrEnemy->nY <= 143) 
            {
                // Stop this from checking constantly.
                ptrEnemy->bMainSpriteSet = TRUE;

                // Set the main sprite, this is the random one from earlier.
                set_sprite_tile(ptrEnemy->nSpriteID, ptrEnemy->nSpriteNumber);
            }
        }
        
        // Collision check for if the player and the enemy are touching.
        if (ptrEnemy->nX >= 76 && ptrEnemy->nX <= 86 && ptrEnemy->nY >= 74 && ptrEnemy->nY <= 84) 
        {
            // Mark this enemy as cant move,
            // meaning it is touching the player.
            ptrEnemy->bCantMove = TRUE;
        }
    }
    
    // Else if the Enemy can no longer move
    // it means the player and the enemy are
    // touching, so time to apply damge to player.
    else
    {
        // Damage the player.
        ptrPlayer->bTakenDamage = TRUE;

        // Increase shots taken count for grade calculation.
        ptrPlayer->nTotalShotsTaken++;

        // Kill the enemy.
        KillEnemy(ptrEnemy, ptrPlayer);

        // Break out of update      
        // No need to keep updating
        // now that enemy is dead.
        return;
    }
    
    // Ensure the enemy is moving.
    if (!ptrEnemy->bCantMove)
    {
        // Check the enemy direction against player direction.
        // We only want to kill the enemy the player faces.
        if ((ptrEnemy->nIndex == ptrPlayer->nDirCheck))
        {
            // Check if the enemy is in kill range of the player.
            if (ptrEnemy->nX >= 62 && ptrEnemy->nX <= 100 && ptrEnemy->nY >= 60 && ptrEnemy->nY <= 100) 
            {
                // Increase shots taken count for grade calculation.
                ptrPlayer->nTotalShotsTaken++;

                // Kill the enemy.
                KillEnemy(ptrEnemy, ptrPlayer);
                
                // Show the spray affect
                m_bShowSpray = TRUE;
                
                // Break out of update
                // No need to keep updating
                // now that enemy is dead.
                return;
            }
        }
    }

    // Update the sprite for the current enemy.
    move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
}

//--------------------------------------------------------------------------------------
// KillEnemy: Kill an Enemy object, marking its position in the array as free.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void KillEnemy(Enemy* ptrEnemy, Player* ptrPlayer)
{
    // Mark this enemy as dead.
    ptrEnemy->bAlive = FALSE;

    // Remove the sprite from scene.
    set_sprite_tile(ptrEnemy->nSpriteID, 0);
    move_sprite(ptrEnemy->nSpriteID, 0, 0);
    
    // Update score values.
    ptrPlayer->nScore += 1;
    m_nTotalKilled += 1;

    // Request playing of the enemy kill sound.
    m_bPlayKillSoundEffect = TRUE;
}

//--------------------------------------------------------------------------------------
// IncreaseDifficulty: Increase the spawn rate and speed of enemies based on progress.
//
// Param:
//      nDamgeToPlayer: The damage value to apply to the player.
//--------------------------------------------------------------------------------------
void IncreaseDifficulty(UINT8 nDamgeToPlayer)
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
            else if (m_nCurrentSpeed == 5) m_nKillsForNextSpeed = 400;
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
            if (m_nTotalKilled < 550) m_nKillsForNextSpawnRate = 15;
            else if (m_nTotalKilled < 650) { m_nKillsForNextSpawnRate = 200; nDamgeToPlayer = 40; }
            else if (m_nTotalKilled < 950) { m_nKillsForNextSpawnRate = 400; nDamgeToPlayer = 50; }
            else if (m_nTotalKilled < 2000) { m_nKillsForNextSpawnRate = 500; m_nCurrentSpeed = 9; }
            else { m_bMaxSpawnRateReached= TRUE; m_nCurrentSpeed = 10; }

            // Save last processed kill count
            m_nLastSpawnRateKillCount = m_nTotalKilled;
        }
    }
}

//--------------------------------------------------------------------------------------
// IsEnemyAlive: Check the status of an Enemy object.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//
// Returns:
//      BOOLEAN: Returns the alive status of the passed enemy index.
//--------------------------------------------------------------------------------------
BOOLEAN IsEnemyAlive(UINT8 nEnemyIndex) 
{  
    return m_aoEnemies[nEnemyIndex].bAlive;
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
    SpawnEnemy(nFreeSlot, nSpawnIndex);
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
