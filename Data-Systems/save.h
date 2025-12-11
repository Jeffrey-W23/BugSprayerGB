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

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 16 for temp storing the highscore data for gameModeA
extern UINT16 m_nHighScoreA;

// New unsigned int 16 for temp storing the highscore data for gameModeB
extern UINT16 m_nHighScoreB;

// New unsigned int 16 for temp storing the data for shots taken.
extern UINT16 m_nSavedShotsB;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitSaveData: Initiate the saving/loading system.
//--------------------------------------------------------------------------------------
void InitSaveData(void);

//--------------------------------------------------------------------------------------
// SaveGameData: Store the passed score and shotTaken data to memory.
//
// Params:
//      bMode: The current mode trying to save highscore.
//      nScore: The score from the player.
//      nShotsTaken: The total shots taken by the player.
//--------------------------------------------------------------------------------------
void SaveGameData(BOOLEAN bMode, UINT16 nScore, UINT16 nShotsTaken);

//--------------------------------------------------------------------------------------
// LoadGameData: Load saved data stored in memory, setting that data to passed pointers.
//
// Params:
//      bMode: The current mode trying to load highscore.
//      nScore: Pointer to the loaded score variable to store during runtime.
//      nShotsTaken: Pointer to the loaded shotsTaken variable to store during runtime. 
//--------------------------------------------------------------------------------------
void LoadGameData(BOOLEAN bMode, UINT16* nScore, UINT16* nShotsTaken);

#endif