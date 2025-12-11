//--------------------------------------------------------------------------------------
// Purpose: Enemies object. Used for storing the current enemies array, and other 
// global values applied to all enemies.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "enemies.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for magic numbers used through out spawn logic.
#define MAX_ENEMIES 16

// New unsigned int 8 for storing the next avaliable spriteID, used during spawning.
UINT8 m_nNextSpriteID = 7;

// New array of Enemy struct, used to store and manager all enemies currently active.
Enemy m_aoEnemies[MAX_ENEMIES];

// New unsigned int 8 for the current speed of all enemies in the game.
UINT8 m_nCurrentSpeed = 1;

// New unsigned int 16 for tracking the total enemies killed in the game.
UINT16 m_nTotalKilled = 0;
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
INT8 GetSprite(INT8 nRandNumber)
{
    // Switch through each random number, return the
    // first sprite position based on random number.
    switch (nRandNumber)
    {
        // BEATLE
        case 0: return 47; break;
        
        // SPIDER
        case 1: return 63; break;
        
        // CENTIPEDE
        case 2: return 71; break;
        
        // FLY
        case 3: return 55; break;
        
        // MOTH
        case 4: return 79; break;

        // MOSQUITO
        case 5: return 87; break;
        
        // DEFAULT
        default: return 47; break;
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
