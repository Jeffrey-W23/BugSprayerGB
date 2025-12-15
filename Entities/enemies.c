//--------------------------------------------------------------------------------------
// Purpose: Enemies object. Used for storing the current enemies array, and other 
// global values applied to all enemies.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "../Entities/enemies.h"
#include "../Gamemodes/enemyManagerA.h"
#include "../Gamemodes/enemyManagerB.h"
#include "../Music-Sound/soundManager.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 8 for storing the next avaliable spriteID, used during spawning.
UINT8 m_nNextSpriteID = 7;

// New array of Enemy struct, used to store and manager all enemies currently active.
Enemy m_aoEnemies[MAX_ENEMIES];

// New unsigned int 8 for the current speed of all enemies in the game.
UINT8 m_nCurrentSpeed = 1;

// New unsigned int 16 for tracking the total enemies killed in the game.
UINT16 m_nTotalKilled = 0;

// New unsigned int 8 value for storing the sprite id of the enemyt that hurt the player.
UINT8 m_bEnemyHurtPlayer;

// New bool value for if the kill auido has been requested for playing.
BOOLEAN m_bPlayKillSoundEffect = FALSE;

// New bool value for if we need to show the spray affect from the player.
BOOLEAN m_bShowSpray = FALSE;
//--------------------------------------------------------------------------------------

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
// UpdateEnemyModeA: Update an Enemy object, updating position and status based on inputs.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdateEnemyModeA(UINT8 nEnemyIndex, Player* ptrPlayer) 
{
    // Declare variables for
    // later use.
    UINT8 nProgress;

    // Get the current enemy being updated.
    Enemy* ptrEnemy = &m_aoEnemies[nEnemyIndex];
    
    // Only update the enemy if can move and alive.
    if (!ptrEnemy->bAlive) return;
    if (ptrEnemy->bCantMove) return;
    
    // Update the Enemy in the FlyIn state.

    // The FlyIn state is the state of an enemy on
    // inital spawn. During the FlyIn state enemies
    // will enter the scene from the right of the screen.
    // heading along the X axis until aligned with
    // their assigned lane.

    if(ptrEnemy->nState == 0) 
    {
        // Incrase the enterCounter.
        ptrEnemy->nEnterCounter++;
        
        // Store the enterCounter for easier use.
        nProgress = ptrEnemy->nEnterCounter;

        // Set the sprite of the enemy to a turn for a few frame as it enters its lane.
        if(nProgress > 46) set_sprite_tile(ptrEnemy->nSpriteID, ptrEnemy->nSpriteNumber+2);

        // If entering the lane move the playher along the x axis.
        if(nProgress < 50) ptrEnemy->nX = 160 - ((160 - ptrEnemy->nTargetX) * nProgress) / 50; 
        
        // Once in position for its lane
        else 
        {
            // Ensure x axis is aligned with lane, 
            // set the state to entered and update sprite.
            ptrEnemy->nX = ptrEnemy->nTargetX;
            ptrEnemy->nState = 1;
            set_sprite_tile(ptrEnemy->nSpriteID, ptrEnemy->nSpriteNumber);
        }
    }

    // Else update the enemy if in the normal state.

    // Normal state is when the enemy is ready in its
    // assigned lane. During the normal state the enemy
    // simply heads straight up its Y axis in its assigned
    // lane until collision with player or death area.

    else
    {
        // Move the enemy up it's lane only on the Y axis.
        ptrEnemy->nSubPixelY += ptrEnemy->nSpeed;
        
        if (ptrEnemy->nSubPixelY >= 16) 
        {
            ptrEnemy->nY += ptrEnemy->nDirY;
            ptrEnemy->nSubPixelY -= 16;
        }
    }
    
    // Check collision with the Players front.
    if (ptrEnemy->nY <= 70 && ptrEnemy->nY >= 52 && ptrEnemy->nX >= (ptrPlayer->nX - 8) && ptrEnemy->nX <= (ptrPlayer->nX + 8)) 
    {
        // Kill the enemy, giving score to the player.
        KillEnemy(TRUE, ptrEnemy, ptrPlayer);

        // Progress the round difficulty.
        IncreaseRoundDifficulty(m_nTotalKilled);
        return;
    }

    // Check collision with past/behind the player.
    if (ptrEnemy->nY <= 52)
    {
        // Set the sprite number for the enemy that has damaged the player.
        m_bEnemyHurtPlayer = ptrEnemy->nSpriteNumber;

        // Kill the enemy, giving no score to the player.
        KillEnemy(FALSE, ptrEnemy, ptrPlayer);
        return;
    }
    
    // Update sprite
    move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
}

//--------------------------------------------------------------------------------------
// UpdateEnemyModeB: Update an Enemy object, updating position and status based on inputs.
//
// Params:
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdateEnemyModeB(UINT8 nEnemyIndex, Player* ptrPlayer) 
{
    // Declare variables for
    // later use.
    UINT8 nSprayX;
    UINT8 nSprayY;
    
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
        if (ptrEnemy->nX >= 74 && ptrEnemy->nX <= 94 && ptrEnemy->nY >= 72 && ptrEnemy->nY <= 94) 
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
        // Kill the enemy.
        KillEnemy(FALSE, ptrEnemy, ptrPlayer);

        // Break out of update      
        // No need to keep updating
        // now that enemy is dead.
        return;
    }

    // If the bullet spray is currently active
    // we want to check if this bullet has hit
    // the current enemy.
    if (ptrPlayer->bSprayActive)
    {
        // Get the current position of the bullet.
        nSprayX = ptrPlayer->nSprayX;
        nSprayY = ptrPlayer->nSprayY;

        // Check to see if the bullet has hit the enemy.
        if (nSprayX >= ptrEnemy->nX - 4 && nSprayX <= ptrEnemy->nX + 12 &&
            nSprayY >= ptrEnemy->nY - 4 && nSprayY <= ptrEnemy->nY + 12)
        {
            // Mark the enemy as killed, and we are scoring.
            KillEnemy(TRUE, ptrEnemy, ptrPlayer);

            // Reset the bullet for next fire.
            ptrPlayer->bSprayActive = FALSE;
            set_sprite_tile(5, SPRITE_SHEET_EMPTY_SLOT);
            move_sprite(5, 0, 0);
            
            // Break out of the method.
            return;
        }
    }

    // Update the sprite for the current enemy.
    move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
}

//--------------------------------------------------------------------------------------
// KillEnemy: Kill an Enemy object, marking its position in the array as free.
//
// Params:
//      bDoesPlayerScore: Does the player score from this kill?
//      nEnemyIndex: The position of the enemy in the enemies array.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void KillEnemy(BOOLEAN bDoesPlayerScore, Enemy* ptrEnemy, Player* ptrPlayer)
{
    // Mark this enemy as dead.
    ptrEnemy->bAlive = FALSE;

    // Remove the sprite from scene.
    set_sprite_tile(ptrEnemy->nSpriteID, 0);
    move_sprite(ptrEnemy->nSpriteID, 0, 0);
    
    // Only count a kill/score if the player kills.
    if (bDoesPlayerScore)
    {
        // Update score values.
        ptrPlayer->nScore += 1;
        m_nTotalKilled += 1;

        // Show the spray affect
        m_bShowSpray = TRUE;
    }

    // Only damage the player when a kill happens with no score.
    else
    {
        // Damage the player.
        ptrPlayer->bTakenDamage = TRUE;
    }

    // Request playing of the enemy kill sound.
    m_bPlayKillSoundEffect = TRUE;
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
        // BEATLE
        case 0: return 56; break;
        
        // SPIDER
        case 1: return 64; break;
        
        // CENTIPEDE
        case 2: return 72; break;
        
        // FLY
        case 3: return 47; break;
        
        // MOTH
        case 4: return 50; break;

        // MOSQUITO
        case 5: return 53; break;
        
        // DEFAULT
        default: return 56; break;
    }
}

//--------------------------------------------------------------------------------------
// KillAllEnemies: Start initial steps to Kill all enemies currently alive in the scene.
//--------------------------------------------------------------------------------------
void KillAllEnemies(void)
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 o;

    // Play kill all sound
    PlayKillAllEnemySound();

    // Loop through each enemy avaliable.
    for (o = 0; o < MAX_ENEMIES; o++) 
    {
        // Only kill enemies if alive
        if (IsEnemyAlive(o)) 
        {
            // Remove the sprite from scene.
            set_sprite_tile(m_aoEnemies[o].nSpriteID, 32);
        }
    }
}

//--------------------------------------------------------------------------------------
// CompleteKillAllEnemies: Complete the kill all enemies currently alive in the scene.
//--------------------------------------------------------------------------------------
void CompleteKillAllEnemies(void)
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 o;

    // Loop through each enemy avaliable.
    for (o = 0; o < MAX_ENEMIES; o++) 
    {
        // Only kill enemies if alive
        if (IsEnemyAlive(o)) 
        {
            // Mark this enemy as dead.
            m_aoEnemies[o].bAlive = FALSE;

            // Remove the sprite from scene.
            set_sprite_tile(m_aoEnemies[o].nSpriteID, 0);
            move_sprite(m_aoEnemies[o].nSpriteID, 0, 0);
        }
    }
}
