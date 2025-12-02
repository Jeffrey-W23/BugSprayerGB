;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module player
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _InitPlayer
	.globl _UpdatePlayer
	.globl _HandlePlayerInput
	.globl _ShowSprayEffect
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
_m_nSprayIndex:
	.ds 1
_m_bButtonBPressed:
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
;player.c:25: void InitPlayer(Player* ptrPlayer) 
;	---------------------------------
; Function InitPlayer
; ---------------------------------
_InitPlayer::
	add	sp, #-13
	ld	c, e
	ld	b, d
;player.c:32: UINT8 nBaseTiles[8] = {0,4,8,12,16,20,24,28};
	ldhl	sp,	#0
	xor	a, a
	ld	(hl+), a
	ld	a, #0x04
	ld	(hl+), a
	ld	a, #0x08
	ld	(hl+), a
	ld	a, #0x0c
	ld	(hl+), a
	ld	a, #0x10
	ld	(hl+), a
	ld	a, #0x14
	ld	(hl+), a
	ld	a, #0x18
	ld	(hl+), a
	ld	(hl), #0x1c
;player.c:35: ptrPlayer->nX = 76; ptrPlayer->nY = 78;                 // X/Y Values
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x4c
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x4e
;player.c:36: ptrPlayer->nWidth = 16; ptrPlayer->nHeight = 16;        // Width/Height
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x10
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x10
;player.c:37: ptrPlayer->nDirection = 0; ptrPlayer->nDirCheck = 4;    // Direction
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0013
	add	hl, bc
	ld	(hl), #0x04
;player.c:38: ptrPlayer->nHealth = 998; ptrPlayer->nScore = 0;        // Health/Score
	ld	hl, #0x0011
	add	hl, bc
	ld	a, #0xe6
	ld	(hl+), a
	ld	(hl), #0x03
	ld	hl, #0x0014
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;player.c:39: ptrPlayer->bTakenDamage = FALSE;                        // Is Hurt
	ld	hl, #0x0018
	add	hl, bc
	ld	(hl), #0x00
;player.c:44: for(i = 0; i < 8; i++) 
	ld	hl, #0x0009
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#12
	ld	(hl), #0x00
00106$:
;player.c:46: ptrPlayer->anTiles[i] = nBaseTiles[i];
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	push	hl
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#10
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;player.c:44: for(i = 0; i < 8; i++) 
	ldhl	sp,	#12
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x08
	jr	C, 00106$
;player.c:50: for(i = 0; i < 4; i++) 
	ld	hl, #0x0009
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl+), a
	ld	(hl), #0x00
00108$:
;player.c:52: ptrPlayer->ubSpriteIDs[i] = i;
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
;player.c:53: set_sprite_tile(ptrPlayer->ubSpriteIDs[i], ptrPlayer->anTiles[0] + i);
	ld	a, (hl-)
	dec	hl
	ld	(de), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, (hl)
	ld	e, a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	d, (hl)
	xor	a, a
	ld	l, d
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), e
;player.c:50: for(i = 0; i < 4; i++) 
	ldhl	sp,	#12
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00108$
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, #0x5f
	ld	(hl-), a
	dec	hl
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x52
	ld	(hl+), a
	ld	(hl), #0x5c
;player.c:59: m_nSprayIndex = 35;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x23
;player.c:60: }
	add	sp, #13
	ret
;player.c:69: void UpdatePlayer(Player* ptrPlayer) 
;	---------------------------------
; Function UpdatePlayer
; ---------------------------------
_UpdatePlayer::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
;player.c:72: UINT8 nTile = ptrPlayer->anTiles[ptrPlayer->nDirection];
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
;player.c:77: move_sprite(ptrPlayer->ubSpriteIDs[0], ptrPlayer->nX, ptrPlayer->nY);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	c, a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(bc), a
;player.c:78: set_sprite_tile(ptrPlayer->ubSpriteIDs[0], nTile);
	ld	a, (de)
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	l, a
	ld	bc, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
;player.c:81: move_sprite(ptrPlayer->ubSpriteIDs[1], ptrPlayer->nX + 8, ptrPlayer->nY);
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	(bc), a
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, #0x08
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ld	b, a
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
;player.c:82: set_sprite_tile(ptrPlayer->ubSpriteIDs[1], nTile + 1);
	ld	a, (hl+)
	ld	(bc), a
	ld	a, (hl-)
	ld	(hl), a
	ld	c, (hl)
	inc	c
	ld	a, (de)
	ld	e, a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;player.c:85: move_sprite(ptrPlayer->ubSpriteIDs[2], ptrPlayer->nX, ptrPlayer->nY + 8);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x08
	ld	c, a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ld	b, a
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
;player.c:86: set_sprite_tile(ptrPlayer->ubSpriteIDs[2], nTile + 2);
	ld	a, (hl-)
	ld	(bc), a
	ld	c, (hl)
	inc	c
	inc	c
	ld	a, (de)
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	l, a
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;player.c:89: move_sprite(ptrPlayer->ubSpriteIDs[3], ptrPlayer->nX + 8, ptrPlayer->nY + 8);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x08
	ld	c, a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	add	a, #0x08
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	b, a
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
;player.c:90: set_sprite_tile(ptrPlayer->ubSpriteIDs[3], nTile + 3);
	ld	a, (hl-)
	ld	(bc), a
	ld	c, (hl)
	inc	c
	inc	c
	inc	c
	ld	a, (de)
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	l, a
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;player.c:90: set_sprite_tile(ptrPlayer->ubSpriteIDs[3], nTile + 3);
;player.c:91: }
	add	sp, #8
	ret
;player.c:100: void HandlePlayerInput(Player* ptrPlayer, UINT8 nJoy) 
;	---------------------------------
; Function HandlePlayerInput
; ---------------------------------
_HandlePlayerInput::
	add	sp, #-11
	ldhl	sp,	#9
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;player.c:107: if ((nJoy & J_RIGHT) && (nJoy & J_DOWN))
	ld	a, (hl)
	and	a, #0x01
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	a, (hl)
	and	a, #0x08
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
;player.c:109: ptrPlayer->nDirection = 1;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
;player.c:110: ptrPlayer->nDirCheck = 7;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	ld	e, l
	ld	d, h
;player.c:107: if ((nJoy & J_RIGHT) && (nJoy & J_DOWN))
	xor	a, a
	ldhl	sp,	#0
	or	a, (hl)
	jr	Z, 00125$
	inc	hl
	inc	hl
	xor	a, a
	or	a, (hl)
	jr	Z, 00125$
;player.c:109: ptrPlayer->nDirection = 1;
	ld	a, #0x01
	ld	(bc), a
;player.c:110: ptrPlayer->nDirCheck = 7;
	ld	a, #0x07
	ld	(de), a
;player.c:111: m_nSprayIndex = 36;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x24
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x5c
	inc	hl
	ld	(hl), #0x5a
;player.c:112: move_sprite(5, 90, 92);
	jp	00126$
00125$:
;player.c:116: else if ((nJoy & J_DOWN) && (nJoy & J_LEFT))
	ldhl	sp,	#8
	ld	a, (hl)
	and	a, #0x02
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	xor	a, a
	ldhl	sp,	#2
	or	a, (hl)
	jr	Z, 00121$
	inc	hl
	inc	hl
	xor	a, a
	or	a, (hl)
	jr	Z, 00121$
;player.c:118: ptrPlayer->nDirection = 3;
	ld	a, #0x03
	ld	(bc), a
;player.c:119: ptrPlayer->nDirCheck = 5;
	ld	a, #0x05
	ld	(de), a
;player.c:120: m_nSprayIndex = 38;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x26
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x5c
	ld	(hl+), a
	ld	(hl), #0x46
;player.c:121: move_sprite(5, 70, 92);
	jp	00126$
00121$:
;player.c:125: else if ((nJoy & J_LEFT) && (nJoy & J_UP))
	ldhl	sp,	#8
	ld	a, (hl-)
	dec	hl
	and	a, #0x04
	ld	(hl+), a
	ld	(hl), #0x00
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00117$
	inc	hl
	inc	hl
	xor	a, a
	or	a, (hl)
	jr	Z, 00117$
;player.c:127: ptrPlayer->nDirection = 5;
	ld	a, #0x05
	ld	(bc), a
;player.c:128: ptrPlayer->nDirCheck = 0;
	xor	a, a
	ld	(de), a
;player.c:129: m_nSprayIndex = 40;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x28
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x48
	ld	(hl+), a
	ld	(hl), #0x46
;player.c:130: move_sprite(5, 70, 72);
	jp	00126$
00117$:
;player.c:134: else if ((nJoy & J_RIGHT) && (nJoy & J_UP))
	xor	a, a
	ldhl	sp,	#0
	or	a, (hl)
	jr	Z, 00113$
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00113$
;player.c:136: ptrPlayer->nDirection = 7;
	ld	a, #0x07
	ld	(bc), a
;player.c:137: ptrPlayer->nDirCheck = 2;
	ld	a, #0x02
	ld	(de), a
;player.c:138: m_nSprayIndex = 34;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x22
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), #0x48
	inc	hl
	ld	(hl), #0x5a
;player.c:139: move_sprite(5, 90, 72);
	jr	00126$
00113$:
;player.c:143: else if (nJoy & J_RIGHT)
	xor	a, a
	ldhl	sp,	#0
	or	a, (hl)
	jr	Z, 00110$
;player.c:145: ptrPlayer->nDirection = 0;
	xor	a, a
	ld	(bc), a
;player.c:146: ptrPlayer->nDirCheck = 4;
	ld	a, #0x04
	ld	(de), a
;player.c:147: m_nSprayIndex = 35;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x23
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x52
	ld	(hl+), a
	ld	(hl), #0x5c
;player.c:148: move_sprite(5, 92, 82);
	jr	00126$
00110$:
;player.c:152: else if (nJoy & J_DOWN)
	xor	a, a
	ldhl	sp,	#2
	or	a, (hl)
	jr	Z, 00107$
;player.c:154: ptrPlayer->nDirection = 2;
	ld	a, #0x02
	ld	(bc), a
;player.c:155: ptrPlayer->nDirCheck = 6;
	ld	a, #0x06
	ld	(de), a
;player.c:156: m_nSprayIndex = 37;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x25
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x5e
	ld	(hl+), a
	ld	(hl), #0x50
;player.c:157: move_sprite(5, 80, 94);
	jr	00126$
00107$:
;player.c:161: else if (nJoy & J_LEFT)
	xor	a, a
	ldhl	sp,	#4
	or	a, (hl)
	jr	Z, 00104$
;player.c:163: ptrPlayer->nDirection = 4;
	ld	a, #0x04
	ld	(bc), a
;player.c:164: ptrPlayer->nDirCheck = 3;
	ld	a, #0x03
	ld	(de), a
;player.c:165: m_nSprayIndex = 39;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x27
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x52
	ld	(hl+), a
	ld	(hl), #0x44
;player.c:166: move_sprite(5, 68, 82);
	jr	00126$
00104$:
;player.c:171: else if (nJoy & J_UP)
	xor	a, a
	ldhl	sp,	#6
	or	a, (hl)
	jr	Z, 00126$
;player.c:173: ptrPlayer->nDirection = 6;
	ld	a, #0x06
	ld	(bc), a
;player.c:174: ptrPlayer->nDirCheck = 1;
	ld	a, #0x01
	ld	(de), a
;player.c:175: m_nSprayIndex = 33;
	ld	hl, #_m_nSprayIndex
	ld	(hl), #0x21
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x46
	ld	(hl+), a
	ld	(hl), #0x50
;player.c:176: move_sprite(5, 80, 70);
00126$:
;player.c:180: UpdatePlayer(ptrPlayer);
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdatePlayer
;player.c:181: }
	add	sp, #11
	ret
;player.c:189: void ShowSprayEffect(BOOLEAN bShowSpray)
;	---------------------------------
; Function ShowSprayEffect
; ---------------------------------
_ShowSprayEffect::
;player.c:195: if (bShowSpray)
	or	a, a
	jr	Z, 00104$
;player.c:198: if (!m_bButtonBPressed)
	ld	hl, #_m_bButtonBPressed
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;player.c:201: m_bButtonBPressed = TRUE;
	ld	(hl), #0x01
;player.c:204: NR41_REG = 0x2D;
	ld	a, #0x2d
	ldh	(_NR41_REG + 0), a
;player.c:205: NR42_REG = 0x81;
	ld	a, #0x81
	ldh	(_NR42_REG + 0), a
;player.c:206: NR43_REG = 0x10;
	ld	a, #0x10
	ldh	(_NR43_REG + 0), a
;player.c:207: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG + 0), a
;player.c:210: set_sprite_tile(5, m_nSprayIndex);
	ld	a, (_m_nSprayIndex)
	ld	c, a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), c
;player.c:211: return;
	ret
00102$:
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x5f
;player.c:215: set_sprite_tile(5, 95);
	ret
00104$:
;player.c:221: m_bButtonBPressed = FALSE;
	xor	a, a
	ld	(#_m_bButtonBPressed),a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x5f
;player.c:224: set_sprite_tile(5, 95);
;player.c:226: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__m_nSprayIndex:
	.db #0x00	; 0
__xinit__m_bButtonBPressed:
	.db #0x00	;  0
	.area _CABS (ABS)
