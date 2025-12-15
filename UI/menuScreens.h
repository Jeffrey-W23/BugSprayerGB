//--------------------------------------------------------------------------------------
// Purpose: Header class for the MenuScreens object. Used for showing various UI and 
// screens throughout the game.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef MENUSCREENS_H
#define MENUSCREENS_H

// includes, using, etc
#include <gb/gb.h>
#include "../Data-Systems/save.h"
#include "hUGEDriver.h"

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// Const int for setting the empty slot for sprite sheet.
#define SPRITE_SHEET_EMPTY_SLOT 81

// New const huge song variable for the main song file of the game.
extern const hUGESong_t m_sSong1;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// DisplaySplashScreen: Set data and display everything needed for the Splash Screen.
//--------------------------------------------------------------------------------------
void DisplaySplashScreen(void);

//--------------------------------------------------------------------------------------
// DisplayStartScreen: Set data and display everything needed for the Start Screen.
//--------------------------------------------------------------------------------------
void DisplayStartScreen(void);

//--------------------------------------------------------------------------------------
// SetupMainMenuCursor: Prepare a new cursor to use for the main menu.
//--------------------------------------------------------------------------------------
void SetupGameSelectCursor(void);

//--------------------------------------------------------------------------------------
// SetupModeSelectCursor: Prepare a new cursor to use for the difficulty menu.
//--------------------------------------------------------------------------------------
void SetupModeSelectCursor(UINT16 nScore);

//--------------------------------------------------------------------------------------
// ShowGameSelectMenu: Show the Menu UI for selecting Gamemodes A or B.
//
// Params:
//      bMode: Pointer to the current gameMode, used for setting gamemode.
//      bDiff: Pointer to the current difficulty, used for setting the difficulty.
//--------------------------------------------------------------------------------------
void ShowGameSelectMenu(BYTE* bMode, BYTE* bDiff);

//--------------------------------------------------------------------------------------
// ShowDifficultySelectMenu: Show the Menu UI for selecting a difficulty for a gamemode.
//
// Params:
//      bMode: The current gamemode that is selected.
//      nJoy: The Joypad for checking input.
//      nPrevJoy: The last Joypad input.
//--------------------------------------------------------------------------------------
void ShowDifficultySelectMenu(BYTE bMode, UINT8 nJoy, UINT8 nPrevJoy);

//--------------------------------------------------------------------------------------
// ShowLoadingScreen: Show the loading screen during gamemode initialization.
//--------------------------------------------------------------------------------------
void ShowLoadingScreen(void);

//--------------------------------------------------------------------------------------
// ShowScoreGrade: Determine and show the grade based on the shots taken and kills.
//
// Params:
//      cCharacterOut: Pointer to char, used to set the string as we cant return char*.
//      nScore: The score value from player or highscore.
//      nShotsTaken: Shots taken from player or highscore.
//--------------------------------------------------------------------------------------
void GetScoreGrade(char* cCharacterOut, UINT16 nScore, UINT16 nShotsTaken);

//--------------------------------------------------------------------------------------
// DisplayGameOverScreen: Set data and display everything needed for the GameOver Screen.
//
// Params:
//      bMode: The gamemode triggering the gameover.
//      bDiff: The difficulty of the gamemode.
//      nScore: The score value from player or highscore.
//      nShotsTaken: Shots taken from player or highscore.
//--------------------------------------------------------------------------------------
void DisplayGameOverScreen(BYTE bMode, BYTE bDiff, UINT16 nScore, UINT16 nShotsTaken);

// Close the Header.
#endif