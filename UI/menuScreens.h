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














void SetupGameSelectCursor(void);

void SetupModeSelectCursor(UINT16 nScore);

void ShowGameSelectMenu(BYTE* bMode, BYTE* bDiff, HighScoreData* oHighScoreData);

void ShowGameModeSelectionScreen(BYTE bMode, UINT8 nJoy, UINT8 nPrevJoy, HighScoreData* ptrHighScoreData, BYTE* bDiff);













//--------------------------------------------------------------------------------------
// ShowScoreGrade: Determine and show the grade based on the shots taken and kills.
//
// Params:
//      nScore: The score value from player or highscore.
//      nShotsTaken: Shots taken from player or highscore.
//--------------------------------------------------------------------------------------
void ShowScoreGrade(UINT16 nScore, UINT16 nShotsTaken);

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
void DisplayGameOverScreen(BOOLEAN bMode, UINT16 nScore, UINT16 nShotsTaken, UINT16 nLoadedScore, UINT16 nLoadedShotsTaken);

// Close the Header.
#endif