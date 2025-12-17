//--------------------------------------------------------------------------------------
// Purpose: Gamemodes object. Used as the main game manager, controlling and updated a 
// selected gamemodes main game logic.
//
// Author: Thomas Wiltshire
//--------------------------------------------------------------------------------------

// includes, using, etc
#include <stdio.h>
#include <stdlib.h>
#include <gb/gb.h>
#include <rand.h>
#include <string.h>
#include "../Gamemodes/gamemodes.h"
#include "../Entities/enemies.h"
#include "../UI/hud.h"
#include "../Entities/player.h"
#include "../Data-Systems/save.h"
#include "../Gamemodes/enemyManagerA.h"
#include "../Gamemodes/enemyManagerB.h"
#include "../Music-Sound/soundManager.h"
#include "../UI/menuScreens.h"
#include "../Data-Systems/helpers.h"

// includes for music realted scripts
#include "hUGEDriver.h"

// Includes for the background layer
#include "../Sprite-Sheets/BackgroundTiles.c"
#include "../Tile-Maps/Background.c"

// PRIVATE VARIABLES //
//--------------------------------------------------------------------------------------
// Const ints for magic numbers used through out spawn logic.
#define SPRITE_SHEET_EMPTY_SLOT 82

// New Player object for storing and setting player information.
static Player m_oPlayer;

// New unsighed int 8 for getting and storing the joypad positions.
static UINT8 m_nJoy; UINT8 m_nPrevJoy;

// New static unsighed int 16 Used for storing the current score shown on the hud each frame.
static UINT16 m_nCurrentHudScore;

// New static unsighed int 16s for storing and setting the previous score/health values.
static UINT16 m_nPrevHealth = 9999; static UINT16 m_nPrevScore = 9999;

// New signed int 8 for damage an enemy does to the player on hit.
static UINT8 m_nDamgeToPlayer = 25;

// New bool value for if the game is currently paused.
static BOOLEAN m_bPaused = FALSE;

// New static unsigned int 16 for the current amount of time before health can recovery for gamemode B.
static UINT16 m_nDamgeTimer = 0;

// New bool value for if the health can recover after not taking damage for gamemode B.
static BOOLEAN m_bRecoverHealth = TRUE;

// New bool value for if the extra life pie in the oven is currently showing for gamemode A.
static BOOLEAN m_bExtraLifeActive = FALSE;

// New bool value for if the extra life pie in the oven has been collected for gamemode A.
static BOOLEAN m_bLifeCollected = FALSE;

// New static unsigned int 8 for the current frame of the pie animation for gamemode A.
static UINT8 m_nPieAniFrame = 0;

// New static unsigned int 8 for ticking the pie animation for gamemode A.
static UINT8 m_nPieAniCounter = 0;

// New const array of unsigned int 8s for each frame of the pie, needed for animating the sprite. For gamemode A.
static const UINT8 m_anPieSpriteIDs[4] = {41, 42, 43, 44};

// New const array of unsigned int 8s for each tile of the oven area of the background. Used to set back after extra life.
static const UINT8 m_anDefaultOvenTiles[8] = {36, 37, 38, 39, 55, 56, 57, 58};

// New const array of unsigned int 8s for tiles needed to show the pie in the oven.
UINT8 m_anOvenOpenTiles[8] = {77, 78, 79, 80, 81, 82, 83, 84};

// New menuCursor object, used for showing the pause menu cursor.
static MenuCursor m_oPauseCursor;

// New byte for keeping track of the current set gameMode.
static BYTE m_bCurrentGameMode = 0;

// New byte for keeping track of the current set difficulty.
static BYTE m_bCurrentDifficulty = 0;
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// InitializeGamemode: Initialize and prepare the desired gamemode.
//
// Params:
//      bMode: The gamemode to be initialized.
//      bDiff: The difficulty of the gamemode.
//--------------------------------------------------------------------------------------
void InitializeGamemode(BYTE bMode, BYTE bDiff)
{
    // Delcare Iterator needed 
    // for for loop in method.
    UINT8 i;
    
    // Set the current gamemode and difficulty 
    // for later reference.
    m_bCurrentGameMode = bMode;
    m_bCurrentDifficulty = bDiff;

    // Start initalizing gameMode A
    if (bMode == 0)
    {
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
        InitiateSpawner(bDiff);

        // Set the damage to player when getting hit
        // by an enemy to 1 as the player has hearts
        // for this gamemode.
        m_nDamgeToPlayer = 1;
    }

    // Start initalizing gameMode B
    else if (bMode == 1)
    {
        // Initiate the player and hud objects
        InitPlayer(0, &m_oPlayer);
        UpdatePlayer(&m_oPlayer);
        InitHud();

        // Prepare enemies manager.
        for(i = 0; i < MAX_ENEMIES; i++) 
        {
            InitEnemy(i);
        }

        // Set the initial difficulty
        SetInitDifficulty(bDiff);

        // Prepare spawn quque for enemies.
        InitEnemiesSpawnQueue();
    }

    // Perform a slight delay to
    // ensure we see the loading
    // for a least a moment, looks
    // much better.
    PerformantDelay(100);

    // Hide the window layer
    // which is currently showing
    // the loading text.
    HIDE_WIN;
        
    // Hide the background while things load.
    HIDE_BKG;

    // Set the level background data, and load.
    set_bkg_data(0, 103, m_caBgTiles);
    set_bkg_tiles(0, 0, 20, 18, m_caBackground);

    // Show the background again, fading in nicely.
    SHOW_BKG;
    FadeDrawLayer(0, 0, 0x00, 0x40, 0x90, 0xE4, 8);

    // Set the current palette  color
    BGP_REG = 0xE4;
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
    // Amount of points required to
    // spawn a new life.
    UINT16 nScoreToLife = 200;

    // If the player gets over 1000
    // we want the lives to be rarer
    if (m_oPlayer.nScore >= 1001) nScoreToLife = 400;

    // Check if score crossed a multiple of 200 threshold.
    // Ensure we only check this if score actually changes,
    // and ensure that the life isn't currently showing and
    // the player isn't already at the maximum health value.
    if (m_oPlayer.nScore > m_nPrevScore && m_oPlayer.nScore % nScoreToLife == 0 && !m_bExtraLifeActive && m_oPlayer.nHealth < 5) 
    {
        // Set the player to the middle lane.
        // this way the player isn't covering
        // the new spawned life, and is clear.
        m_oPlayer.nX = 80;
        UpdatePlayer(&m_oPlayer);

        // Kill all enemies in the scene. 
        KillAllEnemies();

        // Delay before completing kill all,
        // this will ensure we see the death
        // sprite for a moment. Just keep the
        // logic simple here.
        PerformantDelay(45);
        
        // Complete kill all request.
        CompleteKillAllEnemies();

        // Seeing as we want to pause the game here while this animation
        // plays we will just keep the animation simple and move the sprite
        // and then delay the game, and then move again. Once complete contiune
        // the game again.
        set_bkg_tiles(4, 2, 4, 2, m_anOvenOpenTiles); set_sprite_tile(39, 41); move_sprite(39, 52, 38); PlayLifeSpawnSound();
        PerformantDelay(15); set_sprite_tile(39, SPRITE_SHEET_EMPTY_SLOT); PerformantDelay(15);
        set_sprite_tile(39, 41); PlayLifeSpawnSound(); PerformantDelay(15); set_sprite_tile(39, SPRITE_SHEET_EMPTY_SLOT);
        PerformantDelay(15); set_sprite_tile(39, 41); PlayLifeSpawnSound(); PerformantDelay(50);
        
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
            set_bkg_tiles(4, 2, 4, 2, m_anDefaultOvenTiles);
            set_sprite_tile(39, SPRITE_SHEET_EMPTY_SLOT);
            move_sprite(39, 0, 0);
            m_bLifeCollected = TRUE;
            
            // Increase the player health
            m_oPlayer.nHealth++;
            SetHealthHearts(m_oPlayer.nHealth);

            // Play collect sound
            PlayLifeCollectSound();
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
    // Declare variables
    // for later use 
    UINT8 nX, nY;
    UINT8 nWindowBackup[5 * 20];
    UINT8 nTile;
    UINT8 anTiles[20 * 18];

    // Start pause logic.
    m_bPaused = !m_bPaused;
    m_nBlinkTimer = 0;
    m_nBlinkState = 0;
    BGP_REG = 0xE4;

    // WHEN PAUSED
    if (m_bPaused)
    {
        // Play the pausing sound.
        PlayStartSound();

        // Paused the music.
        hUGE_mute_channel(HT_CH3, HT_CH_MUTE);

        // Clone the current background to the window layer.
        get_bkg_tiles(0, 0, 20, 18, anTiles);
        set_win_tiles(0, 0, 20, 18, anTiles);

        // Position the Window layer.
        WX_REG = 7;
        WY_REG = 0;

        // Show the Window Layer.
        SHOW_WIN;

        // Slide down the Pause Menu.
        // This is done by replacing the top
        // part of the Window line by line
        for (nY = 0; nY < 3; nY++) 
        {
            for (nX = 0; nX < 20; nX++) 
            {
                nTile = 127;
                set_win_tiles(nX, nY, 1, 1, &nTile);
            }

            PerformantDelay(2);
        }

        // Show text on the Window layer for buttons.
        PrintTextToLayer(1, 3, 1, "RESUME");
        PrintTextToLayer(1, 13, 1, "QUIT");

        // Initiate the cursor used for pause screen.
        SetupPauseCursor();
    }

    // WHEN UNPAUSED
    else
    {
        // Play the pausing sound.
        PlayStartSoundReversed();

        // Unpaused the music.
        hUGE_mute_channel(HT_CH3, HT_CH_PLAY);

        // Reset positions.
        nX = 0; nY = 0;

        // Get the background tiles.
        get_bkg_tiles(0, 0, 20, 5, nWindowBackup);

        // Slide up the Pause Menu.
        // This is done by replacing the top
        // part of the Window line by line
        for (nY = 3; nY-- > 0; ) 
        {
            for (nX = 0; nX < 20; nX++) 
            {
                nTile = nWindowBackup[nY * 20 + nX];
                set_win_tiles(nX, nY, 1, 1, &nTile);
            }

            PerformantDelay(2);
        }

        // Hide the window layer.
        HIDE_WIN;

        // Set pie back in position.
        if (m_bCurrentGameMode == 0)
        {
            set_sprite_tile(6, m_anPieSpriteIDs[0]);
            move_sprite(6, 80, 26);
        }
    }
}

//--------------------------------------------------------------------------------------
// SetupPauseCursor: Prepare a new cursor to use for the pause menu.
//--------------------------------------------------------------------------------------
void SetupPauseCursor(void) 
{
    // Set cursor settings.
    m_oPauseCursor.nSpriteID = 5;
    m_oPauseCursor.nTileID   = 45;
    m_oPauseCursor.nBtnCount = 2;
    m_oPauseCursor.nStartX = 20;
    m_oPauseCursor.nStartY = 24;
    m_oPauseCursor.nStepX  = 80;
    m_oPauseCursor.nStepY  = 0;
    m_oPauseCursor.nIndex    = 0;
    m_oPauseCursor.nPrevJoy = 0;
    m_oPauseCursor.nDistance = 62;
    
    // Initiate the new cursor object.
    InitMenuCursor(&m_oPauseCursor);
}

//--------------------------------------------------------------------------------------
// UpdatePauseMenu: Update method for the slid down pause menu.
//--------------------------------------------------------------------------------------
void UpdatePauseMenu(void)
{
    // Update the Cursor used for the Pause Menu.
    UpdateMenuCursor(&m_oPauseCursor, m_nJoy, FALSE);

    // blink the screen.
    BlinkScreen();

    // Make a selection in the menu.
    if (m_nJoy & J_A && !(m_nPrevJoy & J_A))
    {
        // Unpause the game.
        if (m_oPauseCursor.nIndex == 0) PauseGame();
        
        // Reset the game.
        else reset();
    }
}

//--------------------------------------------------------------------------------------
// PrepareGameOver: Prepare the gameover screen, updating highscore data and showing UI.
//--------------------------------------------------------------------------------------
void PrepareGameOver(void)
{
    // GAME MODE A
    if (m_bCurrentGameMode == 0)
    {
        // EASY MODE
        if (m_bCurrentDifficulty == 0)
        {
            // Check if the previous highscore was beat
            if (m_oPlayer.nScore > m_oHighScoreData.nHighScoreAEasy) 
            {
                // Save the new score data and reload.
                SaveGameData(0, 0, m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
                LoadAllHighScoreData();
            }
        }

        // HARD MODE
        else
        {
            // Check if the previous highscore was beat
            if (m_oPlayer.nScore > m_oHighScoreData.nHighScoreAHard) 
            {
                // Save the new score data and reload.
                SaveGameData(0, 1, m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
                LoadAllHighScoreData();
            }
        }
    }

    // GAME MODE B
    else
    {
        // EASY MODE
        if (m_bCurrentDifficulty == 0)
        {
            // Check if the previous highscore was beat
            if (m_oPlayer.nScore > m_oHighScoreData.nHighScoreBEasy) 
            {
                // Save the new score data and reload.
                SaveGameData(1, 0, m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
                LoadAllHighScoreData();
            }
        }

        // HARD MODE
        else
        {
            // Check if the previous highscore was beat
            if (m_oPlayer.nScore > m_oHighScoreData.nHighScoreBHard) 
            {
                // Save the new score data and reload.
                SaveGameData(1, 1, m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
                LoadAllHighScoreData();
            }
        }
    }

    // Show the game over screen.
    DisplayGameOverScreen(m_bCurrentGameMode, m_bCurrentDifficulty, m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
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

            // Prepare for Gameover.
            PrepareGameOver();
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
                PlayBonkSound();

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
                // Stop the main game music
                hUGE_mute_channel(HT_CH1,HT_CH_MUTE);
                hUGE_mute_channel(HT_CH2,HT_CH_MUTE);
                hUGE_mute_channel(HT_CH3,HT_CH_MUTE);
                hUGE_mute_channel(HT_CH4,HT_CH_MUTE);

                __critical 
                {
                    // Init and play the losing life song file.
                    hUGE_init(&m_sLoseLife);
                }

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
                set_bkg_tiles(4, 2, 4, 2, m_anDefaultOvenTiles);
                set_sprite_tile(39, SPRITE_SHEET_EMPTY_SLOT);
                move_sprite(39, 0, 0);
                m_bExtraLifeActive = FALSE;
                m_bLifeCollected = FALSE;

                // Kill all enemies in the scene.
                KillAllEnemies();

                // Set the enemy that damaged the player
                // over the table where the pie sprite is
                set_sprite_tile(5, m_bEnemyHurtPlayer-1);
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
                PerformantDelay(100);

                // Mark damage false again.
                m_oPlayer.bTakenDamage = FALSE;

                // Stop the losing life song.
                hUGE_mute_channel(HT_CH1,HT_CH_MUTE);
                hUGE_mute_channel(HT_CH2,HT_CH_MUTE);
                hUGE_mute_channel(HT_CH3,HT_CH_MUTE);
                hUGE_mute_channel(HT_CH4,HT_CH_MUTE);

                __critical 
                {
                    // Init and play the main game song again.
                    hUGE_init(&m_sSong1);
                }

                // Mute all the channels, only using channel 3 in gameplay.
                hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
                hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
                hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
            }

            // Set the score, only if changed.
            SetScoreOnHud();
        }

        // If paused
        else 
        {
            // Update the pause menu.
            UpdatePauseMenu();
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

            // Prepare for Gameover.
            PrepareGameOver();
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
                set_sprite_tile(5, SPRITE_SHEET_EMPTY_SLOT);
            }

            // Check if an enemy sound effect is needed.
            // Play once per frame instead of every enemy.
            if (m_bPlayKillSoundEffect && !m_oPlayer.bTakenDamage)
            {
                // Play the Enemy death sound.
                PlayBonkSound();

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
            }

            // Only tick the damage timer while we're not taking damage.
            if (m_nDamgeTimer > 0) 
            {
                m_nDamgeTimer--;

                // Cannot recover while damaged.
                m_bRecoverHealth = FALSE;
            }

            // Once damage timer is 0 and not already recovering.
            if (m_nDamgeTimer == 0)
            {
                // Increase the health of the player.
                m_oPlayer.nHealth += 1;

                // Ensure we dont take the health too high.
                if (m_oPlayer.nHealth > 999) 
                {
                    m_oPlayer.nHealth = 998;
                }

                // Play audio to indicate health recovery
                if (!m_bRecoverHealth)
                {
                    PlayHealthRecoverSound();
                    PlayHealthRecoverSound();

                    // Ensure we only play audio once.
                    m_bRecoverHealth = TRUE;
                }
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

        // If paused
        else 
        {
            // Update the pause menu.
            UpdatePauseMenu();
        }
        
        // Set the previous used joypad position.
        m_nPrevJoy = m_nJoy;

        // Run a small delay to stop everything from
        // moving too quickly
        wait_vbl_done();
    }
}
