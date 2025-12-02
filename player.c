//--------------------------------------------------------------------------------------
// Purpose: Player object. Used for setting and updating the player and spray sprite.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "player.h"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 8 for storing the current spray sprite direction.
static UINT8 m_nSprayIndex = 0;

// New bool for if the b button has been pressed.
static BOOLEAN m_bButtonBPressed = FALSE;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitPlayer: Initiate the Player object, updating all its stats and information.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void InitPlayer(Player* ptrPlayer) 
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;

    // int for preparing the sprite order.
    UINT8 nBaseTiles[8] = {0,4,8,12,16,20,24,28};

    // Set all player inital values.
    ptrPlayer->nX = 76; ptrPlayer->nY = 78;                 // X/Y Values
    ptrPlayer->nWidth = 16; ptrPlayer->nHeight = 16;        // Width/Height
    ptrPlayer->nDirection = 0; ptrPlayer->nDirCheck = 4;    // Direction
    ptrPlayer->nHealth = 999; ptrPlayer->nScore = 0;        // Health/Score
    ptrPlayer->bTakenDamage = FALSE;                        // Is Hurt

    // Prepare all the sprite tiles needed to show
    // the player from all different angles.
    // The player is a 2x2 sprite, or 16x16 pixels.
    for(i = 0; i < 8; i++) 
    {
        ptrPlayer->anTiles[i] = nBaseTiles[i];
    }

    // Prpare the current player sprite and set.
    for(i = 0; i < 4; i++) 
    {
        ptrPlayer->ubSpriteIDs[i] = i;
        set_sprite_tile(ptrPlayer->ubSpriteIDs[i], ptrPlayer->anTiles[0] + i);
    }

    // Set the inital spray sprite
    set_sprite_tile(5, 95);
    move_sprite(5, 92, 82);
    m_nSprayIndex = 35;
}

//--------------------------------------------------------------------------------------
// UpdatePlayer: Update the player object each frame, updating direction, sprites,
// and the spray object when attacking enemies.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdatePlayer(Player* ptrPlayer) 
{    
    // Find the needed sprite tile for player direction.
    UINT8 nTile = ptrPlayer->anTiles[ptrPlayer->nDirection];
    
    // Move each of the 4 sprites into position, and get the sprite data.
    
    // TOP LEFT
    move_sprite(ptrPlayer->ubSpriteIDs[0], ptrPlayer->nX, ptrPlayer->nY);
    set_sprite_tile(ptrPlayer->ubSpriteIDs[0], nTile);

    // TOP RIGHT
    move_sprite(ptrPlayer->ubSpriteIDs[1], ptrPlayer->nX + 8, ptrPlayer->nY);
    set_sprite_tile(ptrPlayer->ubSpriteIDs[1], nTile + 1);

    // BOTTOM LEFT
    move_sprite(ptrPlayer->ubSpriteIDs[2], ptrPlayer->nX, ptrPlayer->nY + 8);
    set_sprite_tile(ptrPlayer->ubSpriteIDs[2], nTile + 2);

    // BOTTOM RIGHT
    move_sprite(ptrPlayer->ubSpriteIDs[3], ptrPlayer->nX + 8, ptrPlayer->nY + 8);
    set_sprite_tile(ptrPlayer->ubSpriteIDs[3], nTile + 3);
}

//--------------------------------------------------------------------------------------
// HandlePlayerInput: Check for input for updating the player rotation.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//      nJoy: The Joypad for checking input.
//      nPrevjoy: The previous joypad position.
//--------------------------------------------------------------------------------------
void HandlePlayerInput(Player* ptrPlayer, UINT8 nJoy, UINT8 nPrevJoy) 
{
    // Update the players direction for updating sprites, 
    // the direction for checking enemies for killing,
    // and update the position of the spray object.

    // DOWN-RIGHT
    if ((nJoy & J_RIGHT) && (nJoy & J_DOWN))
    {
        ptrPlayer->nDirection = 1;
        ptrPlayer->nDirCheck = 7;
        m_nSprayIndex = 36;
        move_sprite(5, 90, 92);
    }

    // DOWN-LEFT
    else if ((nJoy & J_DOWN) && (nJoy & J_LEFT))
    {
        ptrPlayer->nDirection = 3;
        ptrPlayer->nDirCheck = 5;
        m_nSprayIndex = 38;
        move_sprite(5, 70, 92);
    }
    
    // UP-LEFT
    else if ((nJoy & J_LEFT) && (nJoy & J_UP))
    {
        ptrPlayer->nDirection = 5;
        ptrPlayer->nDirCheck = 0;
        m_nSprayIndex = 40;
        move_sprite(5, 70, 72);
    }
    
    // UP-RIGHT
    else if ((nJoy & J_RIGHT) && (nJoy & J_UP))
    {
        ptrPlayer->nDirection = 7;
        ptrPlayer->nDirCheck = 2;
        m_nSprayIndex = 34;
        move_sprite(5, 90, 72);
    }
    
    // RIGHT
    else if (nJoy & J_RIGHT)
    {
        ptrPlayer->nDirection = 0;
        ptrPlayer->nDirCheck = 4;
        m_nSprayIndex = 35;
        move_sprite(5, 92, 82);
    }
    
    // DOWN
    else if (nJoy & J_DOWN)
    {
        ptrPlayer->nDirection = 2;
        ptrPlayer->nDirCheck = 6;
        m_nSprayIndex = 37;
        move_sprite(5, 80, 94);
    }
    
    // LEFT
    else if (nJoy & J_LEFT)
    {
        ptrPlayer->nDirection = 4;
        ptrPlayer->nDirCheck = 3;
        m_nSprayIndex = 39;
        move_sprite(5, 68, 82);
    }
    
    
    // UP
    else if (nJoy & J_UP)
    {
        ptrPlayer->nDirection = 6;
        ptrPlayer->nDirCheck = 1;
        m_nSprayIndex = 33;
        move_sprite(5, 80, 70);
    }

    // On B button clicked, update the sprite of the
    // spray object, setting the sprite based on current
    // player direction, showing each different angle of 
    // the spray.
    if ((nJoy & J_B) && !(nPrevJoy & J_B))
    {
        // Ensure we only update the spray when pressing, not holding B.
        if (!m_bButtonBPressed)
        {
            // Mark button as pressed.
            m_bButtonBPressed = TRUE;

            // Increase shots taken count for grade calculation.
            ptrPlayer->nTotalShotsTaken++;

            // Play the spray sound
            NR41_REG = 0x2D;
            NR42_REG = 0x81;
            NR43_REG = 0x10;
            NR44_REG = 0x80;

            // Set the sprite active.
            set_sprite_tile(5, m_nSprayIndex);
            return;
        }

        // Disable the spray if holding is attempted.
        set_sprite_tile(5, 95);
    }

    // Else done spraying, reset for next use.
    else
    {
        m_bButtonBPressed = FALSE;
        
        // Set the spray to a blank object when not needed.
        set_sprite_tile(5, 95);
    }

    // Update the player sprites.
    UpdatePlayer(ptrPlayer);
}

//--------------------------------------------------------------------------------------
// IsPlayerDead: Check if the player is currently dead from no health.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
BOOLEAN IsPlayerDead(Player* ptrPlayer)
{
    return ptrPlayer->nHealth <= -1;
}
