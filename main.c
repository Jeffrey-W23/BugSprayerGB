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

// includes for main gameObject.
#include "Entities/enemies.h"
#include "UI/hud.h"
#include "Entities/player.h"
#include "Data-Systems/save.h"
#include "Gamemodes/enemyManagerA.h"
#include "Gamemodes/enemyManagerB.h"

// includes for music realted scripts
#include "hUGEDriver.h"

// includes for the splash screen
#include "Sprite-Sheets/SplashTiles.c"
#include "Tile-Maps/SplashMap.c"

// Includes for the background layer
#include "Sprite-Sheets/BackgroundTiles.c"
#include "Tile-Maps/Background.c"

// Includes for the startscreen layer
#include "Sprite-Sheets/StartScreen.c"
#include "Tile-Maps/StartScreen.c"

// Includes for the startscreen layer
#include "Sprite-Sheets/GameSelectTiles.c"
#include "Tile-Maps/GameSelect.c"


// includes for the sprite layer
#include "Sprite-Sheets/Sprites.c"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// New Player object for storing and setting player information.
static Player m_oPlayer;

// New unsighed int 8 for getting and storing the joypad positions.
static UINT8 m_nJoy; UINT8 m_nPrevJoy;

// New static unsighed int 16 Used for storing the current score shown on the hud each frame.
static UINT16 m_nCurrentHudScore;

// New static unsighed int 16s for storing and setting the previous score/health values.
static UINT16 m_nPrevHealth = 9999; static UINT16 m_nPrevScore = 9999;

// New unsigned int 8 for keeping track of background fading stages. 
static UINT8 m_nFadeIndex;

// New unsigned int 16 for the loaded saved score, representing the highscore.
UINT16 m_nLoadedScore = 0;

// New unsigned int 16 for the loaded saved shotsTaken, used to determine score grade.
UINT16 m_nLoadedShotsTaken = 0;

// New signed int 8 for damage an enemy does to the player on hit.
static UINT8 m_nDamgeToPlayer = 25;

// New const huge song variable for the main song file of the game.
extern const hUGESong_t m_sSong1;

// New byte for keeping track of the current set gameMode.
extern BYTE m_bCurrentGameMode = 0;

// New bool value for if the game is currently paused.
static BOOLEAN m_bPaused = FALSE;

// New static unsigned int 8 used for the current tick in blinking the screen.
static UINT8 m_nBlinkTimer = 0;

// New static unsigned int 8 for the current state of blinking for blicking the screen.
static UINT8 m_nBlinkState = 0;  

// New static unsigned int 16 for the current amount of time before health can recovery for gamemode B.
static UINT16 m_nDamgeTimer = 400;

// New bool value for if the health can recover after not taking damage for gamemode B.
static BOOLEAN m_bRecoverHealth = FALSE;

// New bool value for if the extra life pie in the oven is currently showing for gamemode A.
static BOOLEAN m_bExtraLifeActive = FALSE;

// New bool value for if the extra life pie in the oven has been collected for gamemode A.
static BOOLEAN m_bLifeCollected = FALSE;

// New static unsigned int 8 for the current frame of the pie animation for gamemode A.
static UINT8 m_nPieAniFrame = 0;

// New static unsigned int 8 for ticking the pie animation for gamemode A.
static UINT8 m_nPieAniCounter = 0;

// New const array of unsigned int 8s for each frame of the pie, needed for animating the sprite. For gamemode A.
const UINT8 m_anPieSpriteIDs[4] = {107, 108, 109, 110};
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// SetDialog: Set a new dialog map for the window layer, Also sets the width, height 
// and x and y position.
// 
// Params:
//      cpDialog: Pointer to the dialog object to draw on window layer
//      nW: The width of the dialog object
//      nH: The hight of the dialog object
//      nX: The x position in the window layer
//      nY: The y poistion in the window layer
//--------------------------------------------------------------------------------------
void SetDialog(char* cpDialog, UINT8 nW, UINT8 nH, UINT8 nX, UINT8 nY)
{
    // Set the data for the window layer and move it into place
    set_win_tiles(0, 0, nW, nH, cpDialog);
    move_win(nX, nY);
}

//--------------------------------------------------------------------------------------
// PerformantDelay: A function for delaying the system based on screen draws
// 
// Params:
//      nLoops: Number of times to wait for the screen to redraw.
//--------------------------------------------------------------------------------------
void PerformantDelay(UINT8 nLoops)
{
    // new uint8 for the for loop index
    UINT8 i;

    // Loop through however many loops are required
    for (i = 0; i < nLoops; i++)
    {
        // wait for one screen has been drawn
        // gives a less cpu strain delay
        wait_vbl_done();
    }
}

//--------------------------------------------------------------------------------------
// FadeDrawLayer: A universal function for fading in or out the background or sprite layer 
// with custom color choices and delay.
//
// Helpful:
//      00: White,
//      01: Light Grey,
//      10: Dark Grey,
//      11: Black.
//      Convert to hexadecimal: eg. 0x27 = 00 10 01 11
//
// Params:
//      bLayer: 0 or 1 for Background or Sprite layer.
//      bMode: 0 or 1 for Fade Out or Fade In.
//      nValue1: The first color change in hexadecimal.
//      nValue2: The second color change in hexadecimal.
//      nValue3: The third color change in hexadecimal.
//      nValue4: The fourth color change in hexadecimal.
//      nDelay: The amount of frames it takes to get through thr fade.
//--------------------------------------------------------------------------------------
void FadeDrawLayer(BYTE bLayer, BYTE bMode, UINT8 nValue1, UINT8 nValue2, UINT8 nValue3, UINT8 nValue4, UINT8 nDelay)
{
    // The amount of times to loop, based
    // on if it is a fade out or fade in
    UINT8 nLoopAmount;

    // if the mode value is set to 1 set the loop amount
    // to 4, this is for the fade out.
    if (bMode == 1)
    {
        nLoopAmount = 4;
    }

    // else if the value is 0 set the loop amount to 3
    // This is for Fade In.
    else
    {
        nLoopAmount = 3;
    }

    // Loop through however many colors are needed for the fade.
    for(m_nFadeIndex = 0; m_nFadeIndex < nLoopAmount; m_nFadeIndex++)
    {
        // Check which layer to fade.
        if (bLayer == 0)
        {
            // Switch statement for setting background color for each
            // iteration through the for loop
            switch(m_nFadeIndex)
            {
                case 0:
                    BGP_REG = nValue1;
                break;

                case 1:
                    BGP_REG = nValue2;
                break;

                case 2:
                    BGP_REG = nValue3;
                break;

                case 3:
                    BGP_REG = nValue4;
                break;
            }
        }

        else
        {
            // Switch statement for setting sprite layer color for each
            // iteration through the for loop
            switch(m_nFadeIndex)
            {
                case 0:
                    OBP0_REG = nValue1;
                break;

                case 1:
                    OBP0_REG = nValue2;
                break;

                case 2:
                    OBP0_REG = nValue3;
                break;

                case 3:
                    OBP0_REG = nValue4;
                break;
            }
        }

        // Hold program, this is for the speed of the fade
        PerformantDelay(nDelay);
    }
}

//--------------------------------------------------------------------------------------
// BlinkScreen: Basic timer and switchstatement to blink screen.
//--------------------------------------------------------------------------------------
void BlinkScreen(void)
{
    // Increase blink time
    m_nBlinkTimer++;
    
    // If blink time reaches 20
    if (m_nBlinkTimer >= 20) 
    {
        // reset timer
        m_nBlinkTimer = 0;

        // Set the state.
        m_nBlinkState = (m_nBlinkState + 1) % 3;

        // Set the color of the screen based on the state.
        // this creates blink effect as it moves through colors.
        switch(m_nBlinkState) 
        {
            case 0: BGP_REG = 0xE4; break;  // Normal
            case 1: BGP_REG = 0xB0; break;  // Dims
            case 2: BGP_REG = 0xE4; break;  // Normal
        }
    }
}

//--------------------------------------------------------------------------------------
// LoadHighScoreData: Load highscore data from previous game sessions.
//
// Params:
//      bMode: The current mode trying to load highscore.
//--------------------------------------------------------------------------------------
void LoadHighScoreData(BOOLEAN bMode) 
{
    // Delcare temp vars for setting.
    UINT16 nLoadedScore = 0;
    UINT16 nLoadedShotsTaken = 0;

    // Load the game data from memory
    LoadGameData(bMode, &nLoadedScore, &nLoadedShotsTaken);

    // Set the load values in the main.c
    m_nLoadedScore = nLoadedScore;
    m_nLoadedShotsTaken = nLoadedShotsTaken;
}

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

    // Display the background layer
    SHOW_BKG;

    // Wait slighty before playing.
    PerformantDelay(65);
    
    // Play the splash screen sound
    // First Note
    NR10_REG = 0x78;
    NR11_REG = 0x81;
    NR12_REG = 0x42;
    NR13_REG = 0x9E;
    NR14_REG = 0x87;
    
    // Pause
    PerformantDelay(10);
    
    // Second Note
    NR10_REG = 0x78;
    NR11_REG = 0x81;
    NR12_REG = 0x42;
    NR13_REG = 0x72;
    NR14_REG = 0x86;

    // Pause
    PerformantDelay(8);
    
    // Third Note
    NR10_REG = 0x78;
    NR11_REG = 0x81;
    NR12_REG = 0x42;
    NR13_REG = 0xAA;
    NR14_REG = 0x85;

    // Wait a few frames and then fade out splash screen
    PerformantDelay(135);
    FadeDrawLayer(0, 1, 0x67, 0xBB, 0xFB, 0xFF, 15);
}

//--------------------------------------------------------------------------------------
// DisplayStartScreen: Set data and display everything needed for the Start Screen.
//--------------------------------------------------------------------------------------
void DisplayStartScreen(void)
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;

    // Set data and tiles for the background layer
    set_bkg_data(0, 127, m_caStartScreenTiles);
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

    // Set sprite data based on spritesheet
    SPRITES_8x8; 
    set_sprite_data(0, 114, m_caSprites);

    // Display the sprite layer
    SHOW_SPRITES;

    // My sprite sheets are full, use sprite layer instead.
    // Set the "Press Start" text for the StartScreen.
    set_sprite_tile(0, 41); move_sprite(0, 34, 135); // P
    set_sprite_tile(1, 42); move_sprite(1, 44, 135); // R
    set_sprite_tile(2, 43); move_sprite(2, 54, 135); // E
    set_sprite_tile(5, 44); move_sprite(5, 64, 135); // S
    set_sprite_tile(6, 44); move_sprite(6, 74, 135); // S
    set_sprite_tile(7, 44); move_sprite(7, 94, 135); // S
    set_sprite_tile(8, 45); move_sprite(8, 104, 135); // T
    set_sprite_tile(9, 46); move_sprite(9, 114, 135); // A
    set_sprite_tile(10, 42); move_sprite(10, 124, 135); // R
    set_sprite_tile(11, 45); move_sprite(11, 134, 135); // T

    // Hold programm until the start button is pressed
    waitpad(J_START);

    // Mute the main channel that other audio plays on.
    hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH2, HT_CH_MUTE);

    // Loop through all the sprites to
    // make up the "Press Start" text
    // and reset them ready for gameplay.
    for(i = 0; i < 12; i++) 
    {
        set_sprite_tile(i, 0); 
        move_sprite(i, 0, 0);
    }

    // Play the start sound after button press
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86; PerformantDelay(5);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86;
    
    // Fade out StartScreen.
    FadeDrawLayer(0, 1, 0xE4, 0x90, 0x40, 0x00, 15);

    // Small delay to allow sound to play
    PerformantDelay(10);
}

//--------------------------------------------------------------------------------------
// ShowGameSelectMenu: Show the Menu UI for selecting Gamemodes A or B.
//--------------------------------------------------------------------------------------
void ShowGameSelectMenu(void)
{
    // Temp variables used throughout method
    BOOLEAN bAwaitingModeSelection = TRUE;
    UINT8 nCursorPos = 0;
    UINT8 nCursorAniFrame = 0;
    UINT8 nCursorAniCounter = 0;
    UINT8 anMenuCenterX[2] = {130, 130};
    UINT8 anMenuY[2] = {68, 116};

    // Set data and tiles for the game select background layer
    set_bkg_data(0, 125, m_caGameSelectTiles);
    set_bkg_tiles(0, 0, 20, 18, m_caGameSelect);

    // Set 2 sprites used for the indicators
    set_sprite_tile(5, 112);
    set_sprite_tile(6, 113);

    // Fade in the Select Menu.
    FadeDrawLayer(0, 0, 0xFB, 0xBB, 0xE4, 0x00, 15);

    // Ensure previous joypad value is at 0;
    m_nPrevJoy = 0;

    // While awaiting gamemode selection.
    while (bAwaitingModeSelection)
    {
        // Setting variables for later use.
        UINT8 nOffset;

        // Get the joypad inputs.
        m_nJoy = joypad();

        // MOVE CURSOR UP
        if (m_nJoy & J_UP && !(m_nPrevJoy & J_UP)) 
        {
            nCursorPos = (nCursorPos > 0) ? 0 : 1;
        }

        // MOVE CURSOR DOWN
        if (m_nJoy & J_DOWN && !(m_nPrevJoy & J_DOWN)) 
        {
            nCursorPos = (nCursorPos < 1) ? 1 : 0;
        }

        // MOVE CURSOR DOWN (SELECT BUTTON)
        if (m_nJoy & J_SELECT && !(m_nPrevJoy & J_SELECT))
        {
            nCursorPos = (nCursorPos < 1) ? 1 : 0;
        }

        // MAKE SELECTION
        if (m_nJoy & J_A && !(m_nPrevJoy & J_A) || m_nJoy & J_START && !(m_nPrevJoy & J_START)) 
        {
            // Set the current gamemode, and exit the while loop.
            m_bCurrentGameMode = nCursorPos;
            bAwaitingModeSelection = FALSE;
        }

        // Store the current joypad input to compare next frame.
        m_nPrevJoy = m_nJoy;

        // Animate the Cursor/Selector
        // moving it in and out from the
        // currently selected button.

        // Increase the aniCounter
        nCursorAniCounter++;

        // Wait certain amount of frames 
        if (nCursorAniCounter >= 250) 
        {   
            // Reset the counter
            nCursorAniCounter = 0;

            // Advance the cursor animation frame.
            nCursorAniFrame++;
            
            // Reset the cursor animation frame back to 0
            if (nCursorAniFrame >= 4) nCursorAniFrame = 0;
        }

        // Determine offset of the cursors
        if(nCursorAniFrame == 0) nOffset = 0;
        else if(nCursorAniFrame == 1) nOffset = 1;
        else if(nCursorAniFrame == 2) nOffset = 2;
        else nOffset = 1;

        // Move the selector arrows on each side of buttons
        move_sprite(5,  anMenuCenterX[nCursorPos] + nOffset, anMenuY[nCursorPos]);
        move_sprite(6, anMenuCenterX[nCursorPos] + 7 - nOffset, anMenuY[nCursorPos]);
    }

    // Play the start sound after button press
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86; PerformantDelay(5);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86;
    
    // Small delay to allow sound to play
    PerformantDelay(10);

    // Fade out MenuSelect screen.
    FadeDrawLayer(0, 1, 0xE4, 0x90, 0x40, 0x00, 15);
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
//--------------------------------------------------------------------------------------
void DisplayGameOverScreen(BOOLEAN bMode)
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
    printf("%u%u%u%u     ", m_oPlayer.nScore / 1000, 
        (m_oPlayer.nScore / 100) % 10, (m_oPlayer.nScore / 10) % 10, 
        m_oPlayer.nScore % 10);
       
    // Show Highscore for gamemode B
    if (bMode == 1)
    {
        // Grade title with spacing.
        printf(" \n"); printf("      GRADE:");
            
        // Show the current score accuracy grade.
        ShowScoreGrade(m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);

        // Highscore title and spacing.
        printf(" \n"); printf(" \n"); printf(" \n");
        printf("    HIGH  SCORE: ");printf(" \n");printf(" \n");

        // Show the highscore with 0 to ensure we show all 4 digits.
        printf("      %u%u%u%u  ", m_nLoadedScore / 1000, 
        (m_nLoadedScore / 100) % 10, (m_nLoadedScore / 10) % 10, 
        m_nLoadedScore % 10);

        // Show the highscore accuracy grade.
        ShowScoreGrade(m_nLoadedScore, m_nLoadedShotsTaken);
    }

    // Show Highscore for gamemode A
    else
    {
        // Highscore title and spacing.
        printf(" \n"); printf(" \n"); printf(" \n");
        printf("    HIGH  SCORE: ");printf(" \n");printf(" \n");

        // Show the highscore with 0 to ensure we show all 4 digits.
        printf("      %u%u%u%u  ", m_nLoadedScore / 1000, 
        (m_nLoadedScore / 100) % 10, (m_nLoadedScore / 10) % 10, 
        m_nLoadedScore % 10);
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

//--------------------------------------------------------------------------------------
// SetScoreOnHud: Universal mode for both modes, updates the score on the
// hud if the score is changed since last frame.
//--------------------------------------------------------------------------------------
void SetScoreOnHud(void)
{
    // Only update the score if it changes.
    if (m_nCurrentHudScore != m_nPrevScore) 
    {
        // Update the score UI in the hud.
        SetScore(m_nCurrentHudScore);

        // Update the previous score for next frames check.
        m_nPrevScore = m_nCurrentHudScore;
    }
}

//--------------------------------------------------------------------------------------
// Initialize: Prepare the application for launch.
//--------------------------------------------------------------------------------------
void Initialize(void)
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;

    // Temp bool to determine the mode to load.
    BOOLEAN bAwaitingModeSelection = TRUE;

    // Sound registers, must be in this order.
    NR52_REG = 0x80; // Turn on the sound.
    NR50_REG = 0x77; // Set the volume of the left and right channel
    NR51_REG = 0xFF; // Set usage to both channels

    // Display the splash screen background
    DisplaySplashScreen();

    // Display the start screen background
    DisplayStartScreen();

    // Display the GameSelect/MainMenu
    ShowGameSelectMenu();

    // My sprite sheets are full, use sprite layer instead.
    // Set the "Loading.." text for the transition 
    // between startScreen and game.
    set_sprite_tile(5, 114); move_sprite(5, 44, 105); // ..
    set_sprite_tile(6, 95); move_sprite(6, 54, 105); // L
    set_sprite_tile(7, 96); move_sprite(7, 64, 105); // O
    set_sprite_tile(8, 46); move_sprite(8, 74, 105); // A
    set_sprite_tile(9, 97); move_sprite(9, 84, 105); // D
    set_sprite_tile(10, 98); move_sprite(10, 94, 105); // I
    set_sprite_tile(11, 99); move_sprite(11, 104, 105); // N
    set_sprite_tile(12, 100); move_sprite(12, 114, 105); // G
    set_sprite_tile(13, 114); move_sprite(13, 124, 105); // ..

    // Hide the background while things load.
    HIDE_BKG;

    // Used for better random gen
    VBK_REG = 0;

    // Turn on GameBoy display
    DISPLAY_ON;

    // Initiate random system
    initrand(DIV_REG | (LY_REG << 8));

    // Start initalizing gameMode A
    if (m_bCurrentGameMode == 0)
    {
        // Load highscore data
        InitSaveData();
        LoadHighScoreData(0);

        // Initiate the player and hud objects
        InitPlayer(1, &m_oPlayer);
        UpdatePlayer(&m_oPlayer);
        InitHud();

        // Prepare enemies manager.
        for(i = 0; i < MAX_ENEMIES; i++) 
        {
            InitEnemy(i);
        }

        // Initiate the Enemies spawner.
        InitiateSpawner();

        // Set the damage to player when getting hit
        // by an enemy to 1 as the player has hearts
        // for this gamemode.
        m_nDamgeToPlayer = 1;
    }

    // Start initalizing gameMode B
    else if (m_bCurrentGameMode == 1)
    {
        // Load highscore data
        InitSaveData();
        LoadHighScoreData(1);

        // Initiate the player and hud objects
        InitPlayer(0, &m_oPlayer);
        UpdatePlayer(&m_oPlayer);
        InitHud();

        // Prepare enemies manager.
        for(i = 0; i < MAX_ENEMIES; i++) 
        {
            InitEnemy(i);
        }

        // Prepare spawn quque for enemies.
        InitEnemiesSpawnQueue();
    }

    // Loop through all the sprites to
    // make up the "Loading.." text
    // and reset them ready for gameplay.
    for(i = 5; i < 14; i++) 
    {
        set_sprite_tile(i, 0); 
        move_sprite(i, 0, 0);
    }

    // Set the level background data, and load.
    set_bkg_data(0, 127, m_caBgTiles);
    set_bkg_tiles(0, 0, 20, 18, m_caBackground);

    // Show the background again, fading in nicely.
    SHOW_BKG;
    FadeDrawLayer(0, 0, 0x00, 0x40, 0x90, 0xE4, 8);

    // Set the current palette  color
    BGP_REG = 0xE4;
}

//--------------------------------------------------------------------------------------
// AnimatePie: Animate the pie object each frame in the background of gamemode A.
//--------------------------------------------------------------------------------------
void AnimatePie(void) 
{
    // Increase the ani counter
    m_nPieAniCounter++;
    
    // Every 20 frame change the pie sprite.
    if (m_nPieAniCounter >= 20) 
    {
        m_nPieAniCounter = 0;
        m_nPieAniFrame = (m_nPieAniFrame + 1) % 4;
        set_sprite_tile(6, m_anPieSpriteIDs[m_nPieAniFrame]);
    }
}

//--------------------------------------------------------------------------------------
// UpdateExtraLife: Update logic around the extra life system for gamemode A.
//--------------------------------------------------------------------------------------
void UpdateExtraLife(void) 
{
    // Check if score crossed a multiple of 200 threshold.
    // Ensure we only check this if score actually changes,
    // and ensure that the life isn't currently showing and
    // the player isn't already at the maximum health value.
    if (m_oPlayer.nScore > m_nPrevScore && m_oPlayer.nScore % 200 == 0 && !m_bExtraLifeActive && m_oPlayer.nHealth < 5) 
    {
        // Prepare the tiles needed to show the pie in the oven.
        UINT8 tiles[8] = {113, 114, 115, 116, 117, 118, 119, 120};
        
        // Set the player to the middle lane.
        // this way the player isn't covering
        // the new spawned life, and is clear.
        m_oPlayer.nX = 80;

        // Kill all enemies in the scene. 
        KillAllEnemies();

        // Delay before completing kill all,
        // this will ensure we see the death
        // sprite for a moment. Just keep the
        // logic simple here.
        PerformantDelay(30);
        
        // Complete kill all request.
        CompleteKillAllEnemies();

        // Seeing as we want to pause the game here while this animation
        // plays we will just keep the animation simple and move the sprite
        // and then delay the game, and then move again. Once complete contiune
        // the game again.
        set_bkg_tiles(4, 2, 4, 2, tiles); set_sprite_tile(39, 107); move_sprite(39, 52, 38);
        PerformantDelay(15); set_sprite_tile(39, 111); PerformantDelay(15);
        set_sprite_tile(39, 107); PerformantDelay(15); set_sprite_tile(39, 111);
        PerformantDelay(15); set_sprite_tile(39, 107); PerformantDelay(50);
        
        // Set the extra life as ready for collection.
        m_bExtraLifeActive = TRUE;
        m_bLifeCollected = FALSE;
    }
    
    // Check if the extra life is currently active and not collected.
    if (m_bExtraLifeActive && !m_bLifeCollected) 
    {
        // Check if the player has collided with the extra life.
        if (m_oPlayer.nX == 52) 
        {
            // Change the background back to the default position.
            UINT8 tiles[8] = {39, 40, 41, 42, 58, 59, 60, 61};
            set_bkg_tiles(4, 2, 4, 2, tiles);
            set_sprite_tile(39, 111);
            move_sprite(39, 0, 0);
            m_bLifeCollected = TRUE;
            
            // Increase the player health
            m_oPlayer.nHealth++;
            SetHealthHearts(m_oPlayer.nHealth);
        }
    }

    // Reset for next extra life
    if (m_bLifeCollected) 
    {
        m_bExtraLifeActive = FALSE;
        m_bLifeCollected = FALSE;
    }
}

//--------------------------------------------------------------------------------------
// PauseGame: Main logic needed to pause and unpause the gameplay.
//--------------------------------------------------------------------------------------
void PauseGame(void)
{
    // Play the pausing sound (backwards start sound).
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86; PerformantDelay(3);
    NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86;

    // Start pause logic.
    m_bPaused = !m_bPaused;
    m_nBlinkTimer = 0;
    m_nBlinkState = 0;
    BGP_REG = 0xE4;

    // WHEN PAUSED
    if (m_bPaused)
    {
        // Paused the music.
        hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
        hUGE_mute_channel(HT_CH4, HT_CH_MUTE);

        // My sprite sheets are full, use sprite layer instead.
        // Set the "Paused.." text
        set_sprite_tile(0, 103); move_sprite(0, 54, 105); // P
        set_sprite_tile(1, 97); move_sprite(1, 64, 105); // A
        set_sprite_tile(2, 104); move_sprite(2, 74, 105); // U
        set_sprite_tile(3, 105); move_sprite(3, 84, 105); // S
        set_sprite_tile(4, 106); move_sprite(4, 94, 105); // E
        set_sprite_tile(5, 98); move_sprite(5, 104, 105); // D
        set_sprite_tile(39, 102); move_sprite(39, 114, 105); // ..
    }

    // WHEN UNPAUSED
    else
    {
        // Unpaused the music.
        hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
        hUGE_mute_channel(HT_CH4, HT_CH_PLAY);

        // Disable the paused text from the sprite layer.
        set_sprite_tile(0, 111); move_sprite(0, 0, 0); // P
        set_sprite_tile(1, 111); move_sprite(1, 0, 0); // A
        set_sprite_tile(2, 111); move_sprite(2, 0, 0); // U
        set_sprite_tile(3, 111); move_sprite(3, 0, 0); // S
        set_sprite_tile(4, 111); move_sprite(4, 0, 0); // E
        set_sprite_tile(5, 111); move_sprite(5, 0, 0); // D
        set_sprite_tile(39, 111); move_sprite(39, 0, 0); // ..
    }
}

//--------------------------------------------------------------------------------------
// PlayEnemyDeathSound: Play the sound associated with the enemies death.
//--------------------------------------------------------------------------------------
void PlayEnemyDeathSound(void)
{
    hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

    // Play enemy death sound.
    NR21_REG = 0x84; NR22_REG = 0x26; NR23_REG = 0x2D; NR24_REG = 0x81;
    NR41_REG = 0x05; NR41_REG = 0xA7; NR41_REG = 0xC0; NR41_REG = 0xC0;

    hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
}

//--------------------------------------------------------------------------------------
// PlayPlayerDamageSound: Play the sound associated with the player damage.
//--------------------------------------------------------------------------------------
void PlayPlayerDamageSound(void)
{
    hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

    // Play damage sounmd for player.
    NR10_REG = 0x0D; NR11_REG = 0xC2; NR12_REG = 0x54; NR13_REG = 0x63; NR14_REG = 0x82;

    hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
}

//--------------------------------------------------------------------------------------
// UpdateEnemies: Update all the enemies currently alive in the scene.
//--------------------------------------------------------------------------------------
void UpdateEnemies(BYTE bMode)
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 o;

    // Update all enemies in the scene.
    for (o = 0; o < MAX_ENEMIES; o++) 
    {
        // Ensure enemies are alive before updating.
        if (IsEnemyAlive(o)) 
        {
            // Update for whatever mode is currently active.
            if (bMode == 0) UpdateEnemyModeA(o, &m_oPlayer);
            else UpdateEnemyModeB(o, &m_oPlayer);
        }
    }
}

//--------------------------------------------------------------------------------------
// UpdateLoopGameModeA: Main game loop for the top of screen gamemode.
//--------------------------------------------------------------------------------------
void UpdateLoopGameModeA(void)
{
    // Create pie sprite at table position
    set_sprite_tile(6, m_anPieSpriteIDs[0]);
    move_sprite(6, 80, 26);

    // Update the health UI in the hud. 
    // Setting this mode to use hearts for health UI
    SetHealthHearts(m_oPlayer.nHealth);

    // Create the main game loop of the application
    while(1) 
    { 
        // Check for game over condition.
        if (m_oPlayer.nHealth == 0)
        {
            // On gameover only play the noise channel
            hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

            // Set in case not quite 0.
            SetHealthHearts(0);

            // Check if the previous highscore was beat
            if (m_oPlayer.nScore > m_nLoadedScore) 
            {
                // Save the new score data and reload.
                SaveGameData(0, m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
                LoadHighScoreData(0);
            }

            // Show the game over screen.
            DisplayGameOverScreen(0);
        }

        // Get the joypad inputs.
        m_nJoy = joypad();

        // Toggle pause screen.
        if ((m_nJoy & J_START) && !(m_nPrevJoy & J_START))
        {
            PauseGame();
        }

        // The main loop when not paused.
        if (!m_bPaused)
        {
            // Check for player input, and update player sprites.
            HandlePlayerInput(1, &m_oPlayer, m_nJoy);

            // Animate the pie sprite 
            // on the table.
            AnimatePie();

            // Tick the spawnerSystem
            TickSpawner();

            // Check if an Enemy should spawn in
            // the current spawner tick. If possible
            // spawn a new random enemy in a random lane
            if(ShouldSpawnThisTick()) 
                SpawnEnemyInLane(GetNextSpawn(), GetNextSpawnType());
            
            // Update all enemies in scene.
            UpdateEnemies(0);

            // Show the spray effect if an enemy is killed.
            ShowSprayEffect(&m_oPlayer, m_bShowSpray);
            
            // Check if an enemy sound effect is needed.
            // Play once per frame instead of every enemy.
            if (m_bPlayKillSoundEffect && !m_oPlayer.bTakenDamage)
            {
                // Play the Enemy death sound.
                PlayEnemyDeathSound();

                // Mark sound as played for next request.
                m_bPlayKillSoundEffect = FALSE;

                // Mark spary as used.
                m_bShowSpray = FALSE;
            }

            // Prepare score and health for displaying.
            m_nCurrentHudScore = m_oPlayer.nScore;

            // Update logic for extra life
            UpdateExtraLife();

            // Play the damage audio
            if (m_oPlayer.bTakenDamage)
            {
                // Make sure we keep the health capped
                // limit the possibility of overflow.
                m_oPlayer.nHealth = (m_oPlayer.nHealth < 1 || 
                    m_oPlayer.nHealth > 5) ? 0 : m_oPlayer.nHealth - 1;

                // Play the player damage sound.
                PlayPlayerDamageSound();

                // Mute the music while we show the damage
                // animation over the pie. We might add music
                // here later.
                hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

                // Ensure if the extra life is currently showing that is
                // hidden if the player has taken any damage.
                UINT8 tiles[8] = {39, 40, 41, 42, 58, 59, 60, 61};
                set_bkg_tiles(4, 2, 4, 2, tiles);
                set_sprite_tile(39, 111);
                move_sprite(39, 0, 0);
                m_bExtraLifeActive = FALSE;
                m_bLifeCollected = FALSE;

                // Kill all enemies in the scene.
                KillAllEnemies();

                // Set the enemy that damaged the player
                // over the table where the pie sprite is
                set_sprite_tile(5, m_bEnemyHurtPlayer-2);
                move_sprite(5, 88, 26);

                // Update the health UI in the hud.
                SetHealthHearts(m_oPlayer.nHealth);

                // Delay before completing kill all,
                // this will ensure we see the death
                // sprite for a moment. Just keep the
                // logic simple here.
                PerformantDelay(30);
                
                // Complete kill all request.
                CompleteKillAllEnemies();
                
                // Seeing as we want to pause the game here while this animation
                // plays we will just keep the animation simple and move the sprite
                // and then delay the game, and then move again. Once complete contiune
                // the game again.
                PerformantDelay(30); move_sprite(5, 86, 26); PerformantDelay(30);
                move_sprite(5, 88, 26); PerformantDelay(30); move_sprite(5, 86, 26);
                PerformantDelay(30); move_sprite(5, 88, 26); PerformantDelay(30);
                move_sprite(5, 86, 26); PerformantDelay(30); move_sprite(5, 88, 26);
                PerformantDelay(30);

                // Unmute music, damage has finished.
                hUGE_mute_channel(HT_CH3, HT_CH_PLAY);

                // Mark damage false again.
                m_oPlayer.bTakenDamage = FALSE;
            }

            // Set the score, only if changed.
            SetScoreOnHud();
        }

        // If paused, blink the screen.
        else 
        { 
            BlinkScreen();
        }
        
        // Set the previous used joypad position.
        m_nPrevJoy = m_nJoy;

        // Run a small delay to stop everything from
        // moving too quickly
        wait_vbl_done();
    }
}

//--------------------------------------------------------------------------------------
// UpdateLoopGameModeB: Main game loop for the middle of screen shooting gamemode.
//--------------------------------------------------------------------------------------
void UpdateLoopGameModeB(void)
{
    // Declare variables for storing 
    // health/score values.
    UINT16 nCurrentHealth;

    // Create the main game loop of the application
    while(1) 
    { 
        // Check for game over condition.
        if (m_oPlayer.nHealth == 0)
        {
            // On gameover only play the noise channel
            hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

            // Set in case not quite 0.
            SetHealth(0);

            // Check if the previous highscore was beat
            if (m_oPlayer.nScore > m_nLoadedScore) 
            {
                // Save the new score data and reload.
                SaveGameData(1, m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
                LoadHighScoreData(1);
            }

            // Show the game over screen.
            DisplayGameOverScreen(1);
        }

        // Get the joypad inputs.
        m_nJoy = joypad();

        // Toggle pause screen.
        if ((m_nJoy & J_START) && !(m_nPrevJoy & J_START))
        {
            PauseGame();
        }

        // The main loop when not paused.
        if (!m_bPaused)
        {
            // Check for player input, and update player sprites.
            HandlePlayerInput(0, &m_oPlayer, m_nJoy);

            // If a spray bullet is active, update
            // its state and position.
            if (m_oPlayer.bSprayActive)
            {
                UpdateSprayBullet(&m_oPlayer);
            }

            // Tick the spawn timer each frame. 
            TickSpawnTimer();
            
            // As long as spawnTimer is not 0
            if (m_nSpawnTimer <= 0) 
            {
                // Spawn next enemy, if possible.
                SpawnNext();

                // Reset the spawn delay.
                m_nSpawnTimer = m_nSpawnDelay;
            }

            // Update all enemies in scene.
            UpdateEnemies(1);

            // Check/Increase game difficulty
            IncreaseDifficulty(&m_nDamgeToPlayer);

            // Show the spray effect if an enemy is killed.
            if (!m_oPlayer.bSprayActive) 
            {
                set_sprite_tile(5, 111);
            }
            
            // Check if an enemy sound effect is needed.
            // Play once per frame instead of every enemy.
            if (m_bPlayKillSoundEffect && !m_oPlayer.bTakenDamage)
            {
                // Play the Enemy death sound.
                PlayEnemyDeathSound();

                // Mark sound as played for next request.
                m_bPlayKillSoundEffect = FALSE;
            }

            // Play the damage audio
            if (m_oPlayer.bTakenDamage)
            {
                // Make sure we keep the health capped
                // limit the possibility of overflow.
                m_oPlayer.nHealth = (m_oPlayer.nHealth < m_nDamgeToPlayer || 
                    m_oPlayer.nHealth > 999) ? 0 : m_oPlayer.nHealth - m_nDamgeToPlayer;

                // Play the player damage sound.
                PlayPlayerDamageSound();

                // Mark damage false again.
                m_oPlayer.bTakenDamage = FALSE;

                // Reset damage counter,
                // disable any health recovery
                m_nDamgeTimer = 400;
                m_bRecoverHealth = FALSE;
            }

            // Only tick the damage timer while we're not taking damage.
            if (!m_bRecoverHealth && m_nDamgeTimer > 0) 
            {
                m_nDamgeTimer--;
            }

            // Once damage timer is 0 and not already recovering.
            if (m_nDamgeTimer == 0 && !m_bRecoverHealth) 
            {
                // Enable the health recovery mode.
                m_bRecoverHealth = TRUE;

                // Increase the health of the player.
                m_oPlayer.nHealth += 1;

                // Ensure we dont take the health too high.
                if (m_oPlayer.nHealth > 999) 
                {
                    m_oPlayer.nHealth = 998;
                }

                // Recovery done, allow timer to 
                // run again next time you take damage
                m_bRecoverHealth = FALSE;
            }

            // Prepare score and health for displaying.
            nCurrentHealth = m_oPlayer.nHealth / 10;
            m_nCurrentHudScore = m_oPlayer.nScore;

            // Only update the health if it changes.
            if (nCurrentHealth != m_nPrevHealth)
            {
                // Update the health UI in the hud.
                SetHealth(nCurrentHealth);

                // Update the previous health for next frames check.
                m_nPrevHealth = nCurrentHealth;
            }

            // Set the score, only if changed.
            SetScoreOnHud();
        }

        // If paused, blink the screen.
        else 
        { 
            BlinkScreen();
        }
        
        // Set the previous used joypad position.
        m_nPrevJoy = m_nJoy;

        // Run a small delay to stop everything from
        // moving too quickly
        wait_vbl_done();
    }
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
