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
#include "hUGEDriver.h"

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
//--------------------------------------------------------------------------------------

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
    LoadAllHighScoreData();

    // DEBUG // UNCOMMENT FOR EASY WAY TO VERIFY SAVE DATA //
    //printf("M0D0: %u", m_oHighScoreData.nHighScoreAEasy); printf(" \n");
    //printf("M0D1: %u", m_oHighScoreData.nHighScoreAHard); printf(" \n");
    //printf("M1D0: %u", m_oHighScoreData.nHighScoreBEasy); printf(" \n");
    //printf("M1D1: %u", m_oHighScoreData.nHighScoreBHard); printf(" \n");
    //printf("M1SD0: %u", m_oHighScoreData.nShotsTakenEasy); printf(" \n");
    //printf("M1SD1: %u", m_oHighScoreData.nShotsTakenHard); printf(" \n");
    //PerformantDelay(3000);
    // DEBUG // UNCOMMENT FOR EASY WAY TO VERIFY SAVE DATA //

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
    ShowGameSelectMenu(&m_bCurrentGameMode, &m_bCurrentDifficulty);
    
    // Mute the main channel that other audio plays on.
    hUGE_mute_channel(HT_CH4, HT_CH_MUTE);

    // Show loading screen incase slow random generation.
    ShowLoadingScreen();

    // Used for better random gen
    VBK_REG = 0;

    // Turn on GameBoy display
    DISPLAY_ON;

    // Initiate random system
    initrand(DIV_REG | (LY_REG << 8));

    // Initalizxe desired gamemode based on selection.
    InitializeGamemode(m_bCurrentGameMode, m_bCurrentDifficulty);
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
