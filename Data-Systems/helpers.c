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

// PUBLIC VARIABLES //
//--------------------------------------------------------------------------------------
// New static unsigned int 8 used for the current tick in blinking the screen.
UINT8 m_nBlinkTimer = 0;

// New static unsigned int 8 for the current state of blinking for blicking the screen.
UINT8 m_nBlinkState = 0;
//--------------------------------------------------------------------------------------












UINT8 nCursorAniFrame = 0;
UINT8 nCursorAniCounter = 0;
    


// Call once when opening a menu
void InitMenuCursor(MenuCursor* c) 
{
    set_sprite_tile(c->nSpriteID, c->nTileID);
    set_sprite_tile(c->nSpriteID+1, SPRITE_SHEET_EMPTY_SLOT);
    move_sprite(c->nSpriteID, c->nStartX + (c->nIndex * c->nStepX), c->nStartY + (c->nIndex * c->nStepY));
}

// Call every frame while menu is active
void UpdateMenuCursor(MenuCursor* c, UINT8 joy, BOOLEAN bShowTwo) 
{

    UINT8 movedPrev;
    UINT8 movedNext;

    

    UINT8 nOffset;

    movedPrev = 0;
    movedNext = 0;

    if (c->nBtnCount != 0)
    {
        // Any of these = previous option
        if ((joy & J_UP)   && !(c->nPrevJoy & J_UP))   movedPrev = 1;
        if ((joy & J_LEFT) && !(c->nPrevJoy & J_LEFT)) movedPrev = 1;

        // Any of these = next option
        if ((joy & J_DOWN)  && !(c->nPrevJoy & J_DOWN))  movedNext = 1;
        if ((joy & J_RIGHT) && !(c->nPrevJoy & J_RIGHT)) movedNext = 1;
    }

    if (movedPrev) {
        if (c->nIndex > 0) {
            c->nIndex--;
        } else {
            c->nIndex = c->nBtnCount - 1;  // wrap if you want
        }
    }

    if (movedNext) {
        if (c->nIndex + 1 < c->nBtnCount) {
            c->nIndex++;
        } else {
            c->nIndex = 0;                 // wrap if you want
        }
    }

    move_sprite(
        c->nSpriteID,
        c->nStartX + (c->nIndex * c->nStepX),
        c->nStartY + (c->nIndex * c->nStepY)
    );





        // Increase the aniCounter
        nCursorAniCounter++;

        // Wait certain amount of frames 
        if (nCursorAniCounter >= 20) 
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
        move_sprite(c->nSpriteID,  c->nStartX + (c->nIndex * c->nStepX) + nOffset, c->nStartY + (c->nIndex * c->nStepY));
        
        if (bShowTwo)
        {
            set_sprite_tile(c->nSpriteID+1, c->nTileID+1);
            move_sprite(c->nSpriteID+1,  c->nStartX + (c->nIndex * c->nStepX) + nOffset + c->nDistance, c->nStartY + (c->nIndex * c->nStepY));
        }
        else
        {
            set_sprite_tile(c->nSpriteID+1, SPRITE_SHEET_EMPTY_SLOT);
            move_sprite(c->nSpriteID+1, 0,0);
        }



    c->nPrevJoy = joy;
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
    if (cCharacter == ' ') return 169;

    // Convert letters and return.
    if (cCharacter >= 'a' && cCharacter <= 'z') cCharacter = cCharacter - 'a' + 'A';
    if (cCharacter >= 'A' && cCharacter <= 'Z') return 128 + (cCharacter - 'A');

    // Convert numbers and return.
    if (cCharacter >= '0' && cCharacter <= '9') return 128 + 26 + (cCharacter - '0');

    // Return 0 if any issues.
    return 0;
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
    // varaibles for converting.
    char caText[5] = "0000";
    UINT8 nPos = 3;
    
    // Extract thousands digit
    if (nValue >= 1000) {
        caText[nPos--] = '0' + (nValue / 1000);
        nValue %= 1000;
    }
    
    // Extract hundreds digit  
    if (nValue >= 100) {
        caText[nPos--] = '0' + (nValue / 100);
        nValue %= 100;
    }
    
    // Extract tens digit
    if (nValue >= 10) {
        caText[nPos--] = '0' + (nValue / 10);
        nValue %= 10;
    }
    
    // Extract units digit
    caText[nPos] = '0' + nValue;
    
    // Pass the conveertion to the window layer.
    PrintTextToWindow(nX, nY, caText);
}

//--------------------------------------------------------------------------------------
// PrintTextToWindow: Print text to the screen using the loaded letters sprite sheet.
//
// Params:
//      nX: Starting position on the x axis.
//      nY: Starting position on the y axis.
//      ptrText: pointer to the characters to show on screen.
//--------------------------------------------------------------------------------------
void PrintTextToWindow(UINT8 nX, UINT8 nY, const char *ptrText) 
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

    // Set the tiles on the window.
    set_win_tiles(nX, nY, nlength, 1, naTiles);
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
