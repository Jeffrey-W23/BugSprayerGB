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
// HighScoreData struct for setting/getting all the highscore data.
//--------------------------------------------------------------------------------------
typedef struct HighScoreData
{
    UINT16 nHighScoreAEasy;
    UINT16 nHighScoreAHard;
    UINT16 nHighScoreBEasy;
    UINT16 nHighScoreBHard;
    UINT16 nShotsTakenEasy;
    UINT16 nShotsTakenHard;
} HighScoreData;

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New HighScoreData object for storing all the current score data.
extern HighScoreData m_oHighScoreData;
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
//      bDiff: The difficulty mode selected for a certain gamemode.
//      nScoreEasy: The score from the player.
//      nShotsTaken: The total shots taken by the player.
//--------------------------------------------------------------------------------------
void SaveGameData(BOOLEAN bMode, BOOLEAN bDiff, UINT16 nScore, UINT16 nShotsTaken);

//--------------------------------------------------------------------------------------
// LoadGameData: Load saved data stored in memory, setting that data to passed pointers.
//
// Params:
//      bMode: The current mode trying to load highscore.
//      bDiff: The difficulty mode selected for a certain gamemode.
//      nScore: Pointer to the loaded score variable to store during runtime.
//      nShotsTakenEasy: Pointer to the loaded shotsTaken variable to store during runtime. 
//--------------------------------------------------------------------------------------
void LoadGameData(BOOLEAN bMode, BOOLEAN bDiff, UINT16* nScore, UINT16* nShotsTaken);

//--------------------------------------------------------------------------------------
// LoadAllHighScoreData: Load all the highscore data from previous game sessions.
//--------------------------------------------------------------------------------------
void LoadAllHighScoreData(void);

#endif