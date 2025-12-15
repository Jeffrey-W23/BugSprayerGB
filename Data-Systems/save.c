//--------------------------------------------------------------------------------------
// Purpose: Header class for the save object. Used for saving highscore data to memory.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "../Data-Systems/save.h"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// const magic number to validate the saved data.
#define SAVE_MAGIC 0x55AA

// New unsigned int 16 for temp storing the highscore data for gameModeA Easy Mode
static UINT16 m_nHighScoreAEasy = 0;

// New unsigned int 16 for temp storing the highscore data for gameModeA Hard Mode
static UINT16 m_nHighScoreAHard = 0;

// New unsigned int 16 for temp storing the highscore data for gameModeB Easy Mode
static UINT16 m_nHighScoreBEasy = 0;

// New unsigned int 16 for temp storing the highscore data for gameModeB Hard Mode
static UINT16 m_nHighScoreBHard = 0;

// New unsigned int 16 for temp storing the data for shots taken for Easy Mode.
static UINT16 m_nSavedShotsBEasy = 0;

// New unsigned int 16 for temp storing the data for shots taken for Hard Mode.
static UINT16 m_nSavedShotsBHard = 0;
//--------------------------------------------------------------------------------------

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New HighScoreData object for storing all the current score data.
HighScoreData m_oHighScoreData;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitSaveData: Initiate the saving/loading system.
//--------------------------------------------------------------------------------------
void InitSaveData(void)
{
    // Enable SRAM
    *((volatile UINT8*)0x0000) = 0x0A;
    volatile UINT16 *sram = (volatile UINT16*)0xA000;

    // Get current highscore data if exist.
    if (sram[0] == SAVE_MAGIC)
    {
        m_nHighScoreAEasy  = sram[1];
        m_nHighScoreAHard  = sram[2];
        m_nHighScoreBEasy = sram[3];
        m_nHighScoreBHard = sram[4];
        m_nSavedShotsBEasy = sram[5];
        m_nSavedShotsBHard = sram[6];
    }

    // Else no saved data
    else
    {
        // First boot ever - clear everything
        m_nHighScoreAEasy = m_nHighScoreAHard = m_nHighScoreBEasy =
        m_nHighScoreBHard = m_nSavedShotsBEasy = m_nSavedShotsBHard = 0;
        sram[0] = SAVE_MAGIC;
        sram[1] = 0;
        sram[2] = 0;
        sram[3] = 0;
        sram[4] = 0;
        sram[5] = 0;
        sram[6] = 0;
    }

    // Disable SRAM
    *((volatile UINT8*)0x0000) = 0x00;
}

//--------------------------------------------------------------------------------------
// SaveGameData: Store the passed score and shotTaken data to memory.
//
// Params:
//      bMode: The current mode trying to save highscore.
//      bDiff: The difficulty mode selected for a certain gamemode.
//      nScoreEasy: The score from the player.
//      nShotsTaken: The total shots taken by the player.
//--------------------------------------------------------------------------------------
void SaveGameData(BOOLEAN bMode, BOOLEAN bDiff, UINT16 nScore, UINT16 nShotsTaken)
{
    // Int for if we need to 
    // save or not this session.
    UINT8 nNeedSave = 0;

    // If MODE A
    if (bMode == 0)
    {
        if (bDiff == 0)
        {
            // Ensure we even need to save the score.
            if (nScore > m_nHighScoreAEasy)
            {
                // Set the save value.
                m_nHighScoreAEasy = nScore;
                
                // Mark that we need to save data.
                nNeedSave = 1;
            }
        }

        else
        {
            // Ensure we even need to save the score.
            if (nScore > m_nHighScoreAHard)
            {
                // Set the save value.
                m_nHighScoreAHard = nScore;
                
                // Mark that we need to save data.
                nNeedSave = 1;
            }
        }
    }

    // Else MODE B
    else
    {
        if (bDiff == 0)
        {
            // Ensure we even need to save the score.
            if (nScore > m_nHighScoreBEasy)
            {
                // Set the save values.
                m_nHighScoreBEasy = nScore;
                m_nSavedShotsBEasy = nShotsTaken;

                // Mark that we need to save data.
                nNeedSave = 1;
            }
        }

        else
        {
            // Ensure we even need to save the score.
            if (nScore > m_nHighScoreBHard)
            {
                // Set the save values.
                m_nHighScoreBHard = nScore;
                m_nSavedShotsBHard = nShotsTaken;

                // Mark that we need to save data.
                nNeedSave = 1;
            }
        }
    }

    // If we have data that needs saving.
    if (nNeedSave)
    {
        // Enable SRAM
        *((volatile UINT8*)0x0000) = 0x0A;
        volatile UINT16 *sram = (volatile UINT16*)0xA000;

        // Store the data in memory.
        sram[0] = SAVE_MAGIC;
        sram[1] = m_nHighScoreAEasy;
        sram[2] = m_nHighScoreAHard;
        sram[3] = m_nHighScoreBEasy;
        sram[4] = m_nHighScoreBHard;
        sram[5] = m_nSavedShotsBEasy;
        sram[6] = m_nSavedShotsBHard;

        // Disable SRAM
        *((volatile UINT8*)0x0000) = 0x00;
    }
}

//--------------------------------------------------------------------------------------
// LoadGameData: Load saved data stored in memory, setting that data to passed pointers.
//
// Params:
//      bMode: The current mode trying to load highscore.
//      bDiff: The difficulty mode selected for a certain gamemode.
//      nScore: Pointer to the loaded score variable to store during runtime.
//      nShotsTakenEasy: Pointer to the loaded shotsTaken variable to store during runtime. 
//--------------------------------------------------------------------------------------
void LoadGameData(BOOLEAN bMode, BOOLEAN bDiff, UINT16* nScore, UINT16* nShotsTaken)
{
    // If ModeA, get just highscore A
    if (bMode == 0)
    {
        if (bDiff == 0) *nScore = m_nHighScoreAEasy;
        else *nScore = m_nHighScoreAHard;
    }
    
    // Else if ModeB, we need both highscore and shots.
    else 
    {
        if (bDiff == 0)
        {
            *nScore = m_nHighScoreBEasy; 
            *nShotsTaken = m_nSavedShotsBEasy; 
        }

        else
        {
            *nScore = m_nHighScoreBHard; 
            *nShotsTaken = m_nSavedShotsBHard; 
        }
    }
}

//--------------------------------------------------------------------------------------
// LoadAllHighScoreData: Load all the highscore data from previous game sessions.
//--------------------------------------------------------------------------------------
void LoadAllHighScoreData(void)
{
    // Delcare temp vars for setting.
    UINT16 nLoadedScoreAEasy = 0;
    UINT16 nLoadedScoreAHard = 0;
    UINT16 nLoadedScoreBEasy = 0;
    UINT16 nLoadedScoreBHard = 0;
    UINT16 nLoadedShotsTakenEasy = 0;
    UINT16 nLoadedShotsTakenHard = 0;

    // Load the game data from memory
    LoadGameData(0, 0, &nLoadedScoreAEasy, &nLoadedShotsTakenEasy);
    LoadGameData(0, 1, &nLoadedScoreAHard, &nLoadedShotsTakenHard);
    LoadGameData(1, 0, &nLoadedScoreBEasy, &nLoadedShotsTakenEasy);
    LoadGameData(1, 1, &nLoadedScoreBHard, &nLoadedShotsTakenHard);

    // Set the load values in the main.c
    m_oHighScoreData.nShotsTakenEasy = nLoadedShotsTakenEasy;
    m_oHighScoreData.nShotsTakenHard = nLoadedShotsTakenHard;
    m_oHighScoreData.nHighScoreAEasy = nLoadedScoreAEasy;
    m_oHighScoreData.nHighScoreAHard = nLoadedScoreAHard;
    m_oHighScoreData.nHighScoreBEasy = nLoadedScoreBEasy;
    m_oHighScoreData.nHighScoreBHard = nLoadedScoreBHard;
}
