;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _Initialize
	.globl _LoadHighScoreData
	.globl _DisplayGameOverScreen
	.globl _ShowScoreGrade
	.globl _DisplayStartScreen
	.globl _DisplaySplashScreen
	.globl _FadeDrawLayer
	.globl _PerformantDelay
	.globl _SetDialog
	.globl _hUGE_mute_channel
	.globl _hUGE_dosound
	.globl _hUGE_init
	.globl _LoadGameData
	.globl _SaveGameData
	.globl _SetScore
	.globl _SetHealth
	.globl _InitHud
	.globl _TickSpawnTimer
	.globl _SpawnNext
	.globl _IsEnemyAlive
	.globl _IncreaseDifficulty
	.globl _UpdateEnemy
	.globl _InitEnemy
	.globl _InitEnemiesSpawnQueue
	.globl _ShowSprayEffect
	.globl _HandlePlayerInput
	.globl _UpdatePlayer
	.globl _InitPlayer
	.globl _initrand
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _reset
	.globl _waitpad
	.globl _joypad
	.globl _add_VBL
	.globl _puts
	.globl _printf
	.globl _m_nLoadedShotsTaken
	.globl _m_nLoadedScore
	.globl _m_nPrevJoy
	.globl _m_caSprites
	.globl _m_caStartScreen
	.globl _m_caStartScreenTiles
	.globl _m_caBackground
	.globl _m_caBgTiles
	.globl _m_caSplashMap
	.globl _m_caSplashTiles
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_m_oPlayer:
	.ds 25
_m_nJoy:
	.ds 1
_m_nPrevJoy::
	.ds 1
_m_nFadeIndex:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_m_nPrevHealth:
	.ds 2
_m_nPrevScore:
	.ds 2
_m_nLoadedScore::
	.ds 2
_m_nLoadedShotsTaken::
	.ds 2
_m_nDamgeToPlayer:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:78: void SetDialog(char* cpDialog, UINT8 nW, UINT8 nH, UINT8 nX, UINT8 nY)
;	---------------------------------
; Function SetDialog
; ---------------------------------
_SetDialog::
;main.c:81: set_win_tiles(0, 0, nW, nH, cpDialog);
	push	de
	ldhl	sp,	#4
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;main.c:82: move_win(nX, nY);
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	ldh	(_WX_REG + 0), a
;c:\gbdk2020\include\gb\gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, c
	ldh	(_WY_REG + 0), a
;main.c:82: move_win(nX, nY);
;main.c:83: }
	pop	hl
	add	sp, #3
	jp	(hl)
_m_caSplashTiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0xc0	; 192
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x60	; 96
	.db #0x98	; 152
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0xd9	; 217
	.db #0xd9	; 217
	.db #0x8d	; 141
	.db #0x8d	; 141
	.db #0x8d	; 141
	.db #0x8d	; 141
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x8d	; 141
	.db #0x8d	; 141
	.db #0x8d	; 141
	.db #0x8d	; 141
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0xdc	; 220
	.db #0xdc	; 220
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xac	; 172
	.db #0xac	; 172
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x38	; 56	'8'
	.db #0x47	; 71	'G'
	.db #0x20	; 32
	.db #0x5f	; 95
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0x8c	; 140
	.db #0x73	; 115	's'
	.db #0xc8	; 200
	.db #0x37	; 55	'7'
	.db #0xdc	; 220
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x71	; 113	'q'
	.db #0x0e	; 14
	.db #0x71	; 113	'q'
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x80	; 128
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0x79	; 121	'y'
	.db #0x79	; 121	'y'
	.db #0x39	; 57	'9'
	.db #0x39	; 57	'9'
	.db #0x39	; 57	'9'
	.db #0x39	; 57	'9'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x39	; 57	'9'
	.db #0x39	; 57	'9'
	.db #0x39	; 57	'9'
	.db #0x39	; 57	'9'
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xdc	; 220
	.db #0xdc	; 220
	.db #0xdc	; 220
	.db #0xdc	; 220
	.db #0xdc	; 220
	.db #0xdc	; 220
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xce	; 206
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfa	; 250
	.db #0xfa	; 250
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x9e	; 158
	.db #0x9e	; 158
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5f	; 95
	.db #0x5f	; 95
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xf4	; 244
	.db #0xf4	; 244
	.db #0xc8	; 200
	.db #0xc8	; 200
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_m_caSplashMap:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
_m_caBgTiles:
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xfe	; 254
	.db #0xe1	; 225
	.db #0xfe	; 254
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x80	; 128
	.db #0x42	; 66	'B'
	.db #0x80	; 128
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x0a	; 10
	.db #0x04	; 4
	.db #0x0a	; 10
	.db #0x04	; 4
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x2f	; 47
	.db #0x10	; 16
	.db #0x2f	; 47
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xef	; 239
	.db #0x38	; 56	'8'
	.db #0xc7	; 199
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf1	; 241
	.db #0x1c	; 28
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf4	; 244
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0x66	; 102	'f'
	.db #0xc0	; 192
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xe0	; 224
	.db #0x06	; 6
	.db #0x08	; 8
	.db #0xf6	; 246
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xcc	; 204
	.db #0xcd	; 205
	.db #0xcc	; 204
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xfb	; 251
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0x9f	; 159
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xf9	; 249
	.db #0x19	; 25
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0xd9	; 217
	.db #0x59	; 89	'Y'
	.db #0xd9	; 217
	.db #0x59	; 89	'Y'
	.db #0xd9	; 217
	.db #0x59	; 89	'Y'
	.db #0xd9	; 217
	.db #0x59	; 89	'Y'
	.db #0xd9	; 217
	.db #0x59	; 89	'Y'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x5d	; 93
	.db #0x22	; 34
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x88	; 136
	.db #0xcb	; 203
	.db #0xc8	; 200
	.db #0xcb	; 203
	.db #0xc8	; 200
	.db #0xcb	; 203
	.db #0xc8	; 200
	.db #0xcb	; 203
	.db #0x49	; 73	'I'
	.db #0xcb	; 203
	.db #0x4b	; 75	'K'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0x1e	; 30
	.db #0xf3	; 243
	.db #0x1e	; 30
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x78	; 120	'x'
	.db #0xcf	; 207
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfe	; 254
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0x1f	; 31
	.db #0x14	; 20
	.db #0x9e	; 158
	.db #0x14	; 20
	.db #0xdf	; 223
	.db #0x14	; 20
	.db #0xdc	; 220
	.db #0x17	; 23
	.db #0xdf	; 223
	.db #0x14	; 20
	.db #0xde	; 222
	.db #0x9c	; 156
	.db #0xd7	; 215
	.db #0xdc	; 220
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0x1f	; 31
	.db #0x0a	; 10
	.db #0xfe	; 254
	.db #0x0a	; 10
	.db #0x0f	; 15
	.db #0xfa	; 250
	.db #0x3f	; 63
	.db #0x0b	; 11
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf9	; 249
	.db #0x0e	; 14
	.db #0xfa	; 250
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0x79	; 121	'y'
	.db #0x79	; 121	'y'
	.db #0x79	; 121	'y'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xfb	; 251
	.db #0x7b	; 123
	.db #0xfb	; 251
	.db #0xfa	; 250
	.db #0xfb	; 251
	.db #0xfa	; 250
	.db #0xfb	; 251
	.db #0xfa	; 250
	.db #0xfb	; 251
	.db #0xfa	; 250
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xf9	; 249
	.db #0x19	; 25
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xfb	; 251
	.db #0x1b	; 27
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xd9	; 217
	.db #0x59	; 89	'Y'
	.db #0xd9	; 217
	.db #0x59	; 89	'Y'
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xca	; 202
	.db #0x4b	; 75	'K'
	.db #0xcb	; 203
	.db #0x4b	; 75	'K'
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x3f	; 63
	.db #0xe0	; 224
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xfc	; 252
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x54	; 84	'T'
	.db #0xd7	; 215
	.db #0xd6	; 214
	.db #0xd4	; 212
	.db #0x96	; 150
	.db #0x94	; 148
	.db #0x17	; 23
	.db #0x14	; 20
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x17	; 23
	.db #0x14	; 20
	.db #0x94	; 148
	.db #0x97	; 151
	.db #0x96	; 150
	.db #0x94	; 148
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0xfe	; 254
	.db #0x7a	; 122	'z'
	.db #0x0a	; 10
	.db #0x1a	; 26
	.db #0x0a	; 10
	.db #0xfb	; 251
	.db #0x0b	; 11
	.db #0xfb	; 251
	.db #0xf9	; 249
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0xfb	; 251
	.db #0x1a	; 26
	.db #0xfb	; 251
	.db #0x1b	; 27
	.db #0xfb	; 251
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x17	; 23
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x09	; 9
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x96	; 150
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x17	; 23
	.db #0x16	; 22
	.db #0x14	; 20
	.db #0xfb	; 251
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x07	; 7
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x1b	; 27
	.db #0x0c	; 12
	.db #0x1b	; 27
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0e	; 14
	.db #0x19	; 25
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0e	; 14
	.db #0x19	; 25
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1b	; 27
	.db #0x0c	; 12
	.db #0x1b	; 27
	.db #0x0b	; 11
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0xe8	; 232
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x6c	; 108	'l'
	.db #0xff	; 255
	.db #0x6c	; 108	'l'
	.db #0xff	; 255
	.db #0x6c	; 108	'l'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0x1e	; 30
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x3e	; 62
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3e	; 62
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x6e	; 110	'n'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0e	; 14
	.db #0x19	; 25
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0c	; 12
	.db #0x1a	; 26
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xbe	; 190
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0xe7	; 231
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf1	; 241
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_m_caBackground:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x5c	; 92
	.db #0x09	; 9
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x49	; 73	'I'
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x30	; 48	'0'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x21	; 33
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x5d	; 93
	.db #0x21	; 33
	.db #0x6a	; 106	'j'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x68	; 104	'h'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x65	; 101	'e'
	.db #0x65	; 101	'e'
	.db #0x68	; 104	'h'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x7d	; 125
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x21	; 33
	.db #0x68	; 104	'h'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6e	; 110	'n'
	.db #0x73	; 115	's'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6f	; 111	'o'
	.db #0x71	; 113	'q'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6d	; 109	'm'
	.db #0x72	; 114	'r'
	.db #0x7d	; 125
	.db #0x5d	; 93
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x79	; 121	'y'
	.db #0x6d	; 109	'm'
	.db #0x6f	; 111	'o'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x64	; 100	'd'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6f	; 111	'o'
	.db #0x62	; 98	'b'
	.db #0x21	; 33
	.db #0x79	; 121	'y'
	.db #0x6f	; 111	'o'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x5e	; 94
	.db #0x5d	; 93
	.db #0x21	; 33
	.db #0x62	; 98	'b'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x73	; 115	's'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6a	; 106	'j'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6e	; 110	'n'
	.db #0x6d	; 109	'm'
	.db #0x7d	; 125
	.db #0x34	; 52	'4'
	.db #0x64	; 100	'd'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x65	; 101	'e'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6b	; 107	'k'
	.db #0x67	; 103	'g'
	.db #0x21	; 33
	.db #0x6d	; 109	'm'
	.db #0x70	; 112	'p'
	.db #0x6e	; 110	'n'
	.db #0x73	; 115	's'
	.db #0x21	; 33
	.db #0x63	; 99	'c'
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x65	; 101	'e'
	.db #0x68	; 104	'h'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x6d	; 109	'm'
	.db #0x21	; 33
	.db #0x43	; 67	'C'
	.db #0x5d	; 93
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x65	; 101	'e'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x64	; 100	'd'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x45	; 69	'E'
	.db #0x5d	; 93
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x44	; 68	'D'
	.db #0x5d	; 93
	.db #0x63	; 99	'c'
	.db #0x21	; 33
	.db #0x62	; 98	'b'
	.db #0x6f	; 111	'o'
	.db #0x6e	; 110	'n'
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x68	; 104	'h'
	.db #0x21	; 33
	.db #0x63	; 99	'c'
	.db #0x62	; 98	'b'
	.db #0x6f	; 111	'o'
	.db #0x73	; 115	's'
	.db #0x6e	; 110	'n'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x68	; 104	'h'
	.db #0x44	; 68	'D'
	.db #0x5d	; 93
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x44	; 68	'D'
	.db #0x5d	; 93
	.db #0x21	; 33
	.db #0x71	; 113	'q'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x65	; 101	'e'
	.db #0x65	; 101	'e'
	.db #0x68	; 104	'h'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x66	; 102	'f'
	.db #0x21	; 33
	.db #0x42	; 66	'B'
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x6f	; 111	'o'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x70	; 112	'p'
	.db #0x6e	; 110	'n'
	.db #0x73	; 115	's'
	.db #0x63	; 99	'c'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6a	; 106	'j'
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x6e	; 110	'n'
	.db #0x6d	; 109	'm'
	.db #0x7d	; 125
	.db #0x61	; 97	'a'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x69	; 105	'i'
	.db #0x7c	; 124
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x7b	; 123
_m_caStartScreenTiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc2	; 194
	.db #0xc2	; 194
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0x7d	; 125
	.db #0xfd	; 253
	.db #0x7a	; 122	'z'
	.db #0xf8	; 248
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0x70	; 112	'p'
	.db #0x78	; 120	'x'
	.db #0xb8	; 184
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x1b	; 27
	.db #0x17	; 23
	.db #0x3b	; 59
	.db #0x37	; 55	'7'
	.db #0x71	; 113	'q'
	.db #0x6f	; 111	'o'
	.db #0xe1	; 225
	.db #0xdf	; 223
	.db #0xc3	; 195
	.db #0xbf	; 191
	.db #0x81	; 129
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xfe	; 254
	.db #0x87	; 135
	.db #0xfe	; 254
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xdc	; 220
	.db #0x1e	; 30
	.db #0xee	; 238
	.db #0x0f	; 15
	.db #0xf7	; 247
	.db #0x07	; 7
	.db #0xfb	; 251
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xf3	; 243
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x0e	; 14
	.db #0x0d	; 13
	.db #0x1c	; 28
	.db #0x1b	; 27
	.db #0x38	; 56	'8'
	.db #0x37	; 55	'7'
	.db #0x70	; 112	'p'
	.db #0x6f	; 111	'o'
	.db #0xe0	; 224
	.db #0xdf	; 223
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0xb0	; 176
	.db #0x3f	; 63
	.db #0xd8	; 216
	.db #0x1f	; 31
	.db #0xec	; 236
	.db #0x0f	; 15
	.db #0xf7	; 247
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0x7f	; 127
	.db #0xf8	; 248
	.db #0x3f	; 63
	.db #0xfd	; 253
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0x73	; 115	's'
	.db #0xef	; 239
	.db #0x27	; 39
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xe2	; 226
	.db #0x4c	; 76	'L'
	.db #0xbf	; 191
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0xb7	; 183
	.db #0xd8	; 216
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xd0	; 208
	.db #0xc1	; 193
	.db #0xf9	; 249
	.db #0xe0	; 224
	.db #0x67	; 103	'g'
	.db #0xf0	; 240
	.db #0x71	; 113	'q'
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x94	; 148
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x08	; 8
	.db #0xa8	; 168
	.db #0xe4	; 228
	.db #0x14	; 20
	.db #0x63	; 99	'c'
	.db #0xa3	; 163
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x0e	; 14
	.db #0x0d	; 13
	.db #0x1c	; 28
	.db #0x1b	; 27
	.db #0x38	; 56	'8'
	.db #0x37	; 55	'7'
	.db #0x70	; 112	'p'
	.db #0x6f	; 111	'o'
	.db #0xe0	; 224
	.db #0xdf	; 223
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0xb4	; 180
	.db #0x3f	; 63
	.db #0xde	; 222
	.db #0x1f	; 31
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7b	; 123
	.db #0x87	; 135
	.db #0xfd	; 253
	.db #0x23	; 35
	.db #0xbe	; 190
	.db #0x71	; 113	'q'
	.db #0xbe	; 190
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xf2	; 242
	.db #0x7e	; 126
	.db #0xf1	; 241
	.db #0xb7	; 183
	.db #0xf8	; 248
	.db #0xbb	; 187
	.db #0xf0	; 240
	.db #0x71	; 113	'q'
	.db #0x60	; 96
	.db #0xe1	; 225
	.db #0x83	; 131
	.db #0xc0	; 192
	.db #0x81	; 129
	.db #0xc6	; 198
	.db #0x84	; 132
	.db #0xa3	; 163
	.db #0x33	; 51	'3'
	.db #0x70	; 112	'p'
	.db #0x1f	; 31
	.db #0x30	; 48	'0'
	.db #0x8f	; 143
	.db #0x98	; 152
	.db #0x9f	; 159
	.db #0x8c	; 140
	.db #0x7f	; 127
	.db #0xc6	; 198
	.db #0x39	; 57	'9'
	.db #0xe1	; 225
	.db #0xd1	; 209
	.db #0x20	; 32
	.db #0xe1	; 225
	.db #0x80	; 128
	.db #0xf8	; 248
	.db #0xc0	; 192
	.db #0xfe	; 254
	.db #0x28	; 40
	.db #0x7f	; 127
	.db #0x0c	; 12
	.db #0x9f	; 159
	.db #0x06	; 6
	.db #0x8f	; 143
	.db #0x01	; 1
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0x80	; 128
	.db #0xf9	; 249
	.db #0x40	; 64
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf1	; 241
	.db #0x81	; 129
	.db #0xf1	; 241
	.db #0x01	; 1
	.db #0xe3	; 227
	.db #0x03	; 3
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0xc0	; 192
	.db #0x0f	; 15
	.db #0x80	; 128
	.db #0x0f	; 15
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x1e	; 30
	.db #0x1d	; 29
	.db #0x3c	; 60
	.db #0x3b	; 59
	.db #0x38	; 56	'8'
	.db #0x37	; 55	'7'
	.db #0x70	; 112	'p'
	.db #0x6f	; 111	'o'
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0xfe	; 254
	.db #0x1c	; 28
	.db #0xfd	; 253
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xc1	; 193
	.db #0xd0	; 208
	.db #0x80	; 128
	.db #0x21	; 33
	.db #0x8d	; 141
	.db #0x38	; 56	'8'
	.db #0xdd	; 221
	.db #0x18	; 24
	.db #0xf6	; 246
	.db #0x44	; 68	'D'
	.db #0x73	; 115	's'
	.db #0xec	; 236
	.db #0xf7	; 247
	.db #0x46	; 70	'F'
	.db #0x3b	; 59
	.db #0xf6	; 246
	.db #0xdb	; 219
	.db #0x33	; 51	'3'
	.db #0x79	; 121	'y'
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xf0	; 240
	.db #0xde	; 222
	.db #0x38	; 56	'8'
	.db #0x6f	; 111	'o'
	.db #0x1c	; 28
	.db #0x37	; 55	'7'
	.db #0x0e	; 14
	.db #0x99	; 153
	.db #0x07	; 7
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xe5	; 229
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0x30	; 48	'0'
	.db #0xc0	; 192
	.db #0x18	; 24
	.db #0x80	; 128
	.db #0x0e	; 14
	.db #0x18	; 24
	.db #0x1e	; 30
	.db #0x9c	; 156
	.db #0x1f	; 31
	.db #0x98	; 152
	.db #0x1c	; 28
	.db #0x84	; 132
	.db #0x86	; 134
	.db #0x90	; 144
	.db #0x10	; 16
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x80	; 128
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0x79	; 121	'y'
	.db #0x86	; 134
	.db #0xe3	; 227
	.db #0x1e	; 30
	.db #0x83	; 131
	.db #0x7e	; 126
	.db #0x9b	; 155
	.db #0x7e	; 126
	.db #0x8f	; 143
	.db #0x7e	; 126
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0x3f	; 63
	.db #0xfe	; 254
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0xa7	; 167
	.db #0x78	; 120	'x'
	.db #0xa3	; 163
	.db #0x7c	; 124
	.db #0xf1	; 241
	.db #0x7e	; 126
	.db #0xfd	; 253
	.db #0x7e	; 126
	.db #0xf0	; 240
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x31	; 49	'1'
	.db #0xf0	; 240
	.db #0x71	; 113	'q'
	.db #0xf0	; 240
	.db #0xe1	; 225
	.db #0xe0	; 224
	.db #0x9b	; 155
	.db #0x98	; 152
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x3f	; 63
	.db #0x08	; 8
	.db #0x56	; 86	'V'
	.db #0x08	; 8
	.db #0x54	; 84	'T'
	.db #0x08	; 8
	.db #0xdc	; 220
	.db #0x0c	; 12
	.db #0xde	; 222
	.db #0x04	; 4
	.db #0xde	; 222
	.db #0x06	; 6
	.db #0xf1	; 241
	.db #0x11	; 17
	.db #0xe8	; 232
	.db #0x18	; 24
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x33	; 51	'3'
	.db #0x3f	; 63
	.db #0x4b	; 75	'K'
	.db #0x4f	; 79	'O'
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0xe6	; 230
	.db #0x81	; 129
	.db #0x93	; 147
	.db #0x80	; 128
	.db #0xc8	; 200
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0x78	; 120	'x'
	.db #0x7c	; 124
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0x9e	; 158
	.db #0xbf	; 191
	.db #0x38	; 56	'8'
	.db #0xb8	; 184
	.db #0x3c	; 60
	.db #0xfc	; 252
	.db #0x1c	; 28
	.db #0x7e	; 126
	.db #0x4c	; 76	'L'
	.db #0x7c	; 124
	.db #0x30	; 48	'0'
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x39	; 57	'9'
	.db #0x3d	; 61
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x80	; 128
	.db #0x07	; 7
	.db #0x80	; 128
	.db #0xc3	; 195
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x81	; 129
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0xfe	; 254
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0x6f	; 111	'o'
	.db #0xfe	; 254
	.db #0x4f	; 79	'O'
	.db #0xfe	; 254
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xc3	; 195
	.db #0x3e	; 62
	.db #0xe1	; 225
	.db #0x1e	; 30
	.db #0x79	; 121	'y'
	.db #0x86	; 134
	.db #0xee	; 238
	.db #0x7f	; 127
	.db #0xf8	; 248
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0x7f	; 127
	.db #0xb1	; 177
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x83	; 131
	.db #0x7c	; 124
	.db #0x87	; 135
	.db #0x78	; 120	'x'
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0x1c	; 28
	.db #0xfc	; 252
	.db #0x38	; 56	'8'
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0xc1	; 193
	.db #0xc0	; 192
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0xe4	; 228
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x01	; 1
	.db #0x87	; 135
	.db #0x07	; 7
	.db #0x9f	; 159
	.db #0x1f	; 31
	.db #0x9e	; 158
	.db #0x1f	; 31
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xcf	; 207
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0x1c	; 28
	.db #0xfc	; 252
	.db #0x38	; 56	'8'
	.db #0xf8	; 248
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x9c	; 156
	.db #0x1e	; 30
	.db #0x8c	; 140
	.db #0x0e	; 14
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc7	; 199
	.db #0xe7	; 231
	.db #0xf9	; 249
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xfd	; 253
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xd7	; 215
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0xe0	; 224
	.db #0x87	; 135
	.db #0xc0	; 192
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x7f	; 127
	.db #0x3d	; 61
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xe6	; 230
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x87	; 135
	.db #0x07	; 7
	.db #0x83	; 131
	.db #0x03	; 3
	.db #0x83	; 131
	.db #0x03	; 3
	.db #0x81	; 129
	.db #0x01	; 1
	.db #0xc1	; 193
	.db #0x01	; 1
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xe3	; 227
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0x3c	; 60
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0xc3	; 195
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xff	; 255
	.db #0xcf	; 207
	.db #0xff	; 255
	.db #0xce	; 206
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0x73	; 115	's'
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x71	; 113	'q'
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x19	; 25
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xe7	; 231
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0x71	; 113	'q'
	.db #0x78	; 120	'x'
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x7c	; 124
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xcf	; 207
	.db #0x06	; 6
	.db #0xdf	; 223
	.db #0x8e	; 142
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0x73	; 115	's'
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x79	; 121	'y'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x7b	; 123
	.db #0x39	; 57	'9'
	.db #0x7b	; 123
	.db #0x39	; 57	'9'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0xfe	; 254
	.db #0xec	; 236
	.db #0xfe	; 254
	.db #0xec	; 236
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0xf7	; 247
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xe1	; 225
	.db #0xf1	; 241
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x33	; 51	'3'
	.db #0xff	; 255
	.db #0x33	; 51	'3'
	.db #0x7f	; 127
	.db #0x03	; 3
	.db #0x87	; 135
	.db #0x03	; 3
	.db #0xc7	; 199
	.db #0x83	; 131
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0xf7	; 247
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xcf	; 207
	.db #0x87	; 135
	.db #0xcf	; 207
	.db #0x87	; 135
	.db #0xcf	; 207
	.db #0x87	; 135
	.db #0xcf	; 207
	.db #0x87	; 135
	.db #0xcf	; 207
	.db #0x86	; 134
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf9	; 249
	.db #0x70	; 112	'p'
	.db #0xf9	; 249
	.db #0x70	; 112	'p'
	.db #0xf9	; 249
	.db #0x70	; 112	'p'
	.db #0xf9	; 249
	.db #0x71	; 113	'q'
	.db #0x7f	; 127
	.db #0x71	; 113	'q'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x77	; 119	'w'
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0xc3	; 195
	.db #0xef	; 239
	.db #0xe3	; 227
	.db #0xe7	; 231
	.db #0xe3	; 227
	.db #0xef	; 239
	.db #0xc7	; 199
	.db #0xef	; 239
	.db #0xc7	; 199
	.db #0xcf	; 207
	.db #0x86	; 134
	.db #0xcf	; 207
	.db #0xc6	; 198
	.db #0xef	; 239
	.db #0xc6	; 198
	.db #0xfb	; 251
	.db #0x61	; 97	'a'
	.db #0xfb	; 251
	.db #0x31	; 49	'1'
	.db #0xf9	; 249
	.db #0x30	; 48	'0'
	.db #0xf9	; 249
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0xde	; 222
	.db #0x8c	; 140
	.db #0xfe	; 254
	.db #0xdc	; 220
	.db #0xfc	; 252
	.db #0xdc	; 220
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3d	; 61
	.db #0x38	; 56	'8'
	.db #0xbf	; 191
	.db #0x39	; 57	'9'
	.db #0xbf	; 191
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x3b	; 59
	.db #0x3d	; 61
	.db #0x38	; 56	'8'
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x73	; 115	's'
	.db #0xfb	; 251
	.db #0x73	; 115	's'
	.db #0xfb	; 251
	.db #0x73	; 115	's'
	.db #0xfb	; 251
	.db #0x73	; 115	's'
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe1	; 225
	.db #0xef	; 239
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0xbf	; 191
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x6c	; 108	'l'
	.db #0xfe	; 254
	.db #0x6c	; 108	'l'
	.db #0xfe	; 254
	.db #0x6c	; 108	'l'
	.db #0xfe	; 254
	.db #0xec	; 236
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xbf	; 191
	.db #0x27	; 39
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x3b	; 59
	.db #0x7f	; 127
	.db #0x3b	; 59
	.db #0x7f	; 127
	.db #0x3b	; 59
	.db #0x7f	; 127
	.db #0x3b	; 59
	.db #0xff	; 255
	.db #0x73	; 115	's'
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xf7	; 247
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0x79	; 121	'y'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0xce	; 206
	.db #0xef	; 239
	.db #0xee	; 238
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xfe	; 254
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0xfc	; 252
	.db #0x38	; 56	'8'
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0x3c	; 60
	.db #0x1c	; 28
	.db #0x3e	; 62
	.db #0x1c	; 28
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0xbc	; 188
	.db #0x38	; 56	'8'
	.db #0xbc	; 188
	.db #0x38	; 56	'8'
	.db #0xbc	; 188
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_m_caStartScreen:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x0b	; 11
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x78	; 120	'x'
	.db #0x79	; 121	'y'
	.db #0x7a	; 122	'z'
	.db #0x7b	; 123
	.db #0x7c	; 124
	.db #0x7d	; 125
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
_m_caSprites:
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x2f	; 47
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xcc	; 204
	.db #0x3c	; 60
	.db #0x76	; 118	'v'
	.db #0x5e	; 94
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x28	; 40
	.db #0x2f	; 47
	.db #0x23	; 35
	.db #0x25	; 37
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x31	; 49	'1'
	.db #0x2e	; 46
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x23	; 35
	.db #0x25	; 37
	.db #0x28	; 40
	.db #0xaf	; 175
	.db #0x2a	; 42
	.db #0xaa	; 170
	.db #0x76	; 118	'v'
	.db #0xde	; 222
	.db #0xcc	; 204
	.db #0x3c	; 60
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0x3c	; 60
	.db #0xc4	; 196
	.db #0x1c	; 28
	.db #0xe4	; 228
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xca	; 202
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xe0	; 224
	.db #0x9f	; 159
	.db #0xf0	; 240
	.db #0x8e	; 142
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x92	; 146
	.db #0x2e	; 46
	.db #0x2e	; 46
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x80	; 128
	.db #0x8e	; 142
	.db #0xe8	; 232
	.db #0x76	; 118	'v'
	.db #0xc4	; 196
	.db #0x5e	; 94
	.db #0xe0	; 224
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0xf0	; 240
	.db #0xcf	; 207
	.db #0xe0	; 224
	.db #0x9f	; 159
	.db #0xe0	; 224
	.db #0x9f	; 159
	.db #0xe0	; 224
	.db #0x9f	; 159
	.db #0x60	; 96
	.db #0x5f	; 95
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x1c	; 28
	.db #0xfc	; 252
	.db #0x0f	; 15
	.db #0xf3	; 243
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0xda	; 218
	.db #0x70	; 112	'p'
	.db #0x4e	; 78	'N'
	.db #0x78	; 120	'x'
	.db #0x48	; 72	'H'
	.db #0x2f	; 47
	.db #0x37	; 55	'7'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x16	; 22
	.db #0x1e	; 30
	.db #0x18	; 24
	.db #0x1b	; 27
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x02	; 2
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0xf4	; 244
	.db #0xec	; 236
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x68	; 104	'h'
	.db #0x78	; 120	'x'
	.db #0x18	; 24
	.db #0xd8	; 216
	.db #0xb0	; 176
	.db #0x70	; 112	'p'
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x3c	; 60
	.db #0x23	; 35
	.db #0x38	; 56	'8'
	.db #0x27	; 39
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x57	; 87	'W'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x78	; 120	'x'
	.db #0x49	; 73	'I'
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0x52	; 82	'R'
	.db #0x52	; 82	'R'
	.db #0x01	; 1
	.db #0x71	; 113	'q'
	.db #0x17	; 23
	.db #0x6e	; 110	'n'
	.db #0x23	; 35
	.db #0x7a	; 122	'z'
	.db #0x07	; 7
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x07	; 7
	.db #0x79	; 121	'y'
	.db #0x0f	; 15
	.db #0x71	; 113	'q'
	.db #0xfe	; 254
	.db #0x82	; 130
	.db #0xfc	; 252
	.db #0x0c	; 12
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x33	; 51	'3'
	.db #0x3c	; 60
	.db #0x6e	; 110	'n'
	.db #0x7b	; 123
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x14	; 20
	.db #0xf5	; 245
	.db #0xc4	; 196
	.db #0xa4	; 164
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0xf4	; 244
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xc4	; 196
	.db #0xa4	; 164
	.db #0x14	; 20
	.db #0xf4	; 244
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x6e	; 110	'n'
	.db #0x7a	; 122	'z'
	.db #0x33	; 51	'3'
	.db #0x3c	; 60
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x0c	; 12
	.db #0xf4	; 244
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x3f	; 63
	.db #0x23	; 35
	.db #0x7a	; 122	'z'
	.db #0x17	; 23
	.db #0x6e	; 110	'n'
	.db #0x01	; 1
	.db #0x71	; 113	'q'
	.db #0x52	; 82	'R'
	.db #0x52	; 82	'R'
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0x78	; 120	'x'
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xfc	; 252
	.db #0x0c	; 12
	.db #0xfe	; 254
	.db #0x82	; 130
	.db #0x0f	; 15
	.db #0x71	; 113	'q'
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x70	; 112	'p'
	.db #0x53	; 83	'S'
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x38	; 56	'8'
	.db #0x27	; 39
	.db #0x3c	; 60
	.db #0x23	; 35
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x18	; 24
	.db #0x1b	; 27
	.db #0x16	; 22
	.db #0x1e	; 30
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x2f	; 47
	.db #0x37	; 55	'7'
	.db #0x78	; 120	'x'
	.db #0x48	; 72	'H'
	.db #0x70	; 112	'p'
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xb0	; 176
	.db #0x70	; 112	'p'
	.db #0x18	; 24
	.db #0xd8	; 216
	.db #0x68	; 104	'h'
	.db #0x78	; 120	'x'
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0xf4	; 244
	.db #0xec	; 236
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x0e	; 14
	.db #0x72	; 114	'r'
	.db #0x60	; 96
	.db #0x5b	; 91
	.db #0xe0	; 224
	.db #0x9f	; 159
	.db #0xe0	; 224
	.db #0x9f	; 159
	.db #0xe0	; 224
	.db #0x9f	; 159
	.db #0xf0	; 240
	.db #0xcf	; 207
	.db #0x38	; 56	'8'
	.db #0x3f	; 63
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0xfa	; 250
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x07	; 7
	.db #0xf9	; 249
	.db #0x0f	; 15
	.db #0xf3	; 243
	.db #0x1c	; 28
	.db #0xfc	; 252
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0xf0	; 240
	.db #0x8e	; 142
	.db #0xe0	; 224
	.db #0x9e	; 158
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xfc	; 252
	.db #0xc4	; 196
	.db #0x5e	; 94
	.db #0xe8	; 232
	.db #0x76	; 118	'v'
	.db #0x80	; 128
	.db #0x8e	; 142
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x2e	; 46
	.db #0x2e	; 46
	.db #0x1e	; 30
	.db #0x92	; 146
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0xea	; 234
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x1c	; 28
	.db #0xe4	; 228
	.db #0x3c	; 60
	.db #0xc4	; 196
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xa8	; 168
	.db #0xa8	; 168
	.db #0x85	; 133
	.db #0x85	; 133
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x85	; 133
	.db #0x85	; 133
	.db #0xa8	; 168
	.db #0xa8	; 168
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x70	; 112	'p'
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7c	; 124
	.db #0x7f	; 127
	.db #0x6e	; 110	'n'
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x70	; 112	'p'
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x70	; 112	'p'
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x7c	; 124
	.db #0x78	; 120	'x'
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x76	; 118	'v'
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x76	; 118	'v'
	.db #0x66	; 102	'f'
	.db #0x76	; 118	'v'
	.db #0x66	; 102	'f'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0xc5	; 197
	.db #0xfd	; 253
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x37	; 55	'7'
	.db #0x39	; 57	'9'
	.db #0x4f	; 79	'O'
	.db #0x49	; 73	'I'
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0xbd	; 189
	.db #0xa5	; 165
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x58	; 88	'X'
	.db #0x58	; 88	'X'
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0xa3	; 163
	.db #0xbf	; 191
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xec	; 236
	.db #0x9c	; 156
	.db #0xf2	; 242
	.db #0x92	; 146
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x6e	; 110	'n'
	.db #0x7a	; 122	'z'
	.db #0x47	; 71	'G'
	.db #0x79	; 121	'y'
	.db #0x47	; 71	'G'
	.db #0x79	; 121	'y'
	.db #0x6e	; 110	'n'
	.db #0x7a	; 122	'z'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x76	; 118	'v'
	.db #0x5e	; 94
	.db #0xe2	; 226
	.db #0x9e	; 158
	.db #0xe2	; 226
	.db #0x9e	; 158
	.db #0x76	; 118	'v'
	.db #0x5e	; 94
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x4f	; 79	'O'
	.db #0x49	; 73	'I'
	.db #0x37	; 55	'7'
	.db #0x39	; 57	'9'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xc5	; 197
	.db #0xfd	; 253
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xbd	; 189
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0xf2	; 242
	.db #0x92	; 146
	.db #0xec	; 236
	.db #0x9c	; 156
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xa3	; 163
	.db #0xbf	; 191
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x58	; 88	'X'
	.db #0x58	; 88	'X'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x1a	; 26
	.db #0x16	; 22
	.db #0xe6	; 230
	.db #0xfa	; 250
	.db #0xa2	; 162
	.db #0xde	; 222
	.db #0x97	; 151
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xa5	; 165
	.db #0xe7	; 231
	.db #0xbd	; 189
	.db #0xdb	; 219
	.db #0xa5	; 165
	.db #0xdb	; 219
	.db #0x66	; 102	'f'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
	.db #0x58	; 88	'X'
	.db #0x68	; 104	'h'
	.db #0x67	; 103	'g'
	.db #0x5f	; 95
	.db #0x45	; 69	'E'
	.db #0x7b	; 123
	.db #0xe9	; 233
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x7e	; 126
	.db #0x46	; 70	'F'
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x7e	; 126
	.db #0x46	; 70	'F'
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x7e	; 126
	.db #0x62	; 98	'b'
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0x7e	; 126
	.db #0x62	; 98	'b'
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x97	; 151
	.db #0xef	; 239
	.db #0xa2	; 162
	.db #0xde	; 222
	.db #0xe6	; 230
	.db #0xfa	; 250
	.db #0x1a	; 26
	.db #0x16	; 22
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x5a	; 90	'Z'
	.db #0xa5	; 165
	.db #0xdb	; 219
	.db #0xbd	; 189
	.db #0xdb	; 219
	.db #0xa5	; 165
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe9	; 233
	.db #0xf7	; 247
	.db #0x45	; 69	'E'
	.db #0x7b	; 123
	.db #0x67	; 103	'g'
	.db #0x5f	; 95
	.db #0x58	; 88	'X'
	.db #0x68	; 104	'h'
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x29	; 41
	.db #0x69	; 105	'i'
	.db #0x9a	; 154
	.db #0xfa	; 250
	.db #0x9c	; 156
	.db #0xfc	; 252
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0x56	; 86	'V'
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0xa5	; 165
	.db #0xbd	; 189
	.db #0x6e	; 110	'n'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x99	; 153
	.db #0x81	; 129
	.db #0x96	; 150
	.db #0x96	; 150
	.db #0x58	; 88	'X'
	.db #0x5f	; 95
	.db #0x39	; 57	'9'
	.db #0x3f	; 63
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0x6a	; 106	'j'
	.db #0x0a	; 10
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x3f	; 63
	.db #0xfe	; 254
	.db #0x9f	; 159
	.db #0xfe	; 254
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0xf9	; 249
	.db #0x7f	; 127
	.db #0xfc	; 252
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x56	; 86	'V'
	.db #0x50	; 80	'P'
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x9c	; 156
	.db #0xfc	; 252
	.db #0x1a	; 26
	.db #0xfa	; 250
	.db #0x69	; 105	'i'
	.db #0x69	; 105	'i'
	.db #0x99	; 153
	.db #0x81	; 129
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x76	; 118	'v'
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0xbd	; 189
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x6a	; 106	'j'
	.db #0x0a	; 10
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x39	; 57	'9'
	.db #0x3f	; 63
	.db #0x59	; 89	'Y'
	.db #0x5f	; 95
	.db #0x94	; 148
	.db #0x96	; 150
	.db #0x10	; 16
	.db #0x50	; 80	'P'
	.db #0x68	; 104	'h'
	.db #0xe8	; 232
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0xba	; 186
	.db #0xba	; 186
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x42	; 66	'B'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x08	; 8
	.db #0x0a	; 10
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x2e	; 46
	.db #0x2e	; 46
	.db #0x5d	; 93
	.db #0x5d	; 93
	.db #0x3a	; 58
	.db #0x3a	; 58
	.db #0x74	; 116	't'
	.db #0xf4	; 244
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0xa8	; 168
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x7e	; 126
	.db #0xfe	; 254
	.db #0x7e	; 126
	.db #0xfe	; 254
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0xa8	; 168
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x2a	; 42
	.db #0xaa	; 170
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x2a	; 42
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0xba	; 186
	.db #0xba	; 186
	.db #0x74	; 116	't'
	.db #0x74	; 116	't'
	.db #0x68	; 104	'h'
	.db #0xe8	; 232
	.db #0x10	; 16
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x74	; 116	't'
	.db #0xf4	; 244
	.db #0x3a	; 58
	.db #0x3a	; 58
	.db #0x5d	; 93
	.db #0x5d	; 93
	.db #0x2e	; 46
	.db #0x2e	; 46
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x08	; 8
	.db #0x0a	; 10
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x7e	; 126
	.db #0x62	; 98	'b'
	.db #0x7c	; 124
	.db #0x74	; 116	't'
	.db #0xf8	; 248
	.db #0xb8	; 184
	.db #0xfe	; 254
	.db #0x9c	; 156
	.db #0xec	; 236
	.db #0xac	; 172
	.db #0x48	; 72	'H'
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x7e	; 126
	.db #0x46	; 70	'F'
	.db #0x3e	; 62
	.db #0x2e	; 46
	.db #0x1f	; 31
	.db #0x1d	; 29
	.db #0x7f	; 127
	.db #0x39	; 57	'9'
	.db #0x37	; 55	'7'
	.db #0x35	; 53	'5'
	.db #0x12	; 18
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x48	; 72	'H'
	.db #0x3a	; 58
	.db #0x28	; 40
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x3a	; 58
	.db #0x28	; 40
	.db #0x78	; 120	'x'
	.db #0x48	; 72	'H'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x5c	; 92
	.db #0x14	; 20
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x5c	; 92
	.db #0x14	; 20
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x40	; 64
	.db #0xec	; 236
	.db #0xac	; 172
	.db #0xfe	; 254
	.db #0x9c	; 156
	.db #0xf8	; 248
	.db #0xb8	; 184
	.db #0x7c	; 124
	.db #0x74	; 116	't'
	.db #0x7e	; 126
	.db #0x62	; 98	'b'
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x02	; 2
	.db #0x37	; 55	'7'
	.db #0x35	; 53	'5'
	.db #0x7f	; 127
	.db #0x39	; 57	'9'
	.db #0x1f	; 31
	.db #0x1d	; 29
	.db #0x3e	; 62
	.db #0x2e	; 46
	.db #0x7e	; 126
	.db #0x46	; 70	'F'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x6e	; 110	'n'
	.db #0x00	; 0
	.db #0x6e	; 110	'n'
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x6e	; 110	'n'
	.db #0x00	; 0
	.db #0x6e	; 110	'n'
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x36	; 54	'6'
;main.c:91: void PerformantDelay(UINT8 nLoops)
;	---------------------------------
; Function PerformantDelay
; ---------------------------------
_PerformantDelay::
	ld	c, a
;main.c:97: for (i = 0; i < nLoops; i++)
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, c
	ret	NC
;main.c:101: wait_vbl_done();
	call	_wait_vbl_done
;main.c:97: for (i = 0; i < nLoops; i++)
	inc	b
;main.c:103: }
	jr	00103$
;main.c:125: void FadeDrawLayer(BYTE bLayer, BYTE bMode, UINT8 nValue1, UINT8 nValue2, UINT8 nValue3, UINT8 nValue4, UINT8 nDelay)
;	---------------------------------
; Function FadeDrawLayer
; ---------------------------------
_FadeDrawLayer::
	dec	sp
	dec	sp
	ld	c, a
;main.c:133: if (bMode == 1)
	dec	e
	jr	NZ, 00102$
;main.c:135: nLoopAmount = 4;
	ld	b, #0x04
	jr	00103$
00102$:
;main.c:142: nLoopAmount = 3;
	ld	b, #0x03
00103$:
;main.c:146: for(m_nFadeIndex = 0; m_nFadeIndex < nLoopAmount; m_nFadeIndex++)
	xor	a, a
	ld	(#_m_nFadeIndex),a
00119$:
	ld	hl, #_m_nFadeIndex
	ld	a, (hl)
	sub	a, b
	jp	NC, 00121$
;main.c:153: switch(m_nFadeIndex)
	ld	a, #0x03
	sub	a, (hl)
	ld	a, #0x00
	rla
;main.c:156: BGP_REG = nValue1;
	ldhl	sp,	#4
	ld	e, (hl)
;main.c:160: BGP_REG = nValue2;
	inc	hl
	push	af
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;main.c:164: BGP_REG = nValue3;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	pop	af
;main.c:168: BGP_REG = nValue4;
	ldhl	sp,	#7
	ld	d, (hl)
;main.c:149: if (bLayer == 0)
	inc	c
	dec	c
	jr	NZ, 00115$
;main.c:153: switch(m_nFadeIndex)
	or	a, a
	jr	NZ, 00116$
	push	de
	ld	a, (_m_nFadeIndex)
	ld	e, a
	ld	d, #0x00
	ld	hl, #00167$
	add	hl, de
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	pop	de
	jp	(hl)
00167$:
	.dw	00104$
	.dw	00105$
	.dw	00106$
	.dw	00107$
;main.c:155: case 0:
00104$:
;main.c:156: BGP_REG = nValue1;
	ld	a, e
	ldh	(_BGP_REG + 0), a
;main.c:157: break;
	jr	00116$
;main.c:159: case 1:
00105$:
;main.c:160: BGP_REG = nValue2;
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;main.c:161: break;
	jr	00116$
;main.c:163: case 2:
00106$:
;main.c:164: BGP_REG = nValue3;
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;main.c:165: break;
	jr	00116$
;main.c:167: case 3:
00107$:
;main.c:168: BGP_REG = nValue4;
	ld	a, d
	ldh	(_BGP_REG + 0), a
;main.c:170: }
	jr	00116$
00115$:
;main.c:177: switch(m_nFadeIndex)
	or	a, a
	jr	NZ, 00116$
	push	de
	ld	a, (_m_nFadeIndex)
	ld	e, a
	ld	d, #0x00
	ld	hl, #00168$
	add	hl, de
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	pop	de
	jp	(hl)
00168$:
	.dw	00109$
	.dw	00110$
	.dw	00111$
	.dw	00112$
;main.c:179: case 0:
00109$:
;main.c:180: OBP0_REG = nValue1;
	ld	a, e
	ldh	(_OBP0_REG + 0), a
;main.c:181: break;
	jr	00116$
;main.c:183: case 1:
00110$:
;main.c:184: OBP0_REG = nValue2;
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(_OBP0_REG + 0), a
;main.c:185: break;
	jr	00116$
;main.c:187: case 2:
00111$:
;main.c:188: OBP0_REG = nValue3;
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(_OBP0_REG + 0), a
;main.c:189: break;
	jr	00116$
;main.c:191: case 3:
00112$:
;main.c:192: OBP0_REG = nValue4;
	ld	a, d
	ldh	(_OBP0_REG + 0), a
;main.c:194: }
00116$:
;main.c:198: PerformantDelay(nDelay);
	push	bc
	ldhl	sp,	#10
	ld	a, (hl)
	call	_PerformantDelay
	pop	bc
;main.c:146: for(m_nFadeIndex = 0; m_nFadeIndex < nLoopAmount; m_nFadeIndex++)
	ld	hl, #_m_nFadeIndex
	inc	(hl)
	jp	00119$
00121$:
;main.c:200: }
	inc	sp
	inc	sp
	pop	hl
	add	sp, #5
	jp	(hl)
;main.c:205: void DisplaySplashScreen(void)
;	---------------------------------
; Function DisplaySplashScreen
; ---------------------------------
_DisplaySplashScreen::
;main.c:216: BGP_REG = 0x27;
	ld	a, #0x27
	ldh	(_BGP_REG + 0), a
;main.c:219: set_bkg_data(0, 55, m_caSplashTiles);
	ld	de, #_m_caSplashTiles
	push	de
	ld	hl, #0x3700
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:220: set_bkg_tiles(0, 0, 20, 18, m_caSplashMap);
	ld	de, #_m_caSplashMap
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:223: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:226: PerformantDelay(65);
	ld	a, #0x41
	call	_PerformantDelay
;main.c:230: NR10_REG = 0x78;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
;main.c:231: NR11_REG = 0x81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;main.c:232: NR12_REG = 0x42;
	ld	a, #0x42
	ldh	(_NR12_REG + 0), a
;main.c:233: NR13_REG = 0x9E;
	ld	a, #0x9e
	ldh	(_NR13_REG + 0), a
;main.c:234: NR14_REG = 0x87;
	ld	a, #0x87
	ldh	(_NR14_REG + 0), a
;main.c:237: PerformantDelay(10);
	ld	a, #0x0a
	call	_PerformantDelay
;main.c:240: NR10_REG = 0x78;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
;main.c:241: NR11_REG = 0x81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;main.c:242: NR12_REG = 0x42;
	ld	a, #0x42
	ldh	(_NR12_REG + 0), a
;main.c:243: NR13_REG = 0x72;
	ld	a, #0x72
	ldh	(_NR13_REG + 0), a
;main.c:244: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;main.c:247: PerformantDelay(8);
	ld	a, #0x08
	call	_PerformantDelay
;main.c:250: NR10_REG = 0x78;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
;main.c:251: NR11_REG = 0x81;
	ld	a, #0x81
	ldh	(_NR11_REG + 0), a
;main.c:252: NR12_REG = 0x42;
	ld	a, #0x42
	ldh	(_NR12_REG + 0), a
;main.c:253: NR13_REG = 0xAA;
	ld	a, #0xaa
	ldh	(_NR13_REG + 0), a
;main.c:254: NR14_REG = 0x85;
	ld	a, #0x85
	ldh	(_NR14_REG + 0), a
;main.c:257: PerformantDelay(135);
	ld	a, #0x87
	call	_PerformantDelay
;main.c:258: FadeDrawLayer(0, 1, 0x67, 0xBB, 0xFB, 0xFF, 15);
	ld	hl, #0xfff
	push	hl
	ld	hl, #0xfbbb
	push	hl
	ld	a, #0x67
	push	af
	inc	sp
	ld	e, #0x01
	xor	a, a
	call	_FadeDrawLayer
;main.c:259: }
	ret
;main.c:264: void DisplayStartScreen(void)
;	---------------------------------
; Function DisplayStartScreen
; ---------------------------------
_DisplayStartScreen::
;main.c:271: set_bkg_data(0, 127, m_caStartScreenTiles);
	ld	de, #_m_caStartScreenTiles
	push	de
	ld	hl, #0x7f00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:272: set_bkg_tiles(0, 0, 20, 18, m_caStartScreen);
	ld	de, #_m_caStartScreen
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:281: }
	di
;main.c:279: hUGE_init(&song1);
	ld	de, #_song1
	call	_hUGE_init
;main.c:280: add_VBL(hUGE_dosound);
	ld	de, #_hUGE_dosound
	call	_add_VBL
	ei
;main.c:284: FadeDrawLayer(0, 0, 0xFB, 0xBB, 0xE4, 0x00, 15);
	ld	a, #0x0f
	push	af
	inc	sp
	ld	hl, #0xe4
	push	hl
	ld	hl, #0xbbfb
	push	hl
	xor	a, a
	ld	e, a
	call	_FadeDrawLayer
;main.c:287: PerformantDelay(25);
	ld	a, #0x19
	call	_PerformantDelay
;main.c:290: SPRITES_8x8; 
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;main.c:291: set_sprite_data(0, 95, m_caSprites);
	ld	de, #_m_caSprites
	push	de
	ld	hl, #0x5f00
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:294: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x29
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x87
	inc	hl
	ld	(hl), #0x22
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x2a
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x87
	inc	hl
	ld	(hl), #0x2c
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x2b
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x87
	inc	hl
	ld	(hl), #0x36
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x2c
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x87
	inc	hl
	ld	(hl), #0x40
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x2c
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x87
	inc	hl
	ld	(hl), #0x4a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 30)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x2c
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x87
	ld	(hl+), a
	ld	(hl), #0x5e
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x2d
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x87
	ld	(hl+), a
	ld	(hl), #0x68
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 38)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x2e
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x87
	ld	(hl+), a
	ld	(hl), #0x72
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 42)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x2a
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x87
	ld	(hl+), a
	ld	(hl), #0x7c
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 46)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x2d
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x87
	ld	(hl+), a
	ld	(hl), #0x86
;main.c:310: waitpad(J_START);
	ld	a, #0x80
	call	_waitpad
;main.c:313: hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
	ld	a,#0x01
	ld	e,a
	call	_hUGE_mute_channel
;main.c:318: for(i = 0; i < 12; i++) 
	ld	c, #0x00
00124$:
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	(hl), #0x00
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:318: for(i = 0; i < 12; i++) 
	inc	c
	ld	a, c
	sub	a, #0x0c
	jr	C, 00124$
;main.c:326: NR10_REG = 0x78;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
;main.c:327: NR11_REG = 0x82;
	ld	a, #0x82
	ldh	(_NR11_REG + 0), a
;main.c:328: NR12_REG = 0x44;
	ld	a, #0x44
	ldh	(_NR12_REG + 0), a
;main.c:329: NR13_REG = 0x9D;
	ld	a, #0x9d
	ldh	(_NR13_REG + 0), a
;main.c:330: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;main.c:333: PerformantDelay(5);
	ld	a, #0x05
	call	_PerformantDelay
;main.c:336: NR10_REG = 0x78;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
;main.c:337: NR11_REG = 0x82;
	ld	a, #0x82
	ldh	(_NR11_REG + 0), a
;main.c:338: NR12_REG = 0x44;
	ld	a, #0x44
	ldh	(_NR12_REG + 0), a
;main.c:339: NR13_REG = 0x54;
	ld	a, #0x54
	ldh	(_NR13_REG + 0), a
;main.c:340: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;main.c:343: PerformantDelay(3);
	ld	a, #0x03
	call	_PerformantDelay
;main.c:346: NR10_REG = 0x78;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
;main.c:347: NR11_REG = 0x82;
	ld	a, #0x82
	ldh	(_NR11_REG + 0), a
;main.c:348: NR12_REG = 0x44;
	ld	a, #0x44
	ldh	(_NR12_REG + 0), a
;main.c:349: NR13_REG = 0xD6;
	ld	a, #0xd6
	ldh	(_NR13_REG + 0), a
;main.c:350: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;main.c:353: PerformantDelay(10);
	ld	a, #0x0a
	call	_PerformantDelay
;main.c:356: FadeDrawLayer(0, 1, 0xE4, 0x90, 0x40, 0x00, 15);
	ld	a, #0x0f
	push	af
	inc	sp
	ld	hl, #0x40
	push	hl
	ld	hl, #0x90e4
	push	hl
	ld	e, #0x01
	xor	a, a
	call	_FadeDrawLayer
;main.c:357: }
	ret
;main.c:366: void ShowScoreGrade(UINT16 nScore, UINT16 nShotsTaken)
;	---------------------------------
; Function ShowScoreGrade
; ---------------------------------
_ShowScoreGrade::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:369: UINT16 nAccuracy = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
;main.c:372: char cGrade = 'F';
	ld	(hl+), a
;main.c:373: char cPlusMinus = ' ';
	ld	a, #0x46
	ld	(hl+), a
	ld	(hl), #0x20
;main.c:376: if (nShotsTaken != 0)
	ld	a, b
	or	a, c
	jr	Z, 00102$
;main.c:379: nAccuracy = (nScore * 100) / nShotsTaken;
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	call	__divuint
	pop	hl
	push	bc
00102$:
;main.c:383: if (nAccuracy >= 95) { cGrade = 'S'; cPlusMinus = nAccuracy >= 98 ? 'S' : ' ' ; }
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x5f
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00118$
	inc	hl
	ld	a, #0x53
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, #0x62
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00122$
	inc	hl
	inc	hl
	ld	(hl), #0x53
	jp	00119$
00122$:
	ldhl	sp,	#3
	ld	(hl), #0x20
	jp	00119$
00118$:
;main.c:384: else if (nAccuracy >= 90) { cGrade = 'A'; cPlusMinus = nAccuracy >= 93 ? '+' : (nAccuracy <= 91 ? '-' : ' ') ; }
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x5a
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00115$
	inc	hl
	ld	a, #0x41
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, #0x5d
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00124$
	ld	c, #0x2b
	jr	00125$
00124$:
	ldhl	sp,	#0
	ld	a, #0x5b
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	C, 00126$
	ld	c, #0x2d
	jr	00127$
00126$:
	ld	c, #0x20
00127$:
00125$:
	ldhl	sp,	#3
	ld	(hl), c
	jp	00119$
00115$:
;main.c:385: else if (nAccuracy >= 80) { cGrade = 'B'; cPlusMinus = nAccuracy >= 85 ? '+' : (nAccuracy <= 82 ? '-' : ' ') ; }
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x50
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00112$
	inc	hl
	ld	a, #0x42
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, #0x55
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00128$
	ld	c, #0x2b
	jr	00129$
00128$:
	ldhl	sp,	#0
	ld	a, #0x52
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	C, 00130$
	ldhl	sp,	#3
	ld	(hl), #0x2d
	jr	00131$
00130$:
	ldhl	sp,	#3
	ld	(hl), #0x20
00131$:
	ldhl	sp,	#3
	ld	c, (hl)
00129$:
	ldhl	sp,	#3
	ld	(hl), c
	jp	00119$
00112$:
;main.c:386: else if (nAccuracy >= 70) { cGrade = 'C'; cPlusMinus = nAccuracy >= 75 ? '+' : (nAccuracy <= 72 ? '-' : ' ') ; }
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x46
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00109$
	inc	hl
	ld	a, #0x43
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, #0x4b
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00132$
	ld	c, #0x2b
	jr	00133$
00132$:
	ldhl	sp,	#0
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	C, 00134$
	ldhl	sp,	#3
	ld	(hl), #0x2d
	jr	00135$
00134$:
	ldhl	sp,	#3
	ld	(hl), #0x20
00135$:
	ldhl	sp,	#3
	ld	c, (hl)
00133$:
	ldhl	sp,	#3
	ld	(hl), c
	jr	00119$
00109$:
;main.c:387: else if (nAccuracy >= 60) { cGrade = 'D'; cPlusMinus = nAccuracy >= 65 ? '+' : (nAccuracy <= 62 ? '-' : ' ') ; }
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x3c
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00106$
	inc	hl
	ld	a, #0x44
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, #0x41
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00136$
	ld	c, #0x2b
	jr	00137$
00136$:
	ldhl	sp,	#0
	ld	a, #0x3e
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	C, 00138$
	ld	c, #0x2d
	jr	00139$
00138$:
	ld	c, #0x20
00139$:
00137$:
	ldhl	sp,	#3
	ld	(hl), c
	jr	00119$
00106$:
;main.c:388: else if (nAccuracy >= 50) { cGrade = 'E'; cPlusMinus = nAccuracy >= 55 ? '+' : (nAccuracy <= 52 ? '-' : ' ') ; }
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x32
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00119$
	inc	hl
	ld	a, #0x45
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, #0x37
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00140$
	ld	c, #0x2b
	jr	00141$
00140$:
	ldhl	sp,	#0
	ld	a, #0x34
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	C, 00142$
	ldhl	sp,	#3
	ld	(hl), #0x2d
	jr	00143$
00142$:
	ldhl	sp,	#3
	ld	(hl), #0x20
00143$:
	ldhl	sp,	#3
	ld	c, (hl)
00141$:
	ldhl	sp,	#3
	ld	(hl), c
00119$:
;main.c:391: printf("%c%c", cGrade, cPlusMinus);
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
;main.c:392: }
	add	sp, #12
	ret
___str_0:
	.ascii "%c%c"
	.db 0x00
;main.c:397: void DisplayGameOverScreen(void)
;	---------------------------------
; Function DisplayGameOverScreen
; ---------------------------------
_DisplayGameOverScreen::
	add	sp, #-4
;main.c:400: PerformantDelay(10);
	ld	a, #0x0a
	call	_PerformantDelay
;main.c:403: NR41_REG = 0x15; NR42_REG = 0xFF; NR43_REG = 0x73; NR44_REG = 0xC0;
	ld	a, #0x15
	ldh	(_NR41_REG + 0), a
	ld	a, #0xff
	ldh	(_NR42_REG + 0), a
	ld	a, #0x73
	ldh	(_NR43_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
;main.c:406: PerformantDelay(50);
	ld	a, #0x32
	call	_PerformantDelay
;main.c:409: FadeDrawLayer(0, 1, 0xE4, 0x90, 0x40, 0x00, 15);
	ld	a, #0x0f
	push	af
	inc	sp
	ld	hl, #0x40
	push	hl
	ld	hl, #0x90e4
	push	hl
	ld	e, #0x01
	xor	a, a
	call	_FadeDrawLayer
;main.c:413: printf("     GAME  OVER     \n"); printf(" \n"); printf(" \n");
	ld	de, #___str_29
	call	_puts
;main.c:416: PerformantDelay(20);
	ld	a, #0x14
	call	_PerformantDelay
;main.c:417: FadeDrawLayer(0, 1, 0x00, 0x40, 0x90, 0xE4, 1);
	ld	hl, #0x1e4
	push	hl
	ld	hl, #0x9040
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	e, #0x01
	xor	a, a
	call	_FadeDrawLayer
;main.c:422: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84;
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0xb0
	ldh	(_NR13_REG + 0), a
	ld	a, #0x84
	ldh	(_NR14_REG + 0), a
;main.c:423: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:426: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84; 
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0xb0
	ldh	(_NR13_REG + 0), a
	ld	a, #0x84
	ldh	(_NR14_REG + 0), a
;main.c:427: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:430: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x20; NR14_REG = 0x83; 
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0x20
	ldh	(_NR13_REG + 0), a
	ld	a, #0x83
	ldh	(_NR14_REG + 0), a
;main.c:431: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:434: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x20; NR14_REG = 0x83;
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0x20
	ldh	(_NR13_REG + 0), a
	ld	a, #0x83
	ldh	(_NR14_REG + 0), a
;main.c:435: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:438: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x78; NR14_REG = 0x85; 
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0x78
	ldh	(_NR13_REG + 0), a
	ld	a, #0x85
	ldh	(_NR14_REG + 0), a
;main.c:439: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:442: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0xB0; NR14_REG = 0x84;
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0xb0
	ldh	(_NR13_REG + 0), a
	ld	a, #0x84
	ldh	(_NR14_REG + 0), a
;main.c:443: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:446: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x90; NR14_REG = 0x81;
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0x90
	ldh	(_NR13_REG + 0), a
	ld	a, #0x81
	ldh	(_NR14_REG + 0), a
;main.c:447: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:450: NR10_REG = 0x7C; NR11_REG = 0xC5; NR12_REG = 0x53; NR13_REG = 0x78; NR14_REG = 0x85;
	ld	a, #0x7c
	ldh	(_NR10_REG + 0), a
	ld	a, #0xc5
	ldh	(_NR11_REG + 0), a
	ld	a, #0x53
	ldh	(_NR12_REG + 0), a
	ld	a, #0x78
	ldh	(_NR13_REG + 0), a
	ld	a, #0x85
	ldh	(_NR14_REG + 0), a
;main.c:451: PerformantDelay(60);
	ld	a, #0x3c
	call	_PerformantDelay
;main.c:454: FadeDrawLayer(1, 1, 0xE4, 0x90, 0x40, 0x00, 15);
	ld	a, #0x0f
	push	af
	inc	sp
	ld	hl, #0x40
	push	hl
	ld	hl, #0x90e4
	push	hl
	ld	a,#0x01
	ld	e,a
	call	_FadeDrawLayer
;main.c:455: PerformantDelay(2);
	ld	a, #0x02
	call	_PerformantDelay
;main.c:456: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;main.c:459: PerformantDelay(100);
	ld	a, #0x64
	call	_PerformantDelay
;main.c:464: printf("     SCORE:");
	ld	de, #___str_10
	push	de
	call	_printf
	pop	hl
;main.c:469: m_oPlayer.nScore % 10);
	ld	hl, #(_m_oPlayer + 20)
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	bc, #0x000a
	ld	e, l
	ld	d, h
;main.c:468: (m_oPlayer.nScore / 100) % 10, (m_oPlayer.nScore / 10) % 10, 
	call	__moduint
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	hl
	push	hl
	ld	bc, #0x000a
	ld	e, l
	ld	d, h
	call	__divuint
	ld	e, c
	ld	d, b
	ld	bc, #0x000a
	call	__moduint
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	hl
	push	hl
	ld	bc, #0x0064
	ld	e, l
	ld	d, h
	call	__divuint
	ld	e, c
	ld	d, b
	ld	bc, #0x000a
;main.c:467: printf("%u%u%u%u     ", m_oPlayer.nScore / 1000, 
	call	__moduint
	ld	e, c
	ld	d, b
	pop	hl
	push	de
	ld	bc, #0x03e8
	ld	e, l
	ld	d, h
	call	__divuint
	pop	de
	pop	hl
	push	hl
	push	hl
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	push	bc
	ld	de, #___str_11
	push	de
	call	_printf
	add	sp, #10
;main.c:478: printf(" \n"); printf(" \n"); printf(" \n");
	ld	de, #___str_25
	call	_puts
;main.c:479: printf("    HIGH  SCORE: ");printf(" \n");printf(" \n");
	ld	de, #___str_15
	push	de
	call	_printf
	pop	hl
	ld	de, #___str_24
	call	_puts
;main.c:484: m_nLoadedScore % 10);
	ld	bc, #0x000a
	ld	a, (_m_nLoadedScore)
	ld	e, a
	ld	hl, #_m_nLoadedScore + 1
	ld	d, (hl)
;main.c:483: (m_nLoadedScore / 100) % 10, (m_nLoadedScore / 10) % 10, 
	call	__moduint
	pop	hl
	push	bc
	ld	bc, #0x000a
	ld	a, (_m_nLoadedScore)
	ld	e, a
	ld	hl, #_m_nLoadedScore + 1
	ld	d, (hl)
	call	__divuint
	ld	e, c
	ld	d, b
	ld	bc, #0x000a
	call	__moduint
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	bc, #0x0064
	ld	a, (_m_nLoadedScore)
	ld	e, a
	ld	hl, #_m_nLoadedScore + 1
	ld	d, (hl)
	call	__divuint
	ld	e, c
	ld	d, b
	ld	bc, #0x000a
;main.c:482: printf("        %u%u%u%u  ", m_nLoadedScore / 1000, 
	call	__moduint
	push	bc
	ld	bc, #0x03e8
	ld	a, (_m_nLoadedScore)
	ld	e, a
	ld	hl, #_m_nLoadedScore + 1
	ld	d, (hl)
	call	__divuint
	pop	de
	pop	hl
	push	hl
	push	hl
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	push	bc
	ld	de, #___str_18
	push	de
	call	_printf
	add	sp, #10
;main.c:491: printf("    PRESS  START     \n");
	ld	de, #___str_31
	call	_puts
;main.c:494: waitpad(J_START);
	ld	a, #0x80
	call	_waitpad
;main.c:497: NR41_REG = 0x13;
	ld	a, #0x13
	ldh	(_NR41_REG + 0), a
;main.c:498: NR42_REG = 0x35;
	ld	a, #0x35
	ldh	(_NR42_REG + 0), a
;main.c:499: NR43_REG = 0x28;
	ld	a, #0x28
	ldh	(_NR43_REG + 0), a
;main.c:500: NR44_REG = 0xC0;
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
;main.c:503: PerformantDelay(15);
	ld	a, #0x0f
	call	_PerformantDelay
;main.c:506: reset();
	call	_reset
;main.c:507: }
	add	sp, #4
	ret
___str_10:
	.ascii "     SCORE:"
	.db 0x00
___str_11:
	.ascii "%u%u%u%u     "
	.db 0x00
___str_15:
	.ascii "    HIGH  SCORE: "
	.db 0x00
___str_18:
	.ascii "        %u%u%u%u  "
	.db 0x00
___str_24:
	.ascii " "
	.db 0x0a
	.ascii " "
	.db 0x00
___str_25:
	.ascii " "
	.db 0x0a
	.ascii " "
	.db 0x0a
	.ascii " "
	.db 0x00
___str_29:
	.ascii " "
	.db 0x0a
	.ascii " "
	.db 0x0a
	.ascii " "
	.db 0x0a
	.ascii " "
	.db 0x0a
	.ascii "     GAME  OVER     "
	.db 0x0a
	.ascii " "
	.db 0x0a
	.ascii " "
	.db 0x00
___str_31:
	.ascii "      "
	.db 0x0a
	.ascii " "
	.db 0x0a
	.ascii "    PRESS  START     "
	.db 0x00
;main.c:512: void LoadHighScoreData(void) 
;	---------------------------------
; Function LoadHighScoreData
; ---------------------------------
_LoadHighScoreData::
	add	sp, #-4
;main.c:515: UINT16 nLoadedScore = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
;main.c:516: UINT16 nLoadedShotsTaken = 0;
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:519: LoadGameData(&nLoadedScore, &nLoadedShotsTaken);
	ldhl	sp,	#2
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	e, l
	ld	d, h
	call	_LoadGameData
;main.c:522: m_nLoadedScore = nLoadedScore;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_m_nLoadedScore),a
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(#_m_nLoadedScore + 1),a
;main.c:523: m_nLoadedShotsTaken = nLoadedShotsTaken;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_m_nLoadedShotsTaken),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_m_nLoadedShotsTaken + 1),a
;main.c:524: }
	add	sp, #4
	ret
;main.c:529: void Initialize(void)
;	---------------------------------
; Function Initialize
; ---------------------------------
_Initialize::
;main.c:536: NR52_REG = 0x80; // Turn on the sound.
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:537: NR50_REG = 0x77; // Set the volume of the left and right channel
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:538: NR51_REG = 0xFF; // Set usage to both channels
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:541: LoadHighScoreData();
	call	_LoadHighScoreData
;main.c:544: DisplaySplashScreen();
	call	_DisplaySplashScreen
;main.c:547: DisplayStartScreen();
	call	_DisplayStartScreen
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x57
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x69
	inc	hl
	ld	(hl), #0x36
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x58
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x69
	inc	hl
	ld	(hl), #0x40
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), #0x59
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x69
	inc	hl
	ld	(hl), #0x4a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 38)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x5a
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x54
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 42)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x5b
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x5e
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 46)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x5c
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x68
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 50)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x5d
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x72
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 54)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x5e
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x69
	ld	(hl+), a
	ld	(hl), #0x7c
;main.c:562: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;main.c:565: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;main.c:568: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:571: initrand(DIV_REG | (LY_REG << 8));
	ldh	a, (_LY_REG + 0)
	ld	b, a
	ldh	a, (_DIV_REG + 0)
	ld	c, a
	push	bc
	call	_initrand
	pop	hl
;main.c:574: InitPlayer(&m_oPlayer);
	ld	de, #_m_oPlayer+0
	push	de
	call	_InitPlayer
	pop	de
;main.c:575: UpdatePlayer(&m_oPlayer);
	call	_UpdatePlayer
;main.c:576: InitHud();
	call	_InitHud
;main.c:579: for(i = 0; i < MAX_ENEMIES; i++) 
	ld	c, #0x00
00121$:
;main.c:581: InitEnemy(i);
	push	bc
	ld	a, c
	call	_InitEnemy
	pop	bc
;main.c:579: for(i = 0; i < MAX_ENEMIES; i++) 
	inc	c
	ld	a, c
	sub	a, #0x10
	jr	C, 00121$
;main.c:585: InitEnemiesSpawnQueue();
	call	_InitEnemiesSpawnQueue
;main.c:588: m_nPrevJoy = 0;
	xor	a, a
	ld	(#_m_nPrevJoy),a
;main.c:593: for(i = 5; i < 14; i++) 
	ld	c, #0x05
00123$:
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	(hl), #0x00
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:593: for(i = 5; i < 14; i++) 
	inc	c
	ld	a, c
	sub	a, #0x0e
	jr	C, 00123$
;main.c:600: set_bkg_data(0, 127, m_caBgTiles);
	ld	de, #_m_caBgTiles
	push	de
	ld	hl, #0x7f00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:601: set_bkg_tiles(0, 0, 20, 18, m_caBackground);
	ld	de, #_m_caBackground
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:604: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:605: FadeDrawLayer(0, 0, 0x00, 0x40, 0x90, 0xE4, 8);
	ld	hl, #0x8e4
	push	hl
	ld	hl, #0x9040
	push	hl
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	e, a
	call	_FadeDrawLayer
;main.c:608: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;main.c:609: }
	ret
;main.c:614: void main(void) 
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-13
;main.c:626: BOOLEAN bPaused = FALSE;
	ldhl	sp,	#0
	ld	(hl), #0x00
;main.c:627: UINT8 nBlinkTimer = 0;
	ldhl	sp,	#12
	ld	(hl), #0x00
;main.c:628: UINT8 nBlinkState = 0;  
	ldhl	sp,	#1
	ld	(hl), #0x00
;main.c:632: Initialize();
	call	_Initialize
;main.c:635: while(1) 
00135$:
;main.c:638: if (m_oPlayer.nHealth == 0)
	ld	hl, #(_m_oPlayer + 17)
	ld	a, (hl+)
;main.c:650: if (m_oPlayer.nScore > m_nLoadedScore) 
;main.c:638: if (m_oPlayer.nHealth == 0)
	or	a, (hl)
	jr	NZ, 00104$
;main.c:641: hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
	ld	e, #0x01
	xor	a, a
	call	_hUGE_mute_channel
;main.c:642: hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
	ld	a,#0x01
	ld	e,a
	call	_hUGE_mute_channel
;main.c:643: hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
	ld	e, #0x01
	ld	a, #0x02
	call	_hUGE_mute_channel
;main.c:647: SetHealth(0);
	ld	de, #0x0000
	call	_SetHealth
;main.c:650: if (m_oPlayer.nScore > m_nLoadedScore) 
	ld	de, #(_m_oPlayer + 20)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	de, #_m_nLoadedScore
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00102$
;main.c:653: SaveGameData(m_oPlayer.nScore, m_oPlayer.nTotalShotsTaken);
	ld	hl, #_m_oPlayer + 22
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SaveGameData
;main.c:654: LoadHighScoreData();
	call	_LoadHighScoreData
00102$:
;main.c:658: DisplayGameOverScreen();
	call	_DisplayGameOverScreen
00104$:
;main.c:662: m_nJoy = joypad();
	call	_joypad
	ld	hl, #_m_nJoy
	ld	(hl), a
;main.c:665: if ((m_nJoy & J_START) && !(m_nPrevJoy & J_START))
	ld	a, (hl)
	rlca
	jp	NC, 00109$
	ld	a, (_m_nPrevJoy)
	rlca
	jp	C, 00109$
;main.c:670: NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0xD6; NR14_REG = 0x86;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
	ld	a, #0x82
	ldh	(_NR11_REG + 0), a
	ld	a, #0x44
	ldh	(_NR12_REG + 0), a
	ld	a, #0xd6
	ldh	(_NR13_REG + 0), a
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;main.c:671: PerformantDelay(3);
	ld	a, #0x03
	call	_PerformantDelay
;main.c:674: NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x54; NR14_REG = 0x86;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
	ld	a, #0x82
	ldh	(_NR11_REG + 0), a
	ld	a, #0x44
	ldh	(_NR12_REG + 0), a
	ld	a, #0x54
	ldh	(_NR13_REG + 0), a
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;main.c:675: PerformantDelay(3);
	ld	a, #0x03
	call	_PerformantDelay
;main.c:678: NR10_REG = 0x78; NR11_REG = 0x82; NR12_REG = 0x44; NR13_REG = 0x9D; NR14_REG = 0x86;
	ld	a, #0x78
	ldh	(_NR10_REG + 0), a
	ld	a, #0x82
	ldh	(_NR11_REG + 0), a
	ld	a, #0x44
	ldh	(_NR12_REG + 0), a
	ld	a, #0x9d
	ldh	(_NR13_REG + 0), a
	ld	a, #0x86
	ldh	(_NR14_REG + 0), a
;main.c:681: bPaused = !bPaused;
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;main.c:682: nBlinkTimer = 0;
	ldhl	sp,	#12
	ld	(hl), #0x00
;main.c:683: nBlinkState = 0;
	ldhl	sp,	#1
;main.c:684: BGP_REG = 0xE4;
;main.c:687: if (bPaused)
	xor	a, a
	ld	(hl-), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
;main.c:689: hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
	ld	e, #0x01
	xor	a, a
	call	_hUGE_mute_channel
;main.c:690: hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
	ld	e, #0x01
	ld	a, #0x02
	call	_hUGE_mute_channel
;main.c:691: hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
	ld	e, #0x01
	ld	a, #0x03
	call	_hUGE_mute_channel
	jr	00109$
00106$:
;main.c:695: hUGE_mute_channel(HT_CH1, HT_CH_PLAY);
	xor	a, a
	ld	e, a
	call	_hUGE_mute_channel
;main.c:696: hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
	ld	e, #0x00
	ld	a, #0x02
	call	_hUGE_mute_channel
;main.c:697: hUGE_mute_channel(HT_CH4, HT_CH_PLAY);
	ld	e, #0x00
	ld	a, #0x03
	call	_hUGE_mute_channel
00109$:
;main.c:702: if (!bPaused)
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jp	NZ, 00132$
;main.c:705: HandlePlayerInput(&m_oPlayer, m_nJoy);
	ld	a, (_m_nJoy)
	ld	de, #_m_oPlayer
	call	_HandlePlayerInput
;main.c:708: TickSpawnTimer();
	call	_TickSpawnTimer
;main.c:711: if (m_nSpawnTimer <= 0) 
	ld	a, (#_m_nSpawnTimer)
	or	a, a
	jr	NZ, 00154$
;main.c:714: SpawnNext();
	call	_SpawnNext
;main.c:717: m_nSpawnTimer = m_nSpawnDelay;
	ld	a, (#_m_nSpawnDelay)
	ld	(#_m_nSpawnTimer),a
;main.c:721: for (o = 0; o < MAX_ENEMIES; o++) 
00154$:
	ldhl	sp,	#11
	ld	(hl), #0x00
00137$:
;main.c:724: if (IsEnemyAlive(o)) 
	ldhl	sp,	#11
	ld	a, (hl)
	call	_IsEnemyAlive
	or	a, a
	jr	Z, 00138$
;main.c:727: UpdateEnemy(o, &m_oPlayer);
	ld	de, #_m_oPlayer
	ldhl	sp,	#11
	ld	a, (hl)
	call	_UpdateEnemy
00138$:
;main.c:721: for (o = 0; o < MAX_ENEMIES; o++) 
	ldhl	sp,	#11
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00137$
;main.c:732: IncreaseDifficulty(m_nDamgeToPlayer);
	ld	a, (_m_nDamgeToPlayer)
	call	_IncreaseDifficulty
;main.c:735: ShowSprayEffect(m_bShowSpray);
	ld	a, (_m_bShowSpray)
	call	_ShowSprayEffect
;main.c:739: if (m_bPlayKillSoundEffect && !m_oPlayer.bTakenDamage)
	ld	a, (#_m_bPlayKillSoundEffect)
	or	a, a
	jr	Z, 00117$
	ld	a, (#(_m_oPlayer + 24) + 0)
	or	a, a
	jr	NZ, 00117$
;main.c:741: hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
	ld	e, #0x01
	ld	a, #0x02
	call	_hUGE_mute_channel
;main.c:744: NR21_REG = 0x84;
	ld	a, #0x84
	ldh	(_NR21_REG + 0), a
;main.c:745: NR22_REG = 0x26;
	ld	a, #0x26
	ldh	(_NR22_REG + 0), a
;main.c:746: NR23_REG = 0x2D;
	ld	a, #0x2d
	ldh	(_NR23_REG + 0), a
;main.c:747: NR24_REG = 0x81;
	ld	a, #0x81
	ldh	(_NR24_REG + 0), a
;main.c:749: NR41_REG = 0x05;
	ld	a, #0x05
	ldh	(_NR41_REG + 0), a
;main.c:750: NR41_REG = 0xA7;
	ld	a, #0xa7
	ldh	(_NR41_REG + 0), a
;main.c:751: NR41_REG = 0xC0;
	ld	a, #0xc0
	ldh	(_NR41_REG + 0), a
;main.c:752: NR41_REG = 0xC0;
	ld	a, #0xc0
	ldh	(_NR41_REG + 0), a
;main.c:754: hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
	ld	e, #0x00
	ld	a, #0x02
	call	_hUGE_mute_channel
;main.c:757: m_bPlayKillSoundEffect = FALSE;
;main.c:760: m_bShowSpray = FALSE;
	xor	a, a
	ld	(#_m_bPlayKillSoundEffect), a
	ld	(#_m_bShowSpray),a
00117$:
;main.c:764: nCurrentHealth = m_oPlayer.nHealth / 10;
	ld	de, #(_m_oPlayer + 17)
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	bc, #0x000a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;main.c:765: nCurrentScore = m_oPlayer.nScore;
	call	__divuint
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	de, #(_m_oPlayer + 20)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;main.c:768: if (m_oPlayer.bTakenDamage)
	ld	a, (#(_m_oPlayer + 24) + 0)
	or	a, a
	jr	Z, 00120$
;main.c:772: m_oPlayer.nHealth = (m_oPlayer.nHealth < m_nDamgeToPlayer || 
	ld	bc, #(_m_oPlayer + 17)
	ld	a, (_m_nDamgeToPlayer)
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	C, 00144$
;main.c:773: m_oPlayer.nHealth > 999) ? 0 : m_oPlayer.nHealth - m_nDamgeToPlayer;
	dec	hl
	ld	a, #0xe7
	sub	a, (hl)
	inc	hl
	ld	a, #0x03
	sbc	a, (hl)
	jr	NC, 00141$
00144$:
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
	jr	00142$
00141$:
	ld	a, (_m_nDamgeToPlayer)
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
00142$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:775: hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
	ld	e, #0x01
	ld	a, #0x02
	call	_hUGE_mute_channel
;main.c:778: NR10_REG = 0x0D;
	ld	a, #0x0d
	ldh	(_NR10_REG + 0), a
;main.c:779: NR11_REG = 0xC2;
	ld	a, #0xc2
	ldh	(_NR11_REG + 0), a
;main.c:780: NR12_REG = 0x54;
	ld	a, #0x54
	ldh	(_NR12_REG + 0), a
;main.c:781: NR13_REG = 0x63;
	ld	a, #0x63
	ldh	(_NR13_REG + 0), a
;main.c:782: NR14_REG = 0x82;
	ld	a, #0x82
	ldh	(_NR14_REG + 0), a
;main.c:784: hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
	ld	e, #0x00
	ld	a, #0x02
	call	_hUGE_mute_channel
;main.c:787: m_oPlayer.bTakenDamage = FALSE;
	ld	hl, #(_m_oPlayer + 24)
	ld	(hl), #0x00
00120$:
;main.c:791: if (nCurrentHealth != m_nPrevHealth)
	ld	a, (#_m_nPrevHealth)
	ldhl	sp,	#4
	sub	a, (hl)
	jr	NZ, 00298$
	ld	a, (#_m_nPrevHealth + 1)
	ldhl	sp,	#5
	sub	a, (hl)
	jr	Z, 00122$
00298$:
;main.c:794: SetHealth(nCurrentHealth);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetHealth
;main.c:797: m_nPrevHealth = nCurrentHealth;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(#_m_nPrevHealth),a
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(#_m_nPrevHealth + 1),a
00122$:
;main.c:801: if (nCurrentScore != m_nPrevScore) 
	ld	a, (#_m_nPrevScore)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NZ, 00299$
	ld	a, (#_m_nPrevScore + 1)
	ldhl	sp,	#7
	sub	a, (hl)
	jr	Z, 00133$
00299$:
;main.c:804: SetScore(nCurrentScore);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetScore
;main.c:807: m_nPrevScore = nCurrentScore;
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(#_m_nPrevScore),a
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_m_nPrevScore + 1),a
	jr	00133$
00132$:
;main.c:815: nBlinkTimer++;
	ldhl	sp,	#12
	inc	(hl)
;main.c:817: if (nBlinkTimer >= 20) 
	ld	a, (hl)
	sub	a, #0x14
	jr	C, 00133$
;main.c:819: nBlinkTimer = 0;
	ld	(hl), #0x00
;main.c:820: nBlinkState = (nBlinkState + 1) % 3;
	ldhl	sp,	#1
	ld	a, (hl)
	inc	a
	ld	e, #0x03
	call	__moduchar
	ldhl	sp,	#1
	ld	(hl), c
;main.c:822: switch(nBlinkState) 
	ld	a, (hl)
	or	a, a
	jr	Z, 00125$
	ldhl	sp,	#1
	ld	a, (hl)
	dec	a
	jr	Z, 00126$
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00127$
	jr	00133$
;main.c:824: case 0: BGP_REG = 0xE4; break;  // Normal
00125$:
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
	jr	00133$
;main.c:825: case 1: BGP_REG = 0xB0; break;  // Dims
00126$:
	ld	a, #0xb0
	ldh	(_BGP_REG + 0), a
	jr	00133$
;main.c:826: case 2: BGP_REG = 0xE4; break;  // Normal
00127$:
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;main.c:827: }
00133$:
;main.c:832: m_nPrevJoy = m_nJoy;
	ld	a, (#_m_nJoy)
	ld	(#_m_nPrevJoy),a
;main.c:836: wait_vbl_done();
	call	_wait_vbl_done
	jp	00135$
;main.c:838: }
	add	sp, #13
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__m_nPrevHealth:
	.dw #0x270f
__xinit__m_nPrevScore:
	.dw #0x270f
__xinit__m_nLoadedScore:
	.dw #0x0000
__xinit__m_nLoadedShotsTaken:
	.dw #0x0000
__xinit__m_nDamgeToPlayer:
	.db #0x19	; 25
	.area _CABS (ABS)
