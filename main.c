//--------------------------------------------------------------------------------------
// Purpose: The main script, used as a base for running the applcation.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include <stdio.h>
#include <stdlib.h>
#include <gb/gb.h>
#include <rand.h>
#include <string.h>

// includes for main gameObject.
#include "Gamemodes/gamemodes.h"
#include "Data-Systems/save.h"
#include "UI/menuScreens.h"
#include "Data-Systems/helpers.h"

// includes for the sprite layer
#include "Sprite-Sheets/Sprites.c"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// New byte for keeping track of the current set gameMode.
extern BYTE m_bCurrentGameMode = 0;

// New byte for keeping track of the current set difficulty.
extern BYTE m_bCurrentDifficulty = 0;

// New HighScoreData object for storing all the current score data.
HighScoreData m_oHighScoreData;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// LoadHighScoreData: Load highscore data from previous game sessions.
//--------------------------------------------------------------------------------------
void LoadHighScoreData(void)
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

//--------------------------------------------------------------------------------------
// Initialize: Prepare the application for launch.
//--------------------------------------------------------------------------------------
void Initialize(void)
{
    // Sound registers, must be in this order.
    NR52_REG = 0x80; // Turn on the sound.
    NR50_REG = 0x77; // Set the volume of the left and right channel
    NR51_REG = 0xFF; // Set usage to both channels

    // Load highscore data
    InitSaveData();
    LoadHighScoreData();

    // Display the splash screen background
    DisplaySplashScreen();

    // Display the start screen background
    DisplayStartScreen();

    // Set sprite data based on spritesheet
    SPRITES_8x8; 
    set_sprite_data(0, 82, m_caSprites);

    // Display the sprite layer
    SHOW_SPRITES;

    // Display the GameSelect/MainMenu
    ShowGameSelectMenu(&m_bCurrentGameMode, &m_bCurrentDifficulty, &m_oHighScoreData);

    // Hide the background while things load.
    HIDE_BKG;

    // Used for better random gen
    VBK_REG = 0;

    // Turn on GameBoy display
    DISPLAY_ON;

    // Initiate random system
    initrand(DIV_REG | (LY_REG << 8));

    // Initalizxe desired gamemode based on selection.
    InitializeGamemode(m_bCurrentGameMode);
}

//--------------------------------------------------------------------------------------
// main: base function of the program where all code will be run.
//--------------------------------------------------------------------------------------
void main(void) 
{   
    // Initialize layers, 
    // player, spirtes, bg, etc
    Initialize();

    // Create the main game loop of the application
    while(1) 
    { 
        // Game Loop for Gamemode 0
        if (m_bCurrentGameMode == 0)
        {
            UpdateLoopGameModeA();
        }

        // Game Loop for Gamemode 1
        else if (m_bCurrentGameMode == 1)
        {
            UpdateLoopGameModeB();
        }
    }
}
