//--------------------------------------------------------------------------------------
// Purpose: Header class for Helpers object. Contains some of the most often used functions. 
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// Define the header.
#ifndef HELPER_H
#define HELPER_H

// includes, using, etc
#include <gb/gb.h>

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// Const int for setting the empty slot for sprite sheet.
#define SPRITE_SHEET_EMPTY_SLOT 81

// New static unsigned int 8 used for the current tick in blinking the screen.
extern UINT8 m_nBlinkTimer;

// New static unsigned int 8 for the current state of blinking for blicking the screen.
extern UINT8 m_nBlinkState;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// MenuCursor struct for setting the main information needed for building a Menu Cursor.
//--------------------------------------------------------------------------------------
typedef struct MenuCursor
{
    UINT8 nSpriteID;
    UINT8 nTileID;
    UINT8 nIsVertical;
    UINT8 nBtnCount;
    UINT8 nStartX;
    UINT8 nStartY;
    UINT8 nStepX;
    UINT8 nStepY;
    UINT8 nIndex;
    UINT8 nPrevJoy;
    UINT8 nDistance;
} MenuCursor;

//--------------------------------------------------------------------------------------
// InitMenuCursor: Prepare sprites to be used for a new cursor for a menu.
//
// Params:
//      ptrCursor: Pointer to a menu cursor object.
//--------------------------------------------------------------------------------------
void InitMenuCursor(MenuCursor* ptrCursor);

//--------------------------------------------------------------------------------------
// UpdateMenuCursor: Update the position and state of a cursor object of an active menu.
//
// Params:
//      ptrCursor: Pointer to a menu cursor object.
//      nJoy: The Joypad for checking input.
//      bShowTwo: Bool value for if two sprites are needed for cursor.
//--------------------------------------------------------------------------------------
void UpdateMenuCursor(MenuCursor* ptrCursor, UINT8 nJoy, BOOLEAN bShowTwo);

//--------------------------------------------------------------------------------------
// CharToTile: Getter function for getting the tile number from a passed in charater.
//
// Params:
//      cCharacter: The char wanting to be converted to tile.
//
// Returns:
//      UINT8: The tile number for the passed in character.
//--------------------------------------------------------------------------------------
UINT8 CharToTile(char cCharacter);

//--------------------------------------------------------------------------------------
// PrintIntToWindow: Print int to the screen using the loaded letters sprite sheet.
//
// Params:
//      nX: Starting position on the x axis.
//      nY: Starting position on the y axis.
//      value: characters to show on screen.
//--------------------------------------------------------------------------------------
void PrintIntToWindow(UINT8 nX, UINT8 nY, INT16 nValue);

//--------------------------------------------------------------------------------------
// PrintTextToLayer: Print text to the screen using the loaded letters sprite sheet.
//
// Params:
//      bLayer: The layer that text will be displayed on.
//      nX: Starting position on the x axis.
//      nY: Starting position on the y axis.
//      ptrText: pointer to the characters to show on screen.
//--------------------------------------------------------------------------------------
void PrintTextToLayer(BYTE bLayer, UINT8 nX, UINT8 nY, const char *ptrText);

//--------------------------------------------------------------------------------------
// PerformantDelay: A function for delaying the system based on screen draws
// 
// Params:
//      nLoops: Number of times to wait for the screen to redraw.
//--------------------------------------------------------------------------------------
void PerformantDelay(UINT8 nLoops);

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
void FadeDrawLayer(BYTE bLayer, BYTE bMode, UINT8 nValue1, UINT8 nValue2, UINT8 nValue3, UINT8 nValue4, UINT8 nDelay);

//--------------------------------------------------------------------------------------
// BlinkScreen: Basic timer and switchstatement to blink screen.
//--------------------------------------------------------------------------------------
void BlinkScreen(void);

// Close the Header.
#endif