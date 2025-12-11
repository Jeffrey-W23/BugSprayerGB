//--------------------------------------------------------------------------------------
// Purpose: Hud object. Used to update the part of the background  representing the HUD 
// UI for showing the current player health and game score. 
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "../UI/hud.h"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for easily letter setting for the HUD.
#define TILE_0     74
#define TILE_COLON 86

// New static unisigned int 16 for the current health of the hud.
static UINT16 m_nCurrentHealth = 998;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitHud: Initiate the hud object, updating the area of the background that makes the UI
//--------------------------------------------------------------------------------------
void InitHud(void) 
{
    // Set the initial health.
    m_nCurrentHealth = 998;
    SetHealth(998);
    SetScore(0);
}

//--------------------------------------------------------------------------------------
// SetHealth: Set data and display everything needed the Health UI.
//
// Params:
//      nHealth: int for setting the health UI on the background layer.
//--------------------------------------------------------------------------------------
void SetHealth(UINT16 nHealth) 
{
    // Seperate the tens and ones of passed health.
    UINT8 tens = (nHealth / 10) % 10;
    UINT8 ones = nHealth % 10;
    
    // Prepare array of ints for storing sprites in order.
    UINT8 tiles[4];

    // Set each of the letters, and health in display order.
    tiles[0] = 84;
    tiles[1] = 86;
    tiles[2] = TILE_0 + tens;
    tiles[3] = TILE_0 + ones;

    // Update the background sprite layer.
    set_bkg_tiles(2, 17, 4, 1, tiles);
}

//--------------------------------------------------------------------------------------
// SetHealthHearts: Set data and display everything needed for the Health UI as hearts.
//
// Params:
//      nHealth: int for setting the health UI on the background layer.
//--------------------------------------------------------------------------------------
void SetHealthHearts(UINT8 nHealth) 
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 o;

    // Prepare array of ints for storing sprites in order.
    UINT8 tiles[7];

    // Set each of the letters, and health in display order.
    tiles[0] = 84;
    tiles[1] = 86;

    // Loop through amount of heart slots
    for (o = 0; o < 5; o++) 
    {
        // Apply heart in slot
        if (o < nHealth)
            tiles[o+2] = 122;

        // Apply empty slot
        else
            tiles[o+2] = 121;
    }

    // Update the background sprite layer.
    set_bkg_tiles(2, 17, 7, 1, tiles);
}

//--------------------------------------------------------------------------------------
// SetScore: Set data and display everything needed for the Score UI.
//
// Params:
//      nScore: int for setting the Score UI on the background layer.
//--------------------------------------------------------------------------------------
void SetScore(UINT16 nScore) 
{
    // Seperate the thousands, tens and ones of passed score.
    UINT8 thousands = (nScore / 1000) % 10;
    UINT8 hundreds = (nScore / 100) % 10;
    UINT8 tens = (nScore / 10) % 10;
    UINT8 ones = nScore % 10;

    // Set each of the letters, and score in display order.
    UINT8 tiles[7];
    tiles[0] = 90;
    tiles[1] = 91;
    tiles[2] = TILE_COLON;
    tiles[3] = TILE_0 + thousands;
    tiles[4] = TILE_0 + hundreds;
    tiles[5] = TILE_0 + tens;
    tiles[6] = TILE_0 + ones;

    // Update the background sprite layer.
    set_bkg_tiles(11, 17, 7, 1, tiles);
}
