//--------------------------------------------------------------------------------------
// Purpose: MenuScreens object. Used for showing various UI and screens throughout the game.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include <stdio.h>
#include <stdlib.h>
#include <gb/gb.h>
#include <rand.h>
#include <string.h>
#include "../UI/menuScreens.h"
#include "../Music-Sound/soundManager.h"
#include "../Data-Systems/helpers.h"
#include "../Data-Systems/save.h"
#include "hUGEDriver.h"

// includes for the splash screen
#include "../Sprite-Sheets/SplashTiles.c"
#include "../Tile-Maps/SplashMap.c"

// Includes for the startscreen layer
#include "../Sprite-Sheets/StartScreen.c"
#include "../Tile-Maps/StartScreen.c"

// Includes for the GameSelect layer
#include "../Sprite-Sheets/GameSelectTiles.c"
#include "../Tile-Maps/GameSelect.c"
#include "../Tile-Maps/ModeSelectA.c"
#include "../Tile-Maps/ModeSelectB.c"

// Includes for the Letters layer
#include "../Sprite-Sheets/Letters.c"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// New menuCursor object, used for showing the main menu cursor.
static MenuCursor m_oMainMenuCursor;

// New bool value used for setting the selected difficulty mode.
static BYTE m_bSelectedDifficulty = 2;

// New bool value used for setting the selected gamemode.
static BYTE m_bSelectedGamemode = 2;

// New static unsigned int 8 for keeping track of the current position of the game select cursor.
static UINT8 m_nGameSelectCursorPos = 0;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// DisplaySplashScreen: Set data and display everything needed for the Splash Screen.
//--------------------------------------------------------------------------------------
void DisplaySplashScreen(void)
{
    // Change the colors to allow black 
    // to be the traparent color for the 
    // background.

    //0x27 = 00 10 01 11
    // 00: White,
    // 01: Light Grey,
    // 10: Dark Grey,
    // 11: Black.
    BGP_REG = 0x27;

    // Set data and tiles for the background layer
    set_bkg_data(0, 55, m_caSplashTiles);
    set_bkg_tiles(0, 0, 20, 18, m_caSplashMap);

    // Set the letters sprite sheet to after
    // backgrounds in VRAM.
    set_bkg_data(128, 40, m_caLetters);

    // Display the background layer
    SHOW_BKG;

    // Wait slighty before playing.
    PerformantDelay(65);

    // Play the splash sound.
    PlaySplashScreenSound();

    // Wait a few frames and then fade out splash screen
    PerformantDelay(135);
    FadeDrawLayer(0, 1, 0x67, 0xBB, 0xFB, 0xFF, 15);
}

//--------------------------------------------------------------------------------------
// DisplayStartScreen: Set data and display everything needed for the Start Screen.
//--------------------------------------------------------------------------------------
void DisplayStartScreen(void)
{
    // Set data and tiles for the background layer
    set_bkg_data(0, 99, m_caStartScreenTiles);
    set_bkg_tiles(0, 0, 20, 18, m_caStartScreen);

    // Set the Press Start text.
    PrintTextToLayer(0, 4, 14, "Press  Start");

    // the critical tags ensure no interrupts will be called 
    // while this block of code is being executed.
    __critical 
    {
        // Init and use huge drive to play song1.
        hUGE_init(&m_sSong1);
        add_VBL(hUGE_dosound);
    }

    // Fade in the start screen from previous background
    FadeDrawLayer(0, 0, 0xFB, 0xBB, 0xE4, 0x00, 15);

    // Pause
    PerformantDelay(25);

    // Hold programm until the start button is pressed
    waitpad(J_START);

    // Mute the main channel that other audio plays on.
    hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH2, HT_CH_MUTE);

    // Play the start sound after button press
    PlayStartSound();
    
    // Fade out StartScreen.
    FadeDrawLayer(0, 1, 0xE4, 0x90, 0x40, 0x00, 15);

    // Small delay to allow sound to play
    PerformantDelay(10);
}

//--------------------------------------------------------------------------------------
// SetupMainMenuCursor: Prepare a new cursor to use for the main menu.
//--------------------------------------------------------------------------------------
void SetupGameSelectCursor(void) 
{
    // Set main menu cursor settings.
    m_oMainMenuCursor.nSpriteID = 5;
    m_oMainMenuCursor.nTileID = 45;
    m_oMainMenuCursor.nBtnCount = 2;
    m_oMainMenuCursor.nStartX = 30;
    m_oMainMenuCursor.nStartY = 68;
    m_oMainMenuCursor.nStepX = 0;
    m_oMainMenuCursor.nStepY = 48;
    m_oMainMenuCursor.nIndex = m_nGameSelectCursorPos;
    m_oMainMenuCursor.nPrevJoy = 0;
    m_oMainMenuCursor.nDistance = 105;

    // Reset uneeded sprites.
    set_sprite_tile(7, SPRITE_SHEET_EMPTY_SLOT);
    set_sprite_tile(8, SPRITE_SHEET_EMPTY_SLOT);
    move_sprite(7, 0, 0);
    move_sprite(8, 0, 0);

    // Initiate the new cursor object.
    InitMenuCursor(&m_oMainMenuCursor);
}

//--------------------------------------------------------------------------------------
// SetupModeSelectCursor: Prepare a new cursor to use for the difficulty menu.
//--------------------------------------------------------------------------------------
void SetupModeSelectCursor(UINT16 nScore) 
{
    // Set main menu cursor settings.
    m_oMainMenuCursor.nSpriteID = 5;
    m_oMainMenuCursor.nTileID = 45;
    m_oMainMenuCursor.nBtnCount = 2;
    m_oMainMenuCursor.nStartX = 55;
    m_oMainMenuCursor.nStartY = 120;
    m_oMainMenuCursor.nStepX = 0;
    m_oMainMenuCursor.nStepY = 16;
    m_oMainMenuCursor.nIndex = 0;
    m_oMainMenuCursor.nPrevJoy = 0;
    m_oMainMenuCursor.nDistance = 56;

    // If the highscore is not at least
    // 1000 for the easy mode, then we
    // dont want to allow selection of hard.
    if (nScore < 1000)
    {
        // Set button count to 1
        m_oMainMenuCursor.nBtnCount = 0;
        m_oMainMenuCursor.nStepY = 0;

        // Add a lock sprite to hard mode.
        set_sprite_tile(7, 80);
        set_sprite_tile(8, 80);
        move_sprite(7, 55, 136);
        move_sprite(8, 112, 136);
    }
    
    // Initiate the new cursor object.
    InitMenuCursor(&m_oMainMenuCursor);
}

//--------------------------------------------------------------------------------------
// ShowGameSelectMenu: Show the Menu UI for selecting Gamemodes A or B.
//
// Params:
//      bMode: Pointer to the current gameMode, used for setting gamemode.
//      bDiff: Pointer to the current difficulty, used for setting the difficulty.
//--------------------------------------------------------------------------------------
void ShowGameSelectMenu(BYTE* bMode, BYTE* bDiff)
{
    // Temp variables used throughout method
    BOOLEAN bAwaitingModeSelection = TRUE;
    UINT8 nCursorPos = 0;
    UINT8 nCursorAniFrame = 0;
    UINT8 nCursorAniCounter = 0;
    UINT8 anMenuY[2] = {68, 116};
    UINT8 nJoy; UINT8 nPrevJoy;

    // Set data and tiles for the game select background layer
    set_bkg_data(0, 82, m_caGameSelectTiles);
    set_bkg_tiles(0, 0, 20, 18, m_caGameSelect);

    // Set the Game Select title text
    PrintTextToLayer(0, 4, 1, "Game  Select");

    // Set 2 sprites used for the indicators
    set_sprite_tile(5, 45);
    set_sprite_tile(6, 46);

    // Fade in the Select Menu.
    FadeDrawLayer(0, 0, 0xFB, 0xBB, 0xE4, 0x00, 15);

    // Ensure previous joypad value is at 0;
    nPrevJoy = 0;

    // Update the Cursor used for the Main Menu.
    SetupGameSelectCursor();

    // While awaiting gamemode selection.
    while (bAwaitingModeSelection)
    {
        // Get the joypad inputs.
        nJoy = joypad();

        // Update the Cursor used for the Main Menu.
        UpdateMenuCursor(&m_oMainMenuCursor, nJoy, TRUE);

        // Hide the window, which is currently
        // showing the Difficulty select.
        HIDE_WIN;

        // MAKE GAME SELECTION
        if (nJoy & J_A && !(nPrevJoy & J_A) || nJoy & J_START && !(nPrevJoy & J_START)) 
        {
            // Store the cursor position for when we return to game select menu
            m_nGameSelectCursorPos = m_oMainMenuCursor.nIndex;

            // Play button accept sound.
            PlayStartSound();

            // Open difficulty select menu based on gamemode.
            ShowDifficultySelectMenu(m_oMainMenuCursor.nIndex, nJoy, nPrevJoy);

            // If a difficulty has been selected.
            if (m_bSelectedDifficulty != 2)
            {
                // Update the pointers to gamemode/difficulty.
                *bMode = m_bSelectedGamemode;
                *bDiff = m_bSelectedDifficulty;

                // Ensure that we reset all the cursor sprites.
                set_sprite_tile(5, SPRITE_SHEET_EMPTY_SLOT);
                set_sprite_tile(6, SPRITE_SHEET_EMPTY_SLOT);
                set_sprite_tile(7, SPRITE_SHEET_EMPTY_SLOT);
                set_sprite_tile(8, SPRITE_SHEET_EMPTY_SLOT);
                move_sprite(5, 0, 0); move_sprite(6, 0, 0);
                move_sprite(7, 0, 0); move_sprite(8, 0, 0);

                // Break out of the while loop.
                // A selection of gamemode and 
                // difficulty has been made.
                bAwaitingModeSelection = FALSE;
            }
        }

        // Store the current joypad input to compare next frame.
        nPrevJoy = nJoy;

        // Add a slight delay to ensure cursor updates.
        PerformantDelay(1);
    }
    
    // Small delay to allow sound to play
    PerformantDelay(10);
}

//--------------------------------------------------------------------------------------
// ShowDifficultySelectMenu: Show the Menu UI for selecting a difficulty for a gamemode.
//
// Params:
//      bMode: The current gamemode that is selected.
//      nJoy: The Joypad for checking input.
//      nPrevJoy: The last Joypad input.
//--------------------------------------------------------------------------------------
void ShowDifficultySelectMenu(BYTE bMode, UINT8 nJoy, UINT8 nPrevJoy)
{
    // Declare variables 
    // for later use.
    UINT8 nX, nY;
    BOOLEAN bAwaitingInput = TRUE;
    
    // Set the data of the window layer.   
    set_win_data(0, 82, m_caGameSelectTiles);
    
    // Loop through all window tiles and set to blank.
    for(nY = 0; nY < 18; ++nY) for(nX = 0; nX < 20; ++nX) set_win_tile_xy(nX, nY, 81);

    // Show text on the Window layer for buttons.
    PrintTextToLayer(1, 5, 8, "HIGH SCORE");
    PrintTextToLayer(1, 8, 13, "EASY");
    PrintTextToLayer(1, 8, 15, "HARD");

    // If MODE A
    if (bMode == 0)
    {
        // Set the game title section of the window based on selected gamemode.
        set_win_tiles(0, 1, 20, 6, m_caModeSelectA);

        // Show the intial highscore data for easy mode
        PrintIntToWindow(8, 10, m_oHighScoreData.nHighScoreAEasy);

        // Show the window.
        SHOW_WIN;

        // Setup new cursor object for this menu.
        SetupModeSelectCursor(m_oHighScoreData.nHighScoreAEasy);
    }
    
    // If MODE B
    else 
    {
        // Set the game title section of the window based on selected gamemode.
        set_win_tiles(0, 1, 20, 6, m_caModeSelectB);

        // Show the intial highscore data for easy mode
        PrintIntToWindow(7, 10, m_oHighScoreData.nHighScoreBEasy);

        // Set the grading for the highscore.
        char cGrade[2];
        GetScoreGrade(cGrade, m_oHighScoreData.nHighScoreBEasy, m_oHighScoreData.nShotsTakenEasy);
        PrintTextToLayer(1, 12, 10, cGrade);

        // Show the window.
        SHOW_WIN;

        // Setup new cursor object for this menu.
        SetupModeSelectCursor(m_oHighScoreData.nHighScoreBEasy);
    }
    
    // Store the current joypad input to compare next frame.
    nPrevJoy = nJoy;

    // While awaiting for input in this Menu.
    while (bAwaitingInput)
    {
        // Get the joypad inputs.
        nJoy = joypad();

        // Update the Cursor used for the Main Menu.
        UpdateMenuCursor(&m_oMainMenuCursor, nJoy, TRUE);

        // Apply a slight dekay to apply cursor to update.
        PerformantDelay(1);

        // Update the highscore based on the current gamemode
        // and the difficulty selected.
        if (bMode == 0)
        {
            if (m_oMainMenuCursor.nIndex == 0) PrintIntToWindow(8, 10, m_oHighScoreData.nHighScoreAEasy);
            else PrintIntToWindow(8, 10, m_oHighScoreData.nHighScoreAHard);
        }

        else
        {
            if (m_oMainMenuCursor.nIndex == 0)
            {
                PrintIntToWindow(7, 10, m_oHighScoreData.nHighScoreBEasy);

                // Set the grading for the highscore.
                char cGrade[2];
                GetScoreGrade(cGrade, m_oHighScoreData.nHighScoreBEasy, m_oHighScoreData.nShotsTakenEasy);
                PrintTextToLayer(1, 12, 10, cGrade);
            }
            
            else 
            {
                PrintIntToWindow(7, 10, m_oHighScoreData.nHighScoreBHard);

                // Set the grading for the highscore.
                char cGrade[2];
                GetScoreGrade(cGrade, m_oHighScoreData.nHighScoreBHard, m_oHighScoreData.nShotsTakenHard);
                PrintTextToLayer(1, 12, 10, cGrade);
            }
        }

        // MAKE SELECTION
        if (nJoy & J_A && !(nPrevJoy & J_A) || nJoy & J_START && !(nPrevJoy & J_START)) 
        {
            // Set modes
            m_bSelectedDifficulty = m_oMainMenuCursor.nIndex;
            m_bSelectedGamemode = bMode;
            
            // Exit loop
            bAwaitingInput = FALSE;
            
            // Play button accept sound.
            PlayStartSound();
        }

        // GO BACK TO GAME MENU
        if (nJoy & J_B && !(nPrevJoy & J_B)) 
        {
            // Set modes as null
            m_bSelectedDifficulty = 2;
            m_bSelectedGamemode = 2;

            // Exit loop
            bAwaitingInput = FALSE;

            // Play back sound.
            PlayStartSoundReversed();
        }

        // Store the current joypad input to compare next frame.
        nPrevJoy = nJoy;
    }

    // Return cursor back to the main menu.
    SetupGameSelectCursor();
}

//--------------------------------------------------------------------------------------
// ShowLoadingScreen: Show the loading screen during gamemode initialization.
//--------------------------------------------------------------------------------------
void ShowLoadingScreen(void)
{
    // Declare variables 
    // for later use.
    UINT8 nX, nY;

    // Loop through all window tiles and set to blank.
    for(nY = 0; nY < 18; ++nY) for(nX = 0; nX < 20; ++nX) set_win_tile_xy(nX, nY, 81);

    // Show Loading text on the window layer.
    PrintTextToLayer(1, 6, 11, "LOADING.");
}

//--------------------------------------------------------------------------------------
// ShowScoreGrade: Determine and show the grade based on the shots taken and kills.
//
// Params:
//      cCharacterOut: Pointer to char, used to set the string as we cant return char*.
//      nScore: The score value from player or highscore.
//      nShotsTaken: Shots taken from player or highscore.
//--------------------------------------------------------------------------------------
void GetScoreGrade(char* cCharacterOut, UINT16 nScore, UINT16 nShotsTaken)
{
    // Declare accuracy int
    UINT16 nAccuracy = 0;

    // Declare chars used to make up the grade.
    char cGrade = 'F';
    char cPlusMinus = ' ';

    // Ensure we dont divide by 0
    if (nShotsTaken != 0)
    {
        // Calculate the accuracy of shots.
        nAccuracy = (nScore * 100) / nShotsTaken;
    }

    // Determine the grade based on the accuracy and return.
    if (nAccuracy >= 95) { cGrade = 'S'; cPlusMinus = nAccuracy >= 98 ? 'S' : ' ' ; }
    else if (nAccuracy >= 90) { cGrade = 'A'; cPlusMinus = nAccuracy >= 93 ? '+' : (nAccuracy <= 91 ? '-' : ' ') ; }
    else if (nAccuracy >= 80) { cGrade = 'B'; cPlusMinus = nAccuracy >= 85 ? '+' : (nAccuracy <= 82 ? '-' : ' ') ; }
    else if (nAccuracy >= 70) { cGrade = 'C'; cPlusMinus = nAccuracy >= 75 ? '+' : (nAccuracy <= 72 ? '-' : ' ') ; }
    else if (nAccuracy >= 60) { cGrade = 'D'; cPlusMinus = nAccuracy >= 65 ? '+' : (nAccuracy <= 62 ? '-' : ' ') ; }
    else if (nAccuracy >= 50) { cGrade = 'E'; cPlusMinus = nAccuracy >= 55 ? '+' : (nAccuracy <= 52 ? '-' : ' ') ; }

    // print the results to screen.
    cCharacterOut[0] = cGrade;
    cCharacterOut[1] = cPlusMinus;
}

//--------------------------------------------------------------------------------------
// DisplayGameOverScreen: Set data and display everything needed for the GameOver Screen.
//
// Params:
//      bMode: The gamemode triggering the gameover.
//      bDiff: The difficulty of the gamemode.
//      nScore: The score value from player or highscore.
//      nShotsTaken: Shots taken from player or highscore.
//--------------------------------------------------------------------------------------
void DisplayGameOverScreen(BYTE bMode, BYTE bDiff, UINT16 nScore, UINT16 nShotsTaken)
{
    // Declare variables 
    // for later use.
    UINT8 nX, nY;

    // Small delay for affect.
    PerformantDelay(10);

    // Play death sound.
    PlayPlayerDeathSound();

    // Small delay to allow sound to play
    PerformantDelay(50);
    
    // Change screen color to indicate defeat.
    FadeDrawLayer(0, 1, 0xE4, 0x90, 0x40, 0x00, 15);

    // Print various bits of text to make the game over screen.
    printf(" \n"); printf(" \n"); printf(" \n"); printf(" \n");
    printf("     GAME  OVER     \n"); printf(" \n");
    
    // Fade back in the gameover screen.
    PerformantDelay(20);
    FadeDrawLayer(0, 1, 0x00, 0x40, 0x90, 0xE4, 1);

    // Play the gameover jingle note by note.
    PlayGameOverSound();
    
    // Small delay to allow sound to play
    PerformantDelay(60);

    // Play just the noise channel for music.
    hUGE_mute_channel(HT_CH4, HT_CH_PLAY);

    // Fade out the sprite layer
    FadeDrawLayer(1, 1, 0xE4, 0x90, 0x40, 0x00, 15);
    PerformantDelay(2);
    HIDE_SPRITES;

    // Wait a little and then scroll up the scores
    PerformantDelay(100);


    //
    HIDE_BKG;


    // Set the data of the window layer.   
    set_win_data(0, 82, m_caGameSelectTiles);
    
    // Loop through all window tiles and set to blank.
    for(nY = 0; nY < 18; ++nY) for(nX = 0; nX < 20; ++nX) set_win_tile_xy(nX, nY, 81);

    // Show text on the Window layer for buttons.
    PrintTextToLayer(1, 5, 13, "HIGH SCORE");

    // If MODE A
    if (bMode == 0)
    {
        // Set the game title section of the window based on selected gamemode.
        set_win_tiles(0, 1, 20, 6, m_caModeSelectA);
        
        // Set scores on the window based on difficulty.
        if (bDiff == 0)
        {
            PrintTextToLayer(1, 5, 8, "EASY  MODE");
            PrintIntToWindow(8, 10, nScore);
            PrintIntToWindow(8, 15, m_oHighScoreData.nHighScoreAEasy);
        }
        
        else
        {
            PrintTextToLayer(1, 5, 8, "HARD  MODE");
            PrintIntToWindow(8, 10, nScore);
            PrintIntToWindow(8, 15, m_oHighScoreData.nHighScoreAHard);
        }
    }
    
    // If MODE B
    else 
    {
        // Set the game title section of the window based on selected gamemode.
        set_win_tiles(0, 1, 20, 6, m_caModeSelectB);
        
        // Set scores on the window based on difficulty.

        // EASY MODE
        if (bDiff == 0)
        {
            // Set the Title and Score text
            PrintTextToLayer(1, 5, 8, "EASY  MODE");
            PrintIntToWindow(7, 10, nScore);
            PrintIntToWindow(7, 15, m_oHighScoreData.nHighScoreBEasy);

            // Set the grading for the current score.
            char cGrade[1];
            GetScoreGrade(cGrade, nScore, nShotsTaken);
            PrintTextToLayer(1, 12, 10, cGrade);

            // Set the grading for the highscore.
            GetScoreGrade(cGrade, m_oHighScoreData.nHighScoreBEasy, m_oHighScoreData.nShotsTakenEasy);
            PrintTextToLayer(1, 12, 15, cGrade);
        }
        
        // HARD MODE
        else
        {
            // Set the Title and Score text
            PrintTextToLayer(1, 5, 8, "HARD  MODE");
            PrintIntToWindow(7, 10, nScore);
            PrintIntToWindow(7, 15, m_oHighScoreData.nHighScoreBHard);

            // Set the grading for the current score.
            char cGrade[1];
            GetScoreGrade(cGrade, nScore, nShotsTaken);
            PrintTextToLayer(1, 12, 10, cGrade);

            // Set the grading for the highscore.
            GetScoreGrade(cGrade, m_oHighScoreData.nHighScoreBHard, m_oHighScoreData.nShotsTakenHard);
            PrintTextToLayer(1, 12, 15, cGrade);
        }
    }

    // Show the window.
    SHOW_WIN;

    // Wait a little and then scroll up the scores
    PerformantDelay(10);

    // Show the background
    SHOW_BKG;

    // Wait for Start button press
    waitpad(J_START | J_A | J_B | J_SELECT);

    // Play the start sound after button press
    PlayStartSound();
    
    // Small delay to allow sound to play
    PerformantDelay(15);

    // Reset the game completely.
    reset();
}
