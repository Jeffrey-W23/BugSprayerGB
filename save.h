//--------------------------------------------------------------------------------------
// Purpose: Header class for the save object. Used for saving highscore data to memory.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef SAVE_H
#define SAVE_H

// includes, using, etc
#include <gb/gb.h>

//--------------------------------------------------------------------------------------
// SaveGameData: Store the passed score and shotTaken data to memory.
//
// Params:
//      nScore: The score from the player.
//      nShotsTaken: The total shots taken by the player.
//--------------------------------------------------------------------------------------
void SaveGameData(UINT16 nScore, UINT16 nShotsTaken);

//--------------------------------------------------------------------------------------
// LoadGameData: Load saved data stored in memory, setting that data to passed pointers.
//
// Params:
//      nScore: Pointer to the loaded score variable to store during runtime.
//      nShotsTaken: Pointer to the loaded shotsTaken variable to store during runtime. 
//--------------------------------------------------------------------------------------
void LoadGameData(UINT16* nScore, UINT16* nShotsTaken);

#endif