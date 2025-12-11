//--------------------------------------------------------------------------------------
// Purpose: Header class for the save object. Used for saving highscore data to memory.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include "save.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// const magic number to validate the saved data.
#define SAVE_MAGIC 0x55AA
//--------------------------------------------------------------------------------------




// These are your runtime cached values (in WRAM)
UINT16 m_nHighScoreA = 0;
UINT16 m_nHighScoreB = 0;
UINT16 m_nSavedShotsB = 0;






void InitSaveData(void)
{
    // Enable SRAM - raw version, always works
    *((volatile UINT8*)0x0000) = 0x0A;

    volatile UINT16 *sram = (volatile UINT16*)0xA000;

    if (sram[0] == SAVE_MAGIC)
    {
        m_nHighScoreA  = sram[1];
        m_nHighScoreB  = sram[2];
        m_nSavedShotsB = sram[3];
    }
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

void SaveGameData(BOOLEAN bMode, UINT16 nScore, UINT16 nShotsTaken)
{
    UINT8 need_save = 0;

    if (bMode == 0)  // Mode A
    {
        if (nScore > m_nHighScoreA)
        {
            m_nHighScoreA = nScore;
            need_save = 1;
        }
    }
    else  // Mode B
    {
        if (nScore > m_nHighScoreB)
        {
            m_nHighScoreB = nScore;
            m_nSavedShotsB = nShotsTaken;
            need_save = 1;
        }
    }

    if (need_save)
    {
        *((volatile UINT8*)0x0000) = 0x0A;
        volatile UINT16 *sram = (volatile UINT16*)0xA000;

        sram[0] = SAVE_MAGIC;
        sram[1] = m_nHighScoreA;
        sram[2] = m_nHighScoreB;
        sram[3] = m_nSavedShotsB;

        *((volatile UINT8*)0x0000) = 0x00;
    }
}

void LoadGameData(BOOLEAN bMode, UINT16* nScore, UINT16* nShotsTaken)
{
    if (bMode == 0)
        *nScore = m_nHighScoreA;
    else
    {
        *nScore = m_nHighScoreB;
        *nShotsTaken = m_nSavedShotsB;
    }
}
