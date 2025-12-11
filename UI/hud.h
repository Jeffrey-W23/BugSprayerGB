//--------------------------------------------------------------------------------------
// Purpose: Header class for the hud object. Used to update the part of the background 
// representing the HUD UI for showing the current player health and game score. 
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef HUD_H
#define HUD_H

// includes, using, etc
#include <gb/gb.h>

//--------------------------------------------------------------------------------------
// InitHud: Initiate the hud object, updating the area of the background that makes the UI
//--------------------------------------------------------------------------------------
void InitHud(void);

//--------------------------------------------------------------------------------------
// SetHealth: Set data and display everything needed the Health UI.
//
// Params:
//      nHealth: int for setting the health UI on the background layer.
//--------------------------------------------------------------------------------------
void SetHealth(UINT16 hp);

//--------------------------------------------------------------------------------------
// SetHealthHearts: Set data and display everything needed for the Health UI as hearts.
//
// Params:
//      nHealth: int for setting the health UI on the background layer.
//--------------------------------------------------------------------------------------
void SetHealthHearts(UINT8 hp);

//--------------------------------------------------------------------------------------
// SetScore: Set data and display everything needed for the Score UI.
//
// Params:
//      nScore: int for setting the Score UI on the background layer.
//--------------------------------------------------------------------------------------
void SetScore(UINT16 score);

// Close the Header.
#endif