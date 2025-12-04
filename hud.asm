;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module hud
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_bkg_tiles
	.globl _InitHud
	.globl _SetHealth
	.globl _SetScore
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_m_nCurrentHealth:
	.ds 2
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
;hud.c:31: void InitHud(void) 
;	---------------------------------
; Function InitHud
; ---------------------------------
_InitHud::
;hud.c:34: m_nCurrentHealth = 998;
	ld	hl, #_m_nCurrentHealth
	ld	a, #0xe6
	ld	(hl+), a
;hud.c:35: SetHealth(998);
	ld	de, #0x03e6
	ld	(hl), d
	call	_SetHealth
;hud.c:36: SetScore(0);
	ld	de, #0x0000
;hud.c:37: }
	jp	_SetScore
;hud.c:45: void SetHealth(UINT16 nHealth) 
;	---------------------------------
; Function SetHealth
; ---------------------------------
_SetHealth::
	add	sp, #-6
;hud.c:48: UINT8 tens = (nHealth / 10) % 10;
	push	de
	ld	bc, #0x000a
	call	__divuint
	ld	l, c
	ld	h, b
	ld	bc, #0x000a
	ld	e, l
	ld	d, h
	call	__moduint
	pop	de
	ldhl	sp,	#5
	ld	(hl), c
;hud.c:49: UINT8 ones = nHealth % 10;
	ld	bc, #0x000a
	call	__moduint
;hud.c:55: tiles[0] = TILE_H;
	ldhl	sp,	#0
;hud.c:56: tiles[1] = TILE_P;
	ld	a, #0x54
	ld	(hl+), a
;hud.c:57: tiles[2] = TILE_COLON;
	ld	a, #0x55
	ld	(hl+), a
	ld	(hl), #0x56
;hud.c:58: tiles[3] = TILE_0 + tens;
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	add	a, #0x4a
;hud.c:59: tiles[4] = TILE_0 + ones;
	ld	(hl+), a
	ld	a, c
	add	a, #0x4a
	ld	(hl), a
;hud.c:62: set_bkg_tiles(1, 17, 5, 1, tiles);
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x105
	push	hl
	ld	hl, #0x1101
	push	hl
	call	_set_bkg_tiles
;hud.c:63: }
	add	sp, #12
	ret
;hud.c:71: void SetScore(UINT16 nScore) 
;	---------------------------------
; Function SetScore
; ---------------------------------
_SetScore::
	add	sp, #-15
	ldhl	sp,	#13
	ld	a, e
	ld	(hl+), a
;hud.c:74: UINT8 thousands = (nScore / 1000) % 10;
	ld	a, d
	ld	(hl-), a
	ld	bc, #0x03e8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__divuint
	ld	a, c
	ld	e, #0x0a
	call	__moduchar
	ldhl	sp,	#10
	ld	(hl), c
;hud.c:75: UINT8 hundreds = (nScore / 100) % 10;
	ld	bc, #0x0064
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__divuint
	ld	e, c
	ld	d, b
	ld	bc, #0x000a
	call	__moduint
	ldhl	sp,	#11
;hud.c:76: UINT8 tens = (nScore / 10) % 10;
	ld	a, c
	ld	(hl+), a
	inc	hl
	ld	bc, #0x000a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__divuint
	ld	e, c
	ld	d, b
	ld	bc, #0x000a
	call	__moduint
	ldhl	sp,	#12
;hud.c:77: UINT8 ones = nScore % 10;
	ld	a, c
	ld	(hl+), a
	ld	bc, #0x000a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__moduint
;hud.c:81: tiles[0] = TILE_S;
	ldhl	sp,	#0
;hud.c:82: tiles[1] = TILE_C;
	ld	a, #0x57
	ld	(hl+), a
;hud.c:83: tiles[2] = TILE_O;
	ld	a, #0x58
	ld	(hl+), a
;hud.c:84: tiles[3] = TILE_R;
	ld	a, #0x59
	ld	(hl+), a
;hud.c:85: tiles[4] = TILE_E;
	ld	a, #0x5a
	ld	(hl+), a
;hud.c:86: tiles[5] = TILE_COLON;
	ld	a, #0x5b
	ld	(hl+), a
	ld	(hl), #0x56
;hud.c:87: tiles[6] = TILE_0 + thousands;
	ldhl	sp,	#10
	ld	a, (hl)
	add	a, #0x4a
	ldhl	sp,	#6
	ld	(hl), a
;hud.c:88: tiles[7] = TILE_0 + hundreds;
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, #0x4a
	ldhl	sp,	#7
	ld	(hl), a
;hud.c:89: tiles[8] = TILE_0 + tens;
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, #0x4a
	ldhl	sp,	#8
;hud.c:90: tiles[9] = TILE_0 + ones;
	ld	(hl+), a
	ld	a, c
	add	a, #0x4a
	ld	(hl), a
;hud.c:93: set_bkg_tiles(9, 17, 10, 1, tiles);
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x10a
	push	hl
	ld	hl, #0x1109
	push	hl
	call	_set_bkg_tiles
;hud.c:94: }
	add	sp, #21
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__m_nCurrentHealth:
	.dw #0x03e6
	.area _CABS (ABS)
