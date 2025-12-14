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
    set_bkg_data(128, 39, m_caLetters);

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
    m_oMainMenuCursor.nIndex = 0;
    m_oMainMenuCursor.nPrevJoy = 0;
    m_oMainMenuCursor.nDistance = 105;

    set_sprite_tile(7, SPRITE_SHEET_EMPTY_SLOT);
    set_sprite_tile(8, SPRITE_SHEET_EMPTY_SLOT);
    move_sprite(7, 0, 0);
    move_sprite(8, 0, 0);

    // Initiate the new cursor object.
    InitMenuCursor(&m_oMainMenuCursor);
}


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







    
    if (nScore < 1000)
    {
        m_oMainMenuCursor.nBtnCount = 0;
        m_oMainMenuCursor.nStepY = 0;
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
//--------------------------------------------------------------------------------------
void ShowGameSelectMenu(BYTE* bMode, BYTE* bDiff, HighScoreData* ptrHighScoreData)
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

        // MAKE SELECTION
        if (nJoy & J_A && !(nPrevJoy & J_A) || nJoy & J_START && !(nPrevJoy & J_START)) 
        {






            // CURRENT FOR GETTING STRAIGHT IN //

            // Set the current gamemode, and exit the while loop.
            //*bMode = m_oMainMenuCursor.nIndex;
            //bAwaitingModeSelection = FALSE;

            // CURRENT FOR GETTING STRAIGHT IN //


            if (m_oMainMenuCursor.nIndex == 0)
            {
                SetupModeSelectCursor(ptrHighScoreData->nHighScoreAEasy);
                ShowGameModeSelectionScreen(0, nJoy, nPrevJoy, ptrHighScoreData, bDiff);
            }

            else
            {
                
                SetupModeSelectCursor(ptrHighScoreData->nHighScoreBEasy);
                ShowGameModeSelectionScreen(1, nJoy, nPrevJoy, ptrHighScoreData, bDiff);
            }



             // CANT DO THIS HERE.
            *bMode = m_oMainMenuCursor.nIndex;
            bAwaitingModeSelection = FALSE;




        }

        // Store the current joypad input to compare next frame.
        nPrevJoy = nJoy;

        PerformantDelay(1);
    }

    // Play the start sound after button press
    PlayStartSound();
    
    // Small delay to allow sound to play
    PerformantDelay(10);

    // Fade out MenuSelect screen.
    FadeDrawLayer(0, 1, 0xE4, 0x90, 0x40, 0x00, 15);
}













void ShowGameModeSelectionScreen(BYTE bMode, UINT8 nJoy, UINT8 nPrevJoy, HighScoreData* ptrHighScoreData, BYTE* bDiff)
{            
    set_win_data(0, 82, m_caGameSelectTiles);
    
    SHOW_WIN;

    UINT8 x, y;
    for(y = 0; y < 18; ++y) {
        for(x = 0; x < 20; ++x) {
            set_win_tile_xy(x, y, 81);
        }
    }

    if (bMode == 0)
    {
        set_win_tiles(0, 1, 20, 6, m_caModeSelectA);
    }

    else
    {
        set_win_tiles(0, 1, 20, 6, m_caModeSelectB);
    }
    
    // Show text on the Window layer for buttons.
    PrintTextToWindow(5, 8, "HIGH SCORE");
    
    if ((bMode == 0))
    {
        PrintIntToWindow(8, 10, ptrHighScoreData->nHighScoreAEasy);
    }

    else
    {
        PrintIntToWindow(8, 10, ptrHighScoreData->nHighScoreBEasy);
    }
    

    PrintTextToWindow(8, 13, "EASY");
    PrintTextToWindow(8, 15, "HARD");    

    BOOLEAN bAwaitingInput = TRUE;

    while (bAwaitingInput)
    {
        // Get the joypad inputs.
        nJoy = joypad();

        // Update the Cursor used for the Main Menu.
        UpdateMenuCursor(&m_oMainMenuCursor, nJoy, TRUE);

        //
        PerformantDelay(1);

        // MAKE SELECTION
        if (nJoy & J_A && !(nPrevJoy & J_A) || nJoy & J_START && !(nPrevJoy & J_START)) 
        {
            *bDiff = m_oMainMenuCursor.nIndex;
            bAwaitingInput = FALSE;
        }

        if (nJoy & J_B && !(nPrevJoy & J_B)) 
        {
            bAwaitingInput = FALSE;
        }

        

        // Store the current joypad input to compare next frame.
        nPrevJoy = nJoy;
    }


    // Update the Cursor used for the Main Menu.
    SetupGameSelectCursor();
    HIDE_WIN;
}



























//--------------------------------------------------------------------------------------
// ShowScoreGrade: Determine and show the grade based on the shots taken and kills.
//
// Params:
//      nScore: The score value from player or highscore.
//      nShotsTaken: Shots taken from player or highscore.
//--------------------------------------------------------------------------------------
void ShowScoreGrade(UINT16 nScore, UINT16 nShotsTaken)
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
    printf("%c%c", cGrade, cPlusMinus);
}

//--------------------------------------------------------------------------------------
// DisplayGameOverScreen: Set data and display everything needed for the GameOver Screen.
//
// Params:
//      bMode: The gamemode triggering the gameover.
//      nScore: The score value from player or highscore.
//      nShotsTaken: Shots taken from player or highscore.
//      nLoadedScore: The score value loaded from memory.
//      nLoadedShotsTaken: Shots taken value loaded from memory.
//--------------------------------------------------------------------------------------
void DisplayGameOverScreen(BOOLEAN bMode, UINT16 nScore, UINT16 nShotsTaken, UINT16 nLoadedScore, UINT16 nLoadedShotsTaken)
{
    // Small delay for affect.
    PerformantDelay(10);

    // Play death sound.
    NR41_REG = 0x15; NR42_REG = 0xFF; NR43_REG = 0x73; NR44_REG = 0xC0;

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
    
    // Note #1
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84;
    PerformantDelay(15);

    // Note #2
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84; 
    PerformantDelay(15);
    
    // Note #3
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x20; NR14_REG = 0x83; 
    PerformantDelay(15);

    // Note #4
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x20; NR14_REG = 0x83;
    PerformantDelay(15);
    
    // Note #5
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x78; NR14_REG = 0x85; 
    PerformantDelay(15);
    
    // Note #6
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84;
    PerformantDelay(15);
    
    // Note #7
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x90; NR14_REG = 0x81;
    PerformantDelay(15);
    
    // Note #8
    NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x78; NR14_REG = 0x85;
    PerformantDelay(60);

    // Fade out the sprite layer
    FadeDrawLayer(1, 1, 0xE4, 0x90, 0x40, 0x00, 15);
    PerformantDelay(2);
    HIDE_SPRITES;

    // Wait a little and then scroll up the scores
    PerformantDelay(100);

    // Print various bits of text to make the game over screen.

    // Score title and spacing.
    printf("     SCORE:");

    // Show the current score with 0 to ensure we show all 4 digits.
    printf("%u%u%u%u     ", nScore / 1000, 
        (nScore / 100) % 10, (nScore / 10) % 10, 
        nScore % 10);
       
    // Show Highscore for gamemode B
    if (bMode == 1)
    {
        // Grade title with spacing.
        printf(" \n"); printf("      GRADE:");
            
        // Show the current score accuracy grade.
        ShowScoreGrade(nScore, nShotsTaken);

        // Highscore title and spacing.
        printf(" \n"); printf(" \n"); printf(" \n");
        printf("    HIGH  SCORE: ");printf(" \n");printf(" \n");

        // Show the highscore with 0 to ensure we show all 4 digits.
        printf("      %u%u%u%u  ", nLoadedScore / 1000, 
        (nLoadedScore / 100) % 10, (nLoadedScore / 10) % 10, 
        nLoadedScore % 10);

        // Show the highscore accuracy grade.
        ShowScoreGrade(nLoadedScore, nLoadedShotsTaken);
    }

    // Show Highscore for gamemode A
    else
    {
        // Highscore title and spacing.
        printf(" \n"); printf(" \n"); printf(" \n");
        printf("    HIGH  SCORE: ");printf(" \n");printf(" \n");

        // Show the highscore with 0 to ensure we show all 4 digits.
        printf("      %u%u%u%u  ", nLoadedScore / 1000, 
        (nLoadedScore / 100) % 10, (nLoadedScore / 10) % 10, 
        nLoadedScore % 10);
    }

    // Press start title with spacing.
    printf("      \n"); printf(" \n");
    printf("    PRESS  START     \n");

    // Wait for Start button press
    waitpad(J_START);

    // Play the start sound after button press
    NR41_REG = 0x13;
    NR42_REG = 0x35;
    NR43_REG = 0x28;
    NR44_REG = 0xC0;
    
    // Small delay to allow sound to play
    PerformantDelay(15);

    // Reset the game completely.
    reset();
}
