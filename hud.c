//--------------------------------------------------------------------------------------
// Purpose: Hud object. Used to update the part of the background  representing the HUD 
// UI for showing the current player health and game score. 
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "hud.h"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for easily letter setting for the HUD.
#define TILE_0     74
#define TILE_H     84
#define TILE_P     85
#define TILE_COLON 86
#define TILE_S     87
#define TILE_C     88
#define TILE_O     89
#define TILE_R     90
#define TILE_E     91

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
    UINT8 tiles[5];

    // Set each of the letters, and health in display order.
    tiles[0] = TILE_H;
    tiles[1] = TILE_P;
    tiles[2] = TILE_COLON;
    tiles[3] = TILE_0 + tens;
    tiles[4] = TILE_0 + ones;

    // Update the background sprite layer.
    set_bkg_tiles(1, 17, 5, 1, tiles);
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
    UINT8 tiles[10];
    tiles[0] = TILE_S;
    tiles[1] = TILE_C;
    tiles[2] = TILE_O;
    tiles[3] = TILE_R;
    tiles[4] = TILE_E;
    tiles[5] = TILE_COLON;
    tiles[6] = TILE_0 + thousands;
    tiles[7] = TILE_0 + hundreds;
    tiles[8] = TILE_0 + tens;
    tiles[9] = TILE_0 + ones;

    // Update the background sprite layer.
    set_bkg_tiles(9, 17, 10, 1, tiles);
}
