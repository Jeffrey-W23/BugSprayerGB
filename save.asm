;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module save
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SaveGameData
	.globl _LoadGameData
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_SaveGameData_highScore_10000_129:
	.ds 2
_SaveGameData_savedShots_10000_129:
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;save.c:26: static UINT16 highScore = 0;
	xor	a, a
	ld	hl, #_SaveGameData_highScore_10000_129
	ld	(hl+), a
	ld	(hl), a
;save.c:27: static UINT16 savedShots = 0;
	xor	a, a
	ld	hl, #_SaveGameData_savedShots_10000_129
	ld	(hl+), a
	ld	(hl), a
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;save.c:23: void SaveGameData(UINT16 nScore, UINT16 nShotsTaken) 
;	---------------------------------
; Function SaveGameData
; ---------------------------------
_SaveGameData::
;save.c:30: if (nScore > highScore || nShotsTaken != savedShots) 
	ld	hl, #_SaveGameData_highScore_10000_129
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	C, 00101$
	ld	hl, #_SaveGameData_savedShots_10000_129
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00113$
	inc	hl
	ld	a, (hl)
	sub	a, b
	ret	Z
00113$:
00101$:
;save.c:32: highScore = nScore;
	ld	hl, #_SaveGameData_highScore_10000_129
	ld	(hl), e
	inc	hl
	ld	(hl), d
;save.c:33: savedShots = nShotsTaken;
	ld	hl, #_SaveGameData_savedShots_10000_129
	ld	(hl), c
	inc	hl
	ld	(hl), b
;save.c:36: *((volatile UINT8*)0x0000) = 0x0A;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;save.c:40: sram[0] = SAVE_MAGIC;    // magic number
	ld	h, #0xa0
	ld	a, #0xaa
	ld	(hl+), a
	ld	(hl), #0x55
;save.c:41: sram[1] = highScore;     // high score
	ld	de, #0xa002
	ld	a, (_SaveGameData_highScore_10000_129)
	ld	(de), a
	inc	de
	ld	a, (_SaveGameData_highScore_10000_129 + 1)
	ld	(de), a
;save.c:42: sram[2] = savedShots;    // shots taken
	ld	de, #0xa004
	ld	a, (_SaveGameData_savedShots_10000_129)
	ld	(de), a
	inc	de
	ld	a, (_SaveGameData_savedShots_10000_129 + 1)
	ld	(de), a
;save.c:45: *((volatile UINT8*)0x0000) = 0x00;
	ld	h, l
	ld	(hl), #0x00
;save.c:47: }
	ret
;save.c:56: void LoadGameData(UINT16* nScore, UINT16* nShotsTaken)
;	---------------------------------
; Function LoadGameData
; ---------------------------------
_LoadGameData::
	add	sp, #-4
	ldhl	sp,	#2
	ld	(hl), e
	inc	hl
	ld	(hl), d
;save.c:59: *((volatile UINT8*)0x0000) = 0x0A;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;save.c:63: if (sram[0] == SAVE_MAGIC) 
	ld	h, #0xa0
	ld	a,	(hl+)
	ld	h, (hl)
	sub	a, #0xaa
	jr	NZ, 00102$
	ld	a, h
	sub	a, #0x55
	jr	NZ, 00102$
;save.c:66: *nScore = sram[1];
	ld	de, #0xa002
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;save.c:67: *nShotsTaken = sram[2];
	ld	hl, #0xa004
	ld	a,	(hl+)
	ld	h, (hl)
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00103$
00102$:
;save.c:74: *nScore = 0;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;save.c:75: *nShotsTaken = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;save.c:76: sram[0] = SAVE_MAGIC;
	ld	hl, #0xa000
	ld	a, #0xaa
	ld	(hl+), a
	ld	(hl), #0x55
;save.c:77: sram[1] = 0;
	ld	l, #0x02
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;save.c:78: sram[2] = 0;
	ld	l, #0x04
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00103$:
;save.c:82: *((volatile UINT8*)0x0000) = 0x00;
	ld	hl, #0x0000
	ld	(hl), #0x00
;save.c:83: }
	add	sp, #4
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
