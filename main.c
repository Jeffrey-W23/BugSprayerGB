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
#include "enemies.h"
#include "hud.h"
#include "player.h"
#include "save.h"

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

// includes for the sprite layer
#include "Sprite-Sheets/Sprites.c"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// New Player object for storing and setting player information.
static Player m_oPlayer;

// New unsighed int 8 for getting and storing the joypad positions.
static UINT8 m_nJoy; UINT8 m_nPrevJoy;

// New static unsighed int 16s for storing and setting the previous score/health values.
static UINT16 m_nPrevHealth = 9999; static UINT16 m_nPrevScore = 9999;

// New unsigned int 8 for keeping track of background fading stages. 
static UINT8 m_nFadeIndex;

// New const huge song variable for the main song file of the game.
extern const hUGESong_t song1;

// New unsigned int 16 for the loaded saved score, representing the highscore.
UINT16 m_nLoadedScore = 0;

// New unsigned int 16 for the loaded saved shotsTaken, used to determine score grade.
UINT16 m_nLoadedShotsTaken = 0;

// New signed int 8 for damage an enemy does to the player on hit.
static UINT8 m_nDamgeToPlayer = 25;

// New const huge song variable for the main song file of the game.
extern const hUGESong_t song1;
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
// DisplaySplashScreen: Set data and display everything needed for the Start Screen.
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
        hUGE_init(&song1);
        add_VBL(hUGE_dosound);
    }

    // Fade in the start screen from previous background
    FadeDrawLayer(0, 0, 0xFB, 0xBB, 0xE4, 0x00, 15);

    // Pause
    PerformantDelay(25);

    // Set sprite data based on spritesheet
    SPRITES_8x8; 
    set_sprite_data(0, 95, m_caSprites);

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
    // First Note
    NR10_REG = 0x78;
    NR11_REG = 0x82;
    NR12_REG = 0x44;
    NR13_REG = 0x9D;
    NR14_REG = 0x86;
    
    // Pause
    PerformantDelay(5);
    
    // Second Note
    NR10_REG = 0x78;
    NR11_REG = 0x82;
    NR12_REG = 0x44;
    NR13_REG = 0x54;
    NR14_REG = 0x86;

    // Pause
    PerformantDelay(3);
    
    // Third Note
    NR10_REG = 0x78;
    NR11_REG = 0x82;
    NR12_REG = 0x44;
    NR13_REG = 0xD6;
    NR14_REG = 0x86;
    
    // Small delay to allow sound to play
    PerformantDelay(10);

    // Fade out StartScreen.
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
//--------------------------------------------------------------------------------------
void DisplayGameOverScreen(void)
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
    printf("     GAME  OVER     \n"); printf(" \n"); printf(" \n");
    
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
        
    // Grade title with spacing.
    //printf(" \n"); printf("      GRADE:");
        
    // Show the current score accuracy grade.
    //ShowScoreGrade(m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);

    // Highscore title and spacing.
    printf(" \n"); printf(" \n"); printf(" \n");
    printf("    HIGH  SCORE: ");printf(" \n");printf(" \n");

    // Show the highscore with 0 to ensure we show all 4 digits.
    printf("        %u%u%u%u  ", m_nLoadedScore / 1000, 
        (m_nLoadedScore / 100) % 10, (m_nLoadedScore / 10) % 10, 
        m_nLoadedScore % 10);
    
    // Show the highscore accuracy grade.
    //ShowScoreGrade(m_nLoadedScore, m_nLoadedShotsTaken);
    
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
// LoadHighScoreData: Load highscore data from previous game sessions.
//--------------------------------------------------------------------------------------
void LoadHighScoreData(void) 
{
    // Delcare temp vars for setting.
    UINT16 nLoadedScore = 0;
    UINT16 nLoadedShotsTaken = 0;

    // Load the game data from memory
    LoadGameData(&nLoadedScore, &nLoadedShotsTaken);

    // Set the load values in the main.c
    m_nLoadedScore = nLoadedScore;
    m_nLoadedShotsTaken = nLoadedShotsTaken;
}

//--------------------------------------------------------------------------------------
// Initialize: Prepare the application for launch.
//--------------------------------------------------------------------------------------
void Initialize(void)
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;

    // Sound registers, must be in this order.
    NR52_REG = 0x80; // Turn on the sound.
    NR50_REG = 0x77; // Set the volume of the left and right channel
    NR51_REG = 0xFF; // Set usage to both channels

    // Load highscore data
    LoadHighScoreData();

    // Display the splash screen background
    DisplaySplashScreen();

    // Display the start screen background
    DisplayStartScreen();

    // My sprite sheets are full, use sprite layer instead.
    // Set the "Loading.." text for the transition 
    // between startScreen and game.
    set_sprite_tile(6, 87); move_sprite(6, 54, 105); // L
    set_sprite_tile(7, 88); move_sprite(7, 64, 105); // O
    set_sprite_tile(8, 89); move_sprite(8, 74, 105); // A
    set_sprite_tile(9, 90); move_sprite(9, 84, 105); // D
    set_sprite_tile(10, 91); move_sprite(10, 94, 105); // I
    set_sprite_tile(11, 92); move_sprite(11, 104, 105); // N
    set_sprite_tile(12, 93); move_sprite(12, 114, 105); // G
    set_sprite_tile(13, 94); move_sprite(13, 124, 105); // ..

    // Hide the background while things load.
    HIDE_BKG;

    // Used for better random gen
    VBK_REG = 0;

    // Turn on GameBoy display
    DISPLAY_ON;

    // Initiate random system
    initrand(DIV_REG | (LY_REG << 8));

    // Initiate the player and hud objects
    InitPlayer(&m_oPlayer);
    UpdatePlayer(&m_oPlayer);
    InitHud();

    // Prepare enemies manager.
    for(i = 0; i < MAX_ENEMIES; i++) 
    {
        InitEnemy(i);
    }

    // Prepare spawn quque for enemies.
    InitEnemiesSpawnQueue();

    // Ensure previous joypad value is at 0;
    m_nPrevJoy = 0;

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
// main: base function of the program where all code will be run.
//--------------------------------------------------------------------------------------
void main(void) 
{    
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 o;

    // Declare variables for storing 
    // health/score values.
    UINT16 nCurrentHealth;
    UINT16 nCurrentScore;

    // Delcare variables for pausing.
    BOOLEAN bPaused = FALSE;
    UINT8 nBlinkTimer = 0;
    UINT8 nBlinkState = 0;  

    // Initialize layers, 
    // player, spirtes, bg, etc
    Initialize();

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
                SaveGameData(m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
                LoadHighScoreData();
            }

            // Show the game over screen.
            DisplayGameOverScreen();
        }

        // Get the joypad inputs.
        m_nJoy = joypad();

        // Toggle pause screen.
        if ((m_nJoy & J_START) && !(m_nPrevJoy & J_START))
        {
            // Play the pausing sound, backwards start sound.
    
            // Note #1
            NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86;
            PerformantDelay(3);

            // Note #2
            NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86;
            PerformantDelay(3);

            // Note #3
            NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86;

            // Start pause logic.
            bPaused = !bPaused;
            nBlinkTimer = 0;
            nBlinkState = 0;
            BGP_REG = 0xE4;

            // Mute all music while paused.
            if (bPaused)
            {
                hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
                hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
            }
            else
            {
                hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
                hUGE_mute_channel(HT_CH4, HT_CH_PLAY);
            }
        }

        // The main loop when not paused.
        if (!bPaused)
        {
            // Check for player input, and update player sprites.
            HandlePlayerInput(&m_oPlayer, m_nJoy);

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

            // Loop through each enemy avaliable.
            for (o = 0; o < MAX_ENEMIES; o++) 
            {
                // Only update enemies if alive
                if (IsEnemyAlive(o)) 
                {
                    // Update enemy, moving position, checking for input, etc..
                    UpdateEnemy(o, &m_oPlayer);
                }
            }

            // Check/Increase game difficulty
            IncreaseDifficulty(m_nDamgeToPlayer);

            // Show the spray effect if an enemy is killed.
            ShowSprayEffect(m_bShowSpray);
            
            // Check if an enemy sound effect is needed.
            // Play once per frame instead of every enemy.
            if (m_bPlayKillSoundEffect && !m_oPlayer.bTakenDamage)
            {
                hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

                // Play enemy death sound.
                NR21_REG = 0x84;
                NR22_REG = 0x26;
                NR23_REG = 0x2D;
                NR24_REG = 0x81;

                NR41_REG = 0x05;
                NR41_REG = 0xA7;
                NR41_REG = 0xC0;
                NR41_REG = 0xC0;

                hUGE_mute_channel(HT_CH3, HT_CH_PLAY);

                // Mark sound as played for next request.
                m_bPlayKillSoundEffect = FALSE;

                // Mark spary as used.
                m_bShowSpray = FALSE;
            }

            // Prepare score and health for displaying.
            nCurrentHealth = m_oPlayer.nHealth / 10;
            nCurrentScore = m_oPlayer.nScore;

            // Play the damage audio
            if (m_oPlayer.bTakenDamage)
            {
                // Make sure we keep the health capped
                // limit the possibility of overflow.
                m_oPlayer.nHealth = (m_oPlayer.nHealth < m_nDamgeToPlayer || 
                    m_oPlayer.nHealth > 999) ? 0 : m_oPlayer.nHealth - m_nDamgeToPlayer;

                hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

                // Play damage sounmd for player.
                NR10_REG = 0x0D;
                NR11_REG = 0xC2;
                NR12_REG = 0x54;
                NR13_REG = 0x63;
                NR14_REG = 0x82;

                hUGE_mute_channel(HT_CH3, HT_CH_PLAY);

                // Mark damage false again.
                m_oPlayer.bTakenDamage = FALSE;
            }

            // Only update the health if it changes.
            if (nCurrentHealth != m_nPrevHealth)
            {
                // Update the health UI in the hud.
                SetHealth(nCurrentHealth);

                // Update the previous health for next frames check.
                m_nPrevHealth = nCurrentHealth;
            }

            // Only update the score if it changes.
            if (nCurrentScore != m_nPrevScore) 
            {
                // Update the score UI in the hud.
                SetScore(nCurrentScore);

                // Update the previous score for next frames check.
                m_nPrevScore = nCurrentScore;
            }
        }

        // If paused, blink the screen.
        else 
        { 
            // Basic timer and switchstatement to blink screen.
            nBlinkTimer++;
            
            if (nBlinkTimer >= 20) 
            {
                nBlinkTimer = 0;
                nBlinkState = (nBlinkState + 1) % 3;

                switch(nBlinkState) 
                {
                    case 0: BGP_REG = 0xE4; break;  // Normal
                    case 1: BGP_REG = 0xB0; break;  // Dims
                    case 2: BGP_REG = 0xE4; break;  // Normal
                }
            }
        }
        
        // Set the previous used joypad position.
        m_nPrevJoy = m_nJoy;

        // Run a small delay to stop everything from
        // moving too quickly
        wait_vbl_done();
    }
}
