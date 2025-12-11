//--------------------------------------------------------------------------------------
// Purpose: Header class for the save object. Used for saving highscore data to memory.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "../Data-Systems/save.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// const magic number to validate the saved data.
#define SAVE_MAGIC 0x55AA
//--------------------------------------------------------------------------------------

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 16 for temp storing the highscore data for gameModeA
UINT16 m_nHighScoreA = 0;

// New unsigned int 16 for temp storing the highscore data for gameModeB
UINT16 m_nHighScoreB = 0;

// New unsigned int 16 for temp storing the data for shots taken.
UINT16 m_nSavedShotsB = 0;
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
        m_nHighScoreA  = sram[1];
        m_nHighScoreB  = sram[2];
        m_nSavedShotsB = sram[3];
    }

    // Else no saved data
    else
    {
        // First boot ever - clear everything
        m_nHighScoreA = m_nHighScoreB = m_nSavedShotsB = 0;
        sram[0] = SAVE_MAGIC;
        sram[1] = 0;
        sram[2] = 0;
        sram[3] = 0;
    }

    // Disable SRAM
    *((volatile UINT8*)0x0000) = 0x00;
}

//--------------------------------------------------------------------------------------
// SaveGameData: Store the passed score and shotTaken data to memory.
//
// Params:
//      bMode: The current mode trying to save highscore.
//      nScore: The score from the player.
//      nShotsTaken: The total shots taken by the player.
//--------------------------------------------------------------------------------------
void SaveGameData(BOOLEAN bMode, UINT16 nScore, UINT16 nShotsTaken)
{
    // Int for if we need to 
    // save or not this session.
    UINT8 nNeedSave = 0;

    // If MODE A
    if (bMode == 0)
    {
        // Ensure we even need to save the score.
        if (nScore > m_nHighScoreA)
        {
            // Set the save value.
            m_nHighScoreA = nScore;
            
            // Mark that we need to save data.
            nNeedSave = 1;
        }
    }

    // Else MODE B
    else
    {
        // Ensure we even need to save the score.
        if (nScore > m_nHighScoreB)
        {
            // Set the save values.
            m_nHighScoreB = nScore;
            m_nSavedShotsB = nShotsTaken;

            // Mark that we need to save data.
            nNeedSave = 1;
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
        sram[1] = m_nHighScoreA;
        sram[2] = m_nHighScoreB;
        sram[3] = m_nSavedShotsB;

        // Disable SRAM
        *((volatile UINT8*)0x0000) = 0x00;
    }
}

//--------------------------------------------------------------------------------------
// LoadGameData: Load saved data stored in memory, setting that data to passed pointers.
//
// Params:
//      bMode: The current mode trying to load highscore.
//      nScore: Pointer to the loaded score variable to store during runtime.
//      nShotsTaken: Pointer to the loaded shotsTaken variable to store during runtime. 
//--------------------------------------------------------------------------------------
void LoadGameData(BOOLEAN bMode, UINT16* nScore, UINT16* nShotsTaken)
{
    // If ModeA, get just highscore A
    if (bMode == 0) *nScore = m_nHighScoreA;
    
    // Else if ModeB, we need both highscore and shots.
    else { *nScore = m_nHighScoreB; *nShotsTaken = m_nSavedShotsB; }
}
