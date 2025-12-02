//--------------------------------------------------------------------------------------
// Purpose: Header class for the Player object. Used for setting and updating the player
// sprite, and the spray sprite.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef PLAYER_H
#define PLAYER_H

// includes, using, etc
#include <gb/gb.h>

//--------------------------------------------------------------------------------------
// Player struct for setting the main information needed for building the player.
//--------------------------------------------------------------------------------------
typedef struct Player 
{
    UBYTE ubSpriteIDs[4];
    UINT8 nX;
    UINT8 nY;
    UINT8 nWidth;
    UINT8 nHeight;
    UINT8 nDirection;
    UINT8 anTiles[8];
    UINT16 nHealth;
    UINT8 nDirCheck;
    UINT16 nScore;
    UINT16 nTotalShotsTaken;
    BOOLEAN bTakenDamage;
} Player;

//--------------------------------------------------------------------------------------
// InitPlayer: Initiate the Player object, updating all its stats and information.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void InitPlayer(Player* ptrPlayer);

//--------------------------------------------------------------------------------------
// UpdatePlayer: Update the player object each frame, updating direction, sprites,
// and the spray object when attacking enemies.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
void UpdatePlayer(Player* ptrPlayer);

//--------------------------------------------------------------------------------------
// HandlePlayerInput: Check for input for updating the player rotation.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//      nJoy: The Joypad for checking input.
//      nPrevjoy: The previous joypad position.
//--------------------------------------------------------------------------------------
void HandlePlayerInput(Player* ptrPlayer, UINT8 nJoy, UINT8 nPrevJoy);

//--------------------------------------------------------------------------------------
// IsPlayerDead: Check if the player is currently dead from no health.
//
// Params:
//      ptrPlayer: Pointer of the player object, for passing in the main player object.
//--------------------------------------------------------------------------------------
BOOLEAN IsPlayerDead(Player* ptrPlayer);

// Close the Header.
#endif