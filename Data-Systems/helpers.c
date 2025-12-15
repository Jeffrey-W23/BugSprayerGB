//--------------------------------------------------------------------------------------
// Purpose: Helpers object. Contains some of the most often used functions. 
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include <stdio.h>
#include <stdlib.h>
#include <gb/gb.h>
#include <rand.h>
#include <string.h>
#include "../Data-Systems/helpers.h"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 8 used for keeping track of the current animated frame of a menu cursor.
static UINT8 m_nCursorAniFrame = 0;

// New unsigned int 8 used for ticking the animation of a menu cursor.
static UINT8 m_nCursorAniCounter = 0;
//--------------------------------------------------------------------------------------

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New unsigned int 8 used for the current tick in blinking the screen.
UINT8 m_nBlinkTimer = 0;

// New unsigned int 8 for the current state of blinking for blicking the screen.
UINT8 m_nBlinkState = 0;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitMenuCursor: Prepare sprites to be used for a new cursor for a menu.
//
// Params:
//      ptrCursor: Pointer to a menu cursor object.
//--------------------------------------------------------------------------------------
void InitMenuCursor(MenuCursor* ptrCursor) 
{
    set_sprite_tile(ptrCursor->nSpriteID, ptrCursor->nTileID);
    set_sprite_tile(ptrCursor->nSpriteID+1, SPRITE_SHEET_EMPTY_SLOT);
    move_sprite(ptrCursor->nSpriteID+1, 0, 0);
    move_sprite(ptrCursor->nSpriteID, ptrCursor->nStartX + 
        (ptrCursor->nIndex * ptrCursor->nStepX), ptrCursor->nStartY + 
        (ptrCursor->nIndex * ptrCursor->nStepY));
}

//--------------------------------------------------------------------------------------
// UpdateMenuCursor: Update the position and state of a cursor object of an active menu.
//
// Params:
//      ptrCursor: Pointer to a menu cursor object.
//      nJoy: The Joypad for checking input.
//      bShowTwo: Bool value for if two sprites are needed for cursor.
//--------------------------------------------------------------------------------------
void UpdateMenuCursor(MenuCursor* ptrCursor, UINT8 nJoy, BOOLEAN bShowTwo) 
{
    // Variables decalred for later use.
    UINT8 nPrevMove = 0;
    UINT8 nNextMove = 0;
    UINT8 nOffset;

    // Ensure there is at least one button before moving.
    if (ptrCursor->nBtnCount != 0)
    {
        // Move cursor UP
        if ((nJoy & J_UP)   && !(ptrCursor->nPrevJoy & J_UP))   nPrevMove = 1;
        if ((nJoy & J_LEFT) && !(ptrCursor->nPrevJoy & J_LEFT)) nPrevMove = 1;

        // Move cursor DOWN
        if ((nJoy & J_DOWN)  && !(ptrCursor->nPrevJoy & J_DOWN))  nNextMove = 1;
        if ((nJoy & J_RIGHT) && !(ptrCursor->nPrevJoy & J_RIGHT)) nNextMove = 1;
    }

    // Update the index position of the cursor, which is the logical posiiton. 
    if (nPrevMove) 
    {
        if (ptrCursor->nIndex > 0) ptrCursor->nIndex--;
        else ptrCursor->nIndex = ptrCursor->nBtnCount - 1;
    }

    if (nNextMove)
    {
        if (ptrCursor->nIndex + 1 < ptrCursor->nBtnCount) ptrCursor->nIndex++;
        else ptrCursor->nIndex = 0;
    }

    // Increase the aniCounter
    m_nCursorAniCounter++;

    // Wait certain amount of frames 
    if (m_nCursorAniCounter >= 20) 
    {   
        // Reset the counter
        m_nCursorAniCounter = 0;

        // Advance the cursor animation frame.
        m_nCursorAniFrame++;
        
        // Reset the cursor animation frame back to 0
        if (m_nCursorAniFrame >= 4) m_nCursorAniFrame = 0;
    }

    // Determine offset of the cursors
    if(m_nCursorAniFrame == 0) nOffset = 0;
    else if(m_nCursorAniFrame == 1) nOffset = 1;
    else if(m_nCursorAniFrame == 2) nOffset = 2;
    else nOffset = 1;

    // Move the left facing cursor sprite, by default if only one sprite needed we use left.
    move_sprite(ptrCursor->nSpriteID,  ptrCursor->nStartX + (ptrCursor->nIndex * ptrCursor->nStepX)
     + nOffset, ptrCursor->nStartY + (ptrCursor->nIndex * ptrCursor->nStepY));
    
    // If two sprites are needed.
    if (bShowTwo)
    {
        // Update the sprite on the right side of buttons.
        set_sprite_tile(ptrCursor->nSpriteID+1, ptrCursor->nTileID+1);
        move_sprite(ptrCursor->nSpriteID+1,  ptrCursor->nStartX + (ptrCursor->nIndex * ptrCursor->nStepX)
         + nOffset + ptrCursor->nDistance, ptrCursor->nStartY + (ptrCursor->nIndex * ptrCursor->nStepY));
    }

    // Update the previous joypad for cursor.
    ptrCursor->nPrevJoy = nJoy;
}

//--------------------------------------------------------------------------------------
// CharToTile: Getter function for getting the tile number from a passed in charater.
//
// Params:
//      cCharacter: The char wanting to be converted to tile.
//
// Returns:
//      UINT8: The tile number for the passed in character.
//--------------------------------------------------------------------------------------
UINT8 CharToTile(char cCharacter) 
{
    // Space: using a blank tile.
    if (cCharacter == ' ') return 168;

    // Convert letters and return.
    if (cCharacter >= 'a' && cCharacter <= 'z') cCharacter = cCharacter - 'a' + 'A';
    if (cCharacter >= 'A' && cCharacter <= 'Z') return 128 + (cCharacter - 'A');

    // Convert numbers and return.
    if (cCharacter >= '0' && cCharacter <= '9') return 128 + 26 + (cCharacter - '0');

    // Convert symbols and return. 
    if (cCharacter == ':') return 128 + 26 + 10;
    if (cCharacter == '-') return 128 + 26 + 11;
    if (cCharacter == '+') return 128 + 26 + 12;
    if (cCharacter == '.') return 128 + 26 + 13;

    // Return 0 if any issues.
    return 168;
}

//--------------------------------------------------------------------------------------
// PrintIntToWindow: Print int to the screen using the loaded letters sprite sheet.
//
// Params:
//      nX: Starting position on the x axis.
//      nY: Starting position on the y axis.
//      value: characters to show on screen.
//--------------------------------------------------------------------------------------
void PrintIntToWindow(UINT8 nX, UINT8 nY, INT16 nValue) 
{
    // Break up int into digits, allow for text to show
    // 4 digits no mater the number. If a player manages
    // to get over 10000 then good job to them!
    
    char caText[5];
    
    if (nValue < 0)      nValue = 0;
    else if (nValue > 9999) nValue = 9999;

    caText[0] = '0' + (nValue / 1000);
    nValue %= 1000;

    caText[1] = '0' + (nValue / 100);
    nValue %= 100;

    caText[2] = '0' + (nValue / 10);
    nValue %= 10;

    caText[3] = '0' + nValue;
    caText[4] = '\0';

    // Pass the conveertion to the window layer.
    PrintTextToLayer(1, nX, nY, caText);
}

//--------------------------------------------------------------------------------------
// PrintTextToLayer: Print text to the screen using the loaded letters sprite sheet.
//
// Params:
//      bLayer: The layer that text will be displayed on.
//      nX: Starting position on the x axis.
//      nY: Starting position on the y axis.
//      ptrText: pointer to the characters to show on screen.
//--------------------------------------------------------------------------------------
void PrintTextToLayer(BYTE bLayer, UINT8 nX, UINT8 nY, const char *ptrText) 
{
    // variables for later use.
    UINT8 nlength, i;
    UINT8 naTiles[20];

    // Get the length of the inputed text.
    nlength = (UINT8)strlen(ptrText);
    
    // Ensure we dont go over the length of the screen.
    if (nlength > 20) nlength = 20;

    // Loop through all the characters and get the tile numbers.
    for (i = 0; i < nlength; i++) naTiles[i] = CharToTile(ptrText[i]);

    // BACKGROUND LAYER
    if (bLayer == 0)
    {    
        // Set the tiles on the window.
        set_bkg_tiles(nX, nY, nlength, 1, naTiles);
    }
    
    // WINDOW LAYER
    else
    {    
        // Set the tiles on the window.
        set_win_tiles(nX, nY, nlength, 1, naTiles);
    }
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
    
    // unsigned int 8 for keeping track 
    // of background fading stages. 
    UINT8 nFadeIndex;

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
    for(nFadeIndex = 0; nFadeIndex < nLoopAmount; nFadeIndex++)
    {
        // Check which layer to fade.
        if (bLayer == 0)
        {
            // Switch statement for setting background color for each
            // iteration through the for loop
            switch(nFadeIndex)
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
            switch(nFadeIndex)
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
