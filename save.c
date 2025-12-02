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

//--------------------------------------------------------------------------------------
// SaveGameData: Store the passed score and shotTaken data to memory.
//
// Params:
//      nScore: The score from the player.
//      nShotsTaken: The total shots taken by the player.
//--------------------------------------------------------------------------------------
void SaveGameData(UINT16 nScore, UINT16 nShotsTaken) 
{
    // Declare for later use.
    static UINT16 highScore = 0;
    static UINT16 savedShots = 0;

    // Ensure the data is actually different before saving.
    if (nScore > highScore || nShotsTaken != savedShots) 
    {
        highScore = nScore;
        savedShots = nShotsTaken;

         // Enable SRAM
        *((volatile UINT8*)0x0000) = 0x0A;
        volatile UINT16* sram = (volatile UINT16*)0xA000;

        // Store the data.
        sram[0] = SAVE_MAGIC;    // magic number
        sram[1] = highScore;     // high score
        sram[2] = savedShots;    // shots taken

         // Disable SRAM
        *((volatile UINT8*)0x0000) = 0x00;
    }
}

//--------------------------------------------------------------------------------------
// LoadGameData: Load saved data stored in memory, setting that data to passed pointers.
//
// Params:
//      nScore: Pointer to the loaded score variable to store during runtime.
//      nShotsTaken: Pointer to the loaded shotsTaken variable to store during runtime. 
//--------------------------------------------------------------------------------------
void LoadGameData(UINT16* nScore, UINT16* nShotsTaken)
 {
     // Enable SRAM
    *((volatile UINT8*)0x0000) = 0x0A;
    volatile UINT16* sram = (volatile UINT16*)0xA000;

    // Check memory for data.
    if (sram[0] == SAVE_MAGIC) 
    {
        // Get the data.
        *nScore = sram[1];
        *nShotsTaken = sram[2];
    } 

    // Else if nothing
    else 
    {
        // Set data to blank values
        *nScore = 0;
        *nShotsTaken = 0;
        sram[0] = SAVE_MAGIC;
        sram[1] = 0;
        sram[2] = 0;
    }

     // Disable SRAM
    *((volatile UINT8*)0x0000) = 0x00;
}
