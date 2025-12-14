//--------------------------------------------------------------------------------------
// Purpose: Player object. Used for setting and updating the player and spray sprite.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "../Entities/player.h"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// Const int for setting the empty slot for sprite sheet.
#define SPRITE_SHEET_EMPTY_SLOT 81

// New bool for if the spary is currently showing.
static BOOLEAN m_bIsSprayShowing = FALSE;

// New unsigned int 8 for storing the last movement of joypad.
static UINT8 m_nPrevJoy = 0;

// New const arrays of unsigned int 8s, used for the spawn positions of the spray bullet.
const UINT8 m_anSpraySpawnPosX[8] = { 75, 84, 92, 74, 94, 76, 84, 92 };
const UINT8 m_anSpraySpawnPosY[8] = { 75, 74, 75, 84, 84, 92, 94, 91 };

// New const array of unsigned int 8s for the different sprites for each spray bullet direction.
const UINT8 m_ansprayTileIDs[8] = {40, 33, 34, 39, 35, 38, 37, 36};

// New const arrays of unisigned 8s, used for getting direction ints for the spary bullet.
const INT8  m_anSprayDirX[8] = {-1,  0,  1, -1,  1, -1,  0,  1};
const INT8  m_anSprayDirY[8] = {-1, -1, -1,  0,  0,  1,  1,  1};
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitPlayer: Initiate the Player object, updating all its stats and information.
//
// Params:
//      bMode: The gameMode to prepare the player object for.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void InitPlayer(BYTE bMode, Player* ptrPlayer) 
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;

    // int for preparing the sprite order.
    UINT8 nBaseTiles[8] = {0,4,8,12,16,20,24,28};

    // Player is mostly the same between different game
    // modes, but some inital values will be different.

    // if mode 0 meaning the center screen mode.
    if (bMode == 0)
    {
        // Set the intital values for the player.
        ptrPlayer->nX = 80; ptrPlayer->nY = 80;
        ptrPlayer->nDirection = 0; ptrPlayer->nDirCheck = 4;
        ptrPlayer->nHealth = 998; 

        // Set the inital values of the spray bullet.
        ptrPlayer->bSprayActive = FALSE;
        set_sprite_tile(5, SPRITE_SHEET_EMPTY_SLOT);
        move_sprite(5, 0, 0);
    }

    // else if mode 1, meaning the top screen mode.
    else
    {
        ptrPlayer->nX = 80; ptrPlayer->nY = 46;
        ptrPlayer->nDirection = 2; ptrPlayer->nDirCheck = 6;
        ptrPlayer->nHealth = 3;
        ptrPlayer->nSprayX = 76;
        ptrPlayer->nSprayY = 62;
    }

    // Set all player inital values.
    ptrPlayer->nWidth = 16; 
    ptrPlayer->nHeight = 16;
    ptrPlayer->nScore = 0;
    ptrPlayer->bTakenDamage = FALSE;

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
//      bMode: The gameMode to prepare the player object for.
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//      nJoy: The Joypad for checking input.
//--------------------------------------------------------------------------------------
void HandlePlayerInput(BYTE bMode, Player* ptrPlayer, UINT8 nJoy) 
{
    // If it is gamemode 0
    if (bMode == 0)
    {
        // Update the players direction for updating sprites, 
        // the direction for checking enemies for killing,
        // and update the position of the spray object.

        // DOWN-RIGHT
        if ((nJoy & J_RIGHT) && (nJoy & J_DOWN))
        {
            ptrPlayer->nDirection = 1;
            ptrPlayer->nDirCheck = 7;
        }

        // DOWN-LEFT
        else if ((nJoy & J_DOWN) && (nJoy & J_LEFT))
        {
            ptrPlayer->nDirection = 3;
            ptrPlayer->nDirCheck = 5;
        }
        
        // UP-LEFT
        else if ((nJoy & J_LEFT) && (nJoy & J_UP))
        {
            ptrPlayer->nDirection = 5;
            ptrPlayer->nDirCheck = 0;
        }
        
        // UP-RIGHT
        else if ((nJoy & J_RIGHT) && (nJoy & J_UP))
        {
            ptrPlayer->nDirection = 7;
            ptrPlayer->nDirCheck = 2;
        }
        
        // RIGHT
        else if (nJoy & J_RIGHT)
        {
            ptrPlayer->nDirection = 0;
            ptrPlayer->nDirCheck = 4;
        }
        
        // DOWN
        else if (nJoy & J_DOWN)
        {
            ptrPlayer->nDirection = 2;
            ptrPlayer->nDirCheck = 6;
        }
        
        // LEFT
        else if (nJoy & J_LEFT)
        {
            ptrPlayer->nDirection = 4;
            ptrPlayer->nDirCheck = 3;
        }
        
        
        // UP
        else if (nJoy & J_UP)
        {
            ptrPlayer->nDirection = 6;
            ptrPlayer->nDirCheck = 1;
        }

        // On A Button click, fire the spray bullet.
        if ((nJoy & J_A) && !(m_nPrevJoy & J_A)) 
        {
            FireSprayBullet(ptrPlayer);
        }
    }

    // If is gamemode 1
    else if (bMode == 1)
    {

        // Determine last pressed.
        UINT8 nPressed = nJoy & ~m_nPrevJoy;
        
        // Move the player along the x axis only, moving between 3 set positions.

        // On Left Joypad input
        if (nPressed & J_LEFT || nPressed & J_B) {
            
            // Move to: LEFT
            if (ptrPlayer->nX == 80)
            {
                ptrPlayer->nX = 52; 
                ptrPlayer->nSprayX = 56;
            }  
            
            // Move to: MIDDLE
            else if (ptrPlayer->nX == 108)
            {
                ptrPlayer->nX = 80;
                ptrPlayer->nSprayX = 84;
            }

            // Move to: STAY LEFT
            else 
            {
                ptrPlayer->nX = 52;
                ptrPlayer->nSprayX = 56;
            }
        }

        // On Right Joypad input
        if (nPressed & J_RIGHT || nPressed & J_A) 
        {
            // Move to: MIDDLE
            if (ptrPlayer->nX == 52)
            {
                ptrPlayer->nX = 80;
                ptrPlayer->nSprayX = 84;
            }

            // Move to: RIGHT
            else if (ptrPlayer->nX == 52)
            {
                ptrPlayer->nX = 108;
                ptrPlayer->nSprayX = 112;
            }
            
            // Most to: STAY RIGHT
            else
            {
                ptrPlayer->nX = 108;
                ptrPlayer->nSprayX = 112;
            }
        }
    }

    // Store the previous joyPad position.
    m_nPrevJoy = nJoy;

    // Update the player sprites.
    UpdatePlayer(ptrPlayer);
}

//--------------------------------------------------------------------------------------
// FireSprayBullet: Initiate the spray bullet, spawning it and preparing it for movement.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void FireSprayBullet(Player* ptrPlayer)
{
    // Only fire if a bullet isnt currently active.
    if (ptrPlayer->bSprayActive) return;

    // Play spray sound.
    NR41_REG = 0x2D; NR42_REG = 0x81; NR43_REG = 0x10; NR44_REG = 0x80;

    // Increase shots taken count for grade calculation.
    ptrPlayer->nTotalShotsTaken++;

    // Store direction check val for easier access.
    UINT8 d = ptrPlayer->nDirCheck;

    // Update the position and direction of the bullet.
    ptrPlayer->nSprayX = m_anSpraySpawnPosX[d];
    ptrPlayer->nSprayY = m_anSpraySpawnPosY[d];
    ptrPlayer->nSprayDirX = m_anSprayDirX[d];
    ptrPlayer->nSprayDirY = m_anSprayDirY[d];

    // Mark the bullet as active, there can only be one.
    ptrPlayer->bSprayActive = TRUE;

    // Set the sprite based on direction and move sprite into position.
    set_sprite_tile(5, m_ansprayTileIDs[d]);
    move_sprite(5, ptrPlayer->nSprayX, ptrPlayer->nSprayY);
}

//--------------------------------------------------------------------------------------
// UpdateSprayBullet: Update the position and state of the spray bullet during active fire.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdateSprayBullet(Player* ptrPlayer)
{
    // Check to ensure that the bullet is active.
    if (!ptrPlayer->bSprayActive) return;

    // Update the position of the bullet based on direction.
    ptrPlayer->nSprayX += ptrPlayer->nSprayDirX << 2;
    ptrPlayer->nSprayY += ptrPlayer->nSprayDirY << 2;

    // Set the boundary of the bullet, if it gets to the screen
    // edge we want to despawn, reset for next fire.
    if (ptrPlayer->nSprayX < 15 || ptrPlayer->nSprayX > 152 ||
        ptrPlayer->nSprayY < 44 || ptrPlayer->nSprayY > 138)
    {
        ptrPlayer->bSprayActive = FALSE;
        set_sprite_tile(5, SPRITE_SHEET_EMPTY_SLOT);
        return;
    }

    // Update the position of the sprite.
    move_sprite(5, ptrPlayer->nSprayX, ptrPlayer->nSprayY);
}

//--------------------------------------------------------------------------------------
// ShowSprayEffect: Show the spray sprite next to the player on enemy kills.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//      bShowSpray: To show the spray or not.
//--------------------------------------------------------------------------------------
void ShowSprayEffect(Player* ptrPlayer, BOOLEAN bShowSpray)
{
    // On bShowSpray, update the sprite of the
    // spray object, setting the sprite based on current
    // player direction, showing each different angle of 
    // the spray.
    if (bShowSpray)
    {
        // Ensure we only update the spray one at a time.
        if (!m_bIsSprayShowing)
        {
            // Mark button as pressed.
            m_bIsSprayShowing = TRUE;

            // Play the spray sound
            NR41_REG = 0x2D;
            NR42_REG = 0x81;
            NR43_REG = 0x10;
            NR44_REG = 0x80;

            // Set the sprite active.
            set_sprite_tile(5, m_ansprayTileIDs[ptrPlayer->nDirCheck]);
            move_sprite(5, ptrPlayer->nSprayX, ptrPlayer->nSprayY);
            return;
        }

        // Disable the spray
        set_sprite_tile(5, SPRITE_SHEET_EMPTY_SLOT);
    }

    // Else done spraying, reset for next use.
    else
    {
        m_bIsSprayShowing = FALSE;
    
        // Set the spray to a blank object when not needed.
        set_sprite_tile(5, SPRITE_SHEET_EMPTY_SLOT);
    }
}
