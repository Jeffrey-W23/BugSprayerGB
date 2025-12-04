;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module enemies
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rand
	.globl _m_bShowSpray
	.globl _m_bPlayKillSoundEffect
	.globl _m_nSpawnDelay
	.globl _m_nSpawnTimer
	.globl _m_aoEnemies
	.globl _InitEnemiesSpawnQueue
	.globl _GetNextSpawnIndex
	.globl _InitEnemy
	.globl _SpawnEnemy
	.globl _GetSprite
	.globl _UpdateEnemy
	.globl _KillEnemy
	.globl _IncreaseDifficulty
	.globl _IsEnemyAlive
	.globl _SpawnNext
	.globl _TickSpawnTimer
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_m_aoEnemies::
	.ds 208
_m_anSpawnQueue:
	.ds 64
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_m_nNextSpriteID:
	.ds 1
_m_nSpawnQueuePos:
	.ds 1
_m_nCurrentSpeed:
	.ds 1
_m_nTotalKilled:
	.ds 2
_m_nKillsForNextSpeed:
	.ds 2
_m_nKillsForNextSpawnRate:
	.ds 2
_m_bMaxSpeedReached:
	.ds 1
_m_bMaxSpawnRateReached:
	.ds 1
_m_nLastSpawnRateKillCount:
	.ds 2
_m_nSpawnTimer::
	.ds 1
_m_nSpawnDelay::
	.ds 1
_m_bPlayKillSoundEffect::
	.ds 1
_m_bShowSpray::
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
;enemies.c:87: void InitEnemiesSpawnQueue(void) 
;	---------------------------------
; Function InitEnemiesSpawnQueue
; ---------------------------------
_InitEnemiesSpawnQueue::
	dec	sp
;enemies.c:95: UINT8 nIndex = 0;
	ld	e, #0x00
;enemies.c:97: BOOLEAN bValidShuffle = FALSE;
;enemies.c:101: for (o = 0; o < 8; o++) 
	ld	bc, #0x800
;enemies.c:103: for (k = 0; k < 8; k++) 
00126$:
	ld	d, #0x00
00113$:
;enemies.c:105: m_anSpawnQueue[nIndex++] = k;
	ld	a, #<(_m_anSpawnQueue)
	add	a, e
	ld	l, a
	ld	a, #>(_m_anSpawnQueue)
	adc	a, #0x00
	ld	h, a
	inc	e
	ld	(hl), d
;enemies.c:103: for (k = 0; k < 8; k++) 
	inc	d
	ld	a, d
	sub	a, #0x08
	jr	C, 00113$
	dec	b
	jr	NZ, 00126$
;enemies.c:101: for (o = 0; o < 8; o++) 
;enemies.c:111: while (!bValidShuffle) 
00110$:
	ld	a, c
	or	a, a
	jr	NZ, 00112$
;enemies.c:114: for (i = SPAWN_QUEUE_SIZE - 1; i > 0; i--) 
	ldhl	sp,	#0
	ld	(hl), #0x3f
00118$:
;enemies.c:116: j = rand() % (i + 1);
	call	_rand
	ldhl	sp,	#0
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	d, #0x00
	call	__modsint
;enemies.c:117: nTemp = m_anSpawnQueue[i];
	ld	de, #_m_anSpawnQueue
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
;enemies.c:118: m_anSpawnQueue[i] = m_anSpawnQueue[j];
	ld	a, #<(_m_anSpawnQueue)
	add	a, c
	ld	l, a
	ld	a, #>(_m_anSpawnQueue)
	adc	a, #0x00
	ld	h, a
	ld	a, (hl)
	ld	(de), a
;enemies.c:119: m_anSpawnQueue[j] = nTemp;
	ld	(hl), b
;enemies.c:114: for (i = SPAWN_QUEUE_SIZE - 1; i > 0; i--) 
	ldhl	sp,	#0
	dec	(hl)
	jr	NZ, 00118$
;enemies.c:124: bValidShuffle = TRUE;
;enemies.c:125: nStreak = 1;
	ld	bc, #0x101
;enemies.c:130: for (i = 1; i < SPAWN_QUEUE_SIZE; i++) 
	ld	e, #0x01
00120$:
;enemies.c:133: if (m_anSpawnQueue[i] == m_anSpawnQueue[i-1]) 
	ld	hl, #_m_anSpawnQueue
	ld	d, #0x00
	add	hl, de
	ld	d, (hl)
	ld	a, e
	dec	a
	add	a, #<(_m_anSpawnQueue)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_m_anSpawnQueue)
	ld	h, a
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00107$
;enemies.c:136: nStreak++;
	inc	b
;enemies.c:139: if (nStreak > 3) 
	ld	a, #0x03
	sub	a, b
	jr	NC, 00121$
;enemies.c:143: bValidShuffle = FALSE;
	ld	c, #0x00
;enemies.c:144: break;
	jr	00110$
00107$:
;enemies.c:151: nStreak = 1;
	ld	b, #0x01
00121$:
;enemies.c:130: for (i = 1; i < SPAWN_QUEUE_SIZE; i++) 
	inc	e
	ld	a, e
	sub	a, #0x40
	jr	C, 00120$
	jr	00110$
00112$:
;enemies.c:157: m_nSpawnQueuePos = 0;
	xor	a, a
	ld	(#_m_nSpawnQueuePos),a
;enemies.c:158: }
	inc	sp
	ret
_m_anSpawnPositions:
	.db #0x27	; 39
	.db #0x2b	; 43
	.db #0x50	; 80	'P'
	.db #0x29	; 41
	.db #0x82	; 130
	.db #0x21	; 33
	.db #0x0e	; 14
	.db #0x52	; 82	'R'
	.db #0x9a	; 154
	.db #0x52	; 82	'R'
	.db #0x06	; 6
	.db #0x9a	; 154
	.db #0x50	; 80	'P'
	.db #0x9a	; 154
	.db #0x9c	; 156
	.db #0x9c	; 156
_m_anMovementDirX:
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0x01	;  1
	.db #0xff	; -1
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0xff	; -1
_m_anMovementDirY:
	.db #0x01	;  1
	.db #0x01	;  1
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0xff	; -1
	.db #0xff	; -1
;enemies.c:166: UINT8 GetNextSpawnIndex(void) 
;	---------------------------------
; Function GetNextSpawnIndex
; ---------------------------------
_GetNextSpawnIndex::
;enemies.c:169: UINT8 nIndex = m_anSpawnQueue[m_nSpawnQueuePos];
	ld	a, #<(_m_anSpawnQueue)
	ld	hl, #_m_nSpawnQueuePos
	add	a, (hl)
	ld	c, a
	ld	a, #>(_m_anSpawnQueue)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	l, a
;enemies.c:170: m_nSpawnQueuePos = (m_nSpawnQueuePos + 1) % SPAWN_QUEUE_SIZE;
	ld	a, (_m_nSpawnQueuePos)
	ld	d, #0x00
	ld	e, a
	inc	de
	push	hl
	ld	bc, #0x0040
	call	__modsint
	pop	hl
	ld	a, c
	ld	(_m_nSpawnQueuePos), a
;enemies.c:171: return nIndex;
	ld	a, l
;enemies.c:172: }
	ret
;enemies.c:180: void InitEnemy(UINT8 nEnemyIndex) 
;	---------------------------------
; Function InitEnemy
; ---------------------------------
_InitEnemy::
	ld	c, a
;enemies.c:183: m_aoEnemies[nEnemyIndex].bAlive = FALSE;
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, #<(_m_aoEnemies)
	add	a, l
	ld	c, a
	ld	a, #>(_m_aoEnemies)
	adc	a, h
	ld	b, a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;enemies.c:184: m_aoEnemies[nEnemyIndex].bCantMove = FALSE;
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:185: m_aoEnemies[nEnemyIndex].bMainSpriteSet = FALSE;
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:186: m_aoEnemies[nEnemyIndex].nSpriteID = 0;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x00
;enemies.c:187: m_aoEnemies[nEnemyIndex].nSpeed = m_nCurrentSpeed;
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (_m_nCurrentSpeed)
	ld	(hl), a
;enemies.c:188: m_aoEnemies[nEnemyIndex].nSubPixelX = 0;
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:189: m_aoEnemies[nEnemyIndex].nSubPixelY = 0;
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:190: }
	ret
;enemies.c:199: void SpawnEnemy(UINT8 nEnemyIndex, UINT8 nSpawnIndex) 
;	---------------------------------
; Function SpawnEnemy
; ---------------------------------
_SpawnEnemy::
	add	sp, #-8
	ld	c, a
	ldhl	sp,	#7
	ld	(hl), e
;enemies.c:202: Enemy* ptrEnemy = &m_aoEnemies[nEnemyIndex];
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_m_aoEnemies
	add	hl, de
	ld	c, l
	ld	b, h
;enemies.c:210: if (nSpawnIndex > 7) nSpawnIndex = 2;
	ld	a, #0x07
	ldhl	sp,	#7
	sub	a, (hl)
	jr	NC, 00102$
	ld	(hl), #0x02
00102$:
;enemies.c:213: ptrEnemy->nX = m_anSpawnPositions[nSpawnIndex][0];
	inc	sp
	inc	sp
	push	bc
	ldhl	sp,	#7
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sla	e
	rl	d
	ld	hl, #_m_anSpawnPositions
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	pop	hl
	push	hl
	ld	(hl), a
;enemies.c:214: ptrEnemy->nY = m_anSpawnPositions[nSpawnIndex][1];
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl+), a
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;enemies.c:217: ptrEnemy->nSubPixelX = 0;
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:218: ptrEnemy->nSubPixelY = 0;
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:221: ptrEnemy->bAlive = TRUE;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x01
;enemies.c:222: ptrEnemy->bCantMove = FALSE;
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:223: ptrEnemy->bMainSpriteSet = FALSE;
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x00
;enemies.c:226: nMoveventX = m_anMovementDirX[nSpawnIndex];
	ld	de, #_m_anMovementDirX+0
	ldhl	sp,	#7
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#6
;enemies.c:227: nMovementY = m_anMovementDirY[nSpawnIndex];
	ld	(hl+), a
	ld	de, #_m_anMovementDirY+0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
;enemies.c:228: ptrEnemy->nDirX = nMoveventX;
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;enemies.c:229: ptrEnemy->nDirY = nMovementY;
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), e
;enemies.c:232: ptrEnemy->nSpeed = m_nCurrentSpeed;
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (_m_nCurrentSpeed)
	ld	(hl), a
;enemies.c:235: ptrEnemy->nSpriteID = m_nNextSpriteID++;
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_m_nNextSpriteID)
	ldhl	sp,	#6
	ld	(hl), a
	ld	hl, #_m_nNextSpriteID
	inc	(hl)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;enemies.c:238: if (m_nNextSpriteID >= 40) m_nNextSpriteID = 7;
	ld	hl, #_m_nNextSpriteID
	ld	a, (hl)
	sub	a, #0x28
	jr	C, 00104$
	ld	(hl), #0x07
00104$:
;enemies.c:241: ptrEnemy->nIndex = nSpawnIndex;
	ld	hl, #0x0008
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(de), a
;enemies.c:245: ptrEnemy->nSpriteNumber = GetSprite((rand() >> 4) % 5) + nSpawnIndex;
	ld	hl, #0x000b
	add	hl, bc
	ld	c, l
	ld	b, h
	call	_rand
	ld	a, e
	swap	a
	and	a, #0x0f
	push	bc
	ld	e, #0x05
	call	__moduchar
	ld	a, c
	call	_GetSprite
	pop	bc
	ldhl	sp,	#7
	ld	e, (hl)
;enemies.c:248: set_sprite_tile(ptrEnemy->nSpriteID, 32);
	dec	hl
	dec	hl
	dec	hl
	add	a, e
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #_shadow_OAM+0
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x20
;enemies.c:251: move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	b, a
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), b
	inc	hl
	ld	(hl), c
;enemies.c:251: move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
;enemies.c:252: }
	add	sp, #8
	ret
;enemies.c:264: INT8 GetSprite(INT8 nRandNumber)
;	---------------------------------
; Function GetSprite
; ---------------------------------
_GetSprite::
;enemies.c:268: switch (nRandNumber)
	or	a, a
	jr	Z, 00101$
	cp	a, #0x01
	jr	Z, 00102$
	cp	a, #0x02
	jr	Z, 00103$
	cp	a, #0x03
	jr	Z, 00104$
	sub	a, #0x04
	jr	Z, 00105$
	jr	00106$
;enemies.c:270: case 0:
00101$:
;enemies.c:271: return 47;
	ld	a, #0x2f
	ret
;enemies.c:273: case 1:
00102$:
;enemies.c:274: return 55;
	ld	a, #0x37
	ret
;enemies.c:276: case 2:
00103$:
;enemies.c:277: return 63;
	ld	a, #0x3f
	ret
;enemies.c:279: case 3:
00104$:
;enemies.c:280: return 71;
	ld	a, #0x47
	ret
;enemies.c:282: case 4:
00105$:
;enemies.c:283: return 79;
	ld	a, #0x4f
	ret
;enemies.c:286: default:
00106$:
;enemies.c:287: return 47;
	ld	a, #0x2f
;enemies.c:289: }
;enemies.c:290: }
	ret
;enemies.c:299: void UpdateEnemy(UINT8 nEnemyIndex, Player* ptrPlayer) 
;	---------------------------------
; Function UpdateEnemy
; ---------------------------------
_UpdateEnemy::
	add	sp, #-15
	ld	c, a
	ldhl	sp,	#13
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;enemies.c:302: Enemy* ptrEnemy = &m_aoEnemies[nEnemyIndex];
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, #<(_m_aoEnemies)
	add	a, l
	ld	c, a
	ld	a, #>(_m_aoEnemies)
	adc	a, h
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
;enemies.c:305: if (!ptrEnemy->bAlive) return;
	pop	hl
	push	hl
	inc	hl
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	a, c
	or	a, a
	jp	Z, 00133$
;enemies.c:308: if (!ptrEnemy->bCantMove) 
	pop	de
	push	de
	ld	hl, #0x0006
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
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00120$
;enemies.c:311: ptrEnemy->nSubPixelX += m_nCurrentSpeed;
	pop	de
	push	de
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_m_nCurrentSpeed
	add	a, (hl)
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;enemies.c:312: ptrEnemy->nSubPixelY += m_nCurrentSpeed;
	pop	de
	push	de
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #_m_nCurrentSpeed
	add	a, (hl)
	ldhl	sp,	#6
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;enemies.c:314: if (ptrEnemy->nSubPixelX >= 16) 
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;enemies.c:316: ptrEnemy->nX += ptrEnemy->nDirX;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
;enemies.c:314: if (ptrEnemy->nSubPixelX >= 16) 
	ld	a, c
	sub	a, #0x10
	jr	C, 00104$
;enemies.c:316: ptrEnemy->nX += ptrEnemy->nDirX;
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, (hl)
	dec	hl
	dec	hl
	add	a, c
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;enemies.c:317: ptrEnemy->nSubPixelX -= 16;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	add	a, #0xf0
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00104$:
;enemies.c:319: if (ptrEnemy->nSubPixelY >= 16) 
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;enemies.c:321: ptrEnemy->nY += ptrEnemy->nDirY;
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
;enemies.c:319: if (ptrEnemy->nSubPixelY >= 16) 
	ld	a, c
	sub	a, #0x10
	jr	C, 00106$
;enemies.c:321: ptrEnemy->nY += ptrEnemy->nDirY;
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, c
	ldhl	sp,	#11
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;enemies.c:322: ptrEnemy->nSubPixelY -= 16;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	add	a, #0xf0
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00106$:
;enemies.c:326: if (!ptrEnemy->bMainSpriteSet)
	pop	de
	push	de
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00113$
;enemies.c:329: if (ptrEnemy->nX >= 15 && ptrEnemy->nX <= 153 && ptrEnemy->nY >= 44 && ptrEnemy->nY <= 143) 
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	cp	a, #0x0f
	jr	C, 00113$
	cp	a, #0x9a
	jr	NC, 00113$
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	cp	a, #0x2c
	jr	C, 00113$
	cp	a, #0x90
	jr	NC, 00113$
;enemies.c:332: ptrEnemy->bMainSpriteSet = TRUE;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;enemies.c:335: set_sprite_tile(ptrEnemy->nSpriteID, ptrEnemy->nSpriteNumber);
	pop	de
	push	de
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	pop	hl
	push	hl
	inc	hl
	inc	hl
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;enemies.c:335: set_sprite_tile(ptrEnemy->nSpriteID, ptrEnemy->nSpriteNumber);
00113$:
;enemies.c:340: if (ptrEnemy->nX >= 76 && ptrEnemy->nX <= 86 && ptrEnemy->nY >= 74 && ptrEnemy->nY <= 84) 
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;enemies.c:321: ptrEnemy->nY += ptrEnemy->nDirY;
	pop	bc
	push	bc
	inc	bc
;enemies.c:340: if (ptrEnemy->nX >= 76 && ptrEnemy->nX <= 86 && ptrEnemy->nY >= 74 && ptrEnemy->nY <= 84) 
	cp	a, #0x4c
	jr	C, 00121$
	cp	a, #0x57
	jr	NC, 00121$
	ld	a, (bc)
	cp	a, #0x4a
	jr	C, 00121$
	cp	a, #0x55
	jr	NC, 00121$
;enemies.c:344: ptrEnemy->bCantMove = TRUE;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jr	00121$
00120$:
;enemies.c:354: ptrPlayer->bTakenDamage = TRUE;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0018
	add	hl, de
	ld	(hl), #0x01
;enemies.c:357: ptrPlayer->nTotalShotsTaken++;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0016
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
;enemies.c:360: KillEnemy(ptrEnemy, ptrPlayer);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_KillEnemy
;enemies.c:365: return;
	jp	00133$
00121$:
;enemies.c:369: if (!ptrEnemy->bCantMove)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;enemies.c:340: if (ptrEnemy->nX >= 76 && ptrEnemy->nX <= 86 && ptrEnemy->nY >= 74 && ptrEnemy->nY <= 84) 
	ldhl	sp,#11
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	(hl), a
;enemies.c:321: ptrEnemy->nY += ptrEnemy->nDirY;
	ld	a, (bc)
	ld	e, a
	pop	af
;enemies.c:369: if (!ptrEnemy->bCantMove)
	or	a, a
	jr	NZ, 00130$
;enemies.c:373: if ((ptrEnemy->nIndex == ptrPlayer->nDirCheck))
	push	de
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, a
	push	de
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	sub	a, d
	jr	NZ, 00130$
;enemies.c:376: if (ptrEnemy->nX >= 62 && ptrEnemy->nX <= 100 && ptrEnemy->nY >= 60 && ptrEnemy->nY <= 100) 
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x3e
	jr	C, 00130$
	ld	a, #0x64
	sub	a, (hl)
	jr	C, 00130$
	ld	a, e
	sub	a, #0x3c
	jr	C, 00130$
	ld	a, #0x64
	sub	a, e
	jr	C, 00130$
;enemies.c:379: ptrPlayer->nTotalShotsTaken++;
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0016
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
;enemies.c:382: KillEnemy(ptrEnemy, ptrPlayer);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	_KillEnemy
;enemies.c:385: m_bShowSpray = TRUE;
	ld	hl, #_m_bShowSpray
	ld	(hl), #0x01
;enemies.c:390: return;
	jr	00133$
00130$:
;enemies.c:396: move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
	ldhl	sp,	#12
	ld	c, (hl)
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	b, (hl)
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, b
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;enemies.c:396: move_sprite(ptrEnemy->nSpriteID, ptrEnemy->nX, ptrEnemy->nY);
00133$:
;enemies.c:397: }
	add	sp, #15
	ret
;enemies.c:406: void KillEnemy(Enemy* ptrEnemy, Player* ptrPlayer)
;	---------------------------------
; Function KillEnemy
; ---------------------------------
_KillEnemy::
	push	bc
;enemies.c:409: ptrEnemy->bAlive = FALSE;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;enemies.c:412: set_sprite_tile(ptrEnemy->nSpriteID, 0);
	inc	de
	inc	de
	ld	a, (de)
	ld	c, a
;c:\gbdk2020\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x00
;enemies.c:413: move_sprite(ptrEnemy->nSpriteID, 0, 0);
	ld	a, (de)
	ld	e, a
;c:\gbdk2020\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:\gbdk2020\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;enemies.c:416: ptrPlayer->nScore += 1;
	pop	de
	push	de
	ld	hl, #0x0014
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
;enemies.c:417: m_nTotalKilled += 1;
	ld	hl, #_m_nTotalKilled
	inc	(hl)
	jr	NZ, 00105$
	inc	hl
	inc	(hl)
00105$:
;enemies.c:420: m_bPlayKillSoundEffect = TRUE;
	ld	hl, #_m_bPlayKillSoundEffect
	ld	(hl), #0x01
;enemies.c:421: }
	inc	sp
	inc	sp
	ret
;enemies.c:429: void IncreaseDifficulty(UINT8 nDamgeToPlayer)
;	---------------------------------
; Function IncreaseDifficulty
; ---------------------------------
_IncreaseDifficulty::
;enemies.c:432: if (!m_bMaxSpeedReached)
	ld	a, (#_m_bMaxSpeedReached)
	or	a, a
	jr	NZ, 00118$
;enemies.c:436: if (m_nTotalKilled >= m_nKillsForNextSpeed) 
	ld	de, #_m_nTotalKilled
	ld	hl, #_m_nKillsForNextSpeed
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00118$
;enemies.c:438: m_nCurrentSpeed++;
	ld	hl, #_m_nCurrentSpeed
	inc	(hl)
;enemies.c:439: if (m_nCurrentSpeed == 2) m_nKillsForNextSpeed = 50;
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00111$
	ld	hl, #_m_nKillsForNextSpeed
	ld	a, #0x32
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00112$
00111$:
;enemies.c:440: else if (m_nCurrentSpeed == 3) m_nKillsForNextSpeed = 125;
	ld	a, (#_m_nCurrentSpeed)
	sub	a, #0x03
	jr	NZ, 00108$
	ld	hl, #_m_nKillsForNextSpeed
	ld	a, #0x7d
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00112$
00108$:
;enemies.c:441: else if (m_nCurrentSpeed == 4) m_nKillsForNextSpeed = 250;
	ld	a, (#_m_nCurrentSpeed)
	sub	a, #0x04
	jr	NZ, 00105$
	ld	hl, #_m_nKillsForNextSpeed
	ld	a, #0xfa
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00112$
00105$:
;enemies.c:442: else if (m_nCurrentSpeed == 5) m_nKillsForNextSpeed = 400;
	ld	a, (#_m_nCurrentSpeed)
	sub	a, #0x05
	jr	NZ, 00102$
	ld	hl, #_m_nKillsForNextSpeed
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0x01
	jr	00112$
00102$:
;enemies.c:443: else m_nKillsForNextSpeed += 150;  // Gradual increase after
	ld	hl, #_m_nKillsForNextSpeed
	ld	a, (hl)
	add	a, #0x96
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
00112$:
;enemies.c:446: if (m_nCurrentSpeed >= MAX_SPEED) 
	ld	hl, #_m_nCurrentSpeed
	ld	a, (hl)
	sub	a, #0x08
	jr	C, 00118$
;enemies.c:450: m_nCurrentSpeed = MAX_SPEED;
	ld	(hl), #0x08
;enemies.c:451: m_bMaxSpeedReached = TRUE;
	ld	hl, #_m_bMaxSpeedReached
	ld	(hl), #0x01
00118$:
;enemies.c:457: if (!m_bMaxSpawnRateReached && m_nTotalKilled != 0 && m_nTotalKilled % m_nKillsForNextSpawnRate == 0)
	ld	a, (#_m_bMaxSpawnRateReached)
	or	a, a
	ret	NZ
	ld	hl, #_m_nTotalKilled + 1
	ld	a, (hl-)
	or	a, (hl)
	ret	Z
	ld	a, (_m_nKillsForNextSpawnRate)
	ld	c, a
	ld	hl, #_m_nKillsForNextSpawnRate + 1
	ld	b, (hl)
	ld	a, (_m_nTotalKilled)
	ld	e, a
	ld	hl, #_m_nTotalKilled + 1
	ld	d, (hl)
	call	__moduint
	ld	a, b
	or	a, c
	ret	NZ
;enemies.c:460: if (m_nTotalKilled != m_nLastSpawnRateKillCount) 
	ld	a, (#_m_nTotalKilled)
	ld	hl, #_m_nLastSpawnRateKillCount
	sub	a, (hl)
	jr	NZ, 00272$
	ld	a, (#_m_nTotalKilled + 1)
	ld	hl, #_m_nLastSpawnRateKillCount + 1
	sub	a, (hl)
	ret	Z
00272$:
;enemies.c:463: if (m_nTotalKilled < 150) m_nSpawnDelay -= 5;
	ld	a, (_m_nSpawnDelay)
	ld	c, a
	ld	hl, #_m_nTotalKilled
	ld	a, (hl+)
	sub	a, #0x96
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00123$
	ld	a, c
	add	a, #0xfb
	ld	(#_m_nSpawnDelay),a
	jr	00124$
00123$:
;enemies.c:464: else if (m_nTotalKilled < 300) m_nSpawnDelay -= 2;
	ld	hl, #_m_nTotalKilled
	ld	a, (hl+)
	sub	a, #0x2c
	ld	a, (hl)
	sbc	a, #0x01
	jr	NC, 00120$
	ld	a, c
	add	a, #0xfe
	ld	(#_m_nSpawnDelay),a
	jr	00124$
00120$:
;enemies.c:465: else m_nSpawnDelay -= 1;
	ld	a, c
	dec	a
	ld	(#_m_nSpawnDelay),a
00124$:
;enemies.c:468: if (m_nTotalKilled < 550) m_nKillsForNextSpawnRate = 15;
	ld	hl, #_m_nTotalKilled
	ld	a, (hl+)
	sub	a, #0x26
	ld	a, (hl)
	sbc	a, #0x02
	jr	NC, 00135$
	ld	hl, #_m_nKillsForNextSpawnRate
	ld	a, #0x0f
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00136$
00135$:
;enemies.c:469: else if (m_nTotalKilled < 650) { m_nKillsForNextSpawnRate = 200; nDamgeToPlayer = 40; }
	ld	hl, #_m_nTotalKilled
	ld	a, (hl+)
	sub	a, #0x8a
	ld	a, (hl)
	sbc	a, #0x02
	jr	NC, 00132$
	ld	hl, #_m_nKillsForNextSpawnRate
	ld	a, #0xc8
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00136$
00132$:
;enemies.c:470: else if (m_nTotalKilled < 950) { m_nKillsForNextSpawnRate = 400; nDamgeToPlayer = 50; }
	ld	hl, #_m_nTotalKilled
	ld	a, (hl+)
	sub	a, #0xb6
	ld	a, (hl)
	sbc	a, #0x03
	jr	NC, 00129$
	ld	hl, #_m_nKillsForNextSpawnRate
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0x01
	jr	00136$
00129$:
;enemies.c:471: else if (m_nTotalKilled < 2000) { m_nKillsForNextSpawnRate = 500; m_nCurrentSpeed = 9; }
	ld	hl, #_m_nTotalKilled
	ld	a, (hl+)
	sub	a, #0xd0
	ld	a, (hl)
	sbc	a, #0x07
	jr	NC, 00126$
	ld	hl, #_m_nKillsForNextSpawnRate
	ld	a, #0xf4
	ld	(hl+), a
	ld	(hl), #0x01
	ld	hl, #_m_nCurrentSpeed
	ld	(hl), #0x09
	jr	00136$
00126$:
;enemies.c:472: else { m_bMaxSpawnRateReached= TRUE; m_nCurrentSpeed = 10; }
	ld	hl, #_m_bMaxSpawnRateReached
	ld	(hl), #0x01
	ld	hl, #_m_nCurrentSpeed
	ld	(hl), #0x0a
00136$:
;enemies.c:475: m_nLastSpawnRateKillCount = m_nTotalKilled;
	ld	a, (#_m_nTotalKilled)
	ld	(#_m_nLastSpawnRateKillCount),a
	ld	a, (#_m_nTotalKilled + 1)
	ld	(#_m_nLastSpawnRateKillCount + 1),a
;enemies.c:478: }
	ret
;enemies.c:489: BOOLEAN IsEnemyAlive(UINT8 nEnemyIndex) 
;	---------------------------------
; Function IsEnemyAlive
; ---------------------------------
_IsEnemyAlive::
	ld	c, a
;enemies.c:491: return m_aoEnemies[nEnemyIndex].bAlive;
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_m_aoEnemies
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
;enemies.c:492: }
	ret
;enemies.c:497: void SpawnNext(void) 
;	---------------------------------
; Function SpawnNext
; ---------------------------------
_SpawnNext::
	dec	sp
	dec	sp
;enemies.c:508: UINT8 nFreeSlot = MAX_ENEMIES;
	ld	c, #0x10
;enemies.c:512: for (i = 0; i < MAX_ENEMIES; i++) 
	ldhl	sp,	#0
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00106$:
;enemies.c:517: if (!m_aoEnemies[i].bAlive) 
	ldhl	sp,	#1
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	de, #_m_aoEnemies
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00107$
;enemies.c:519: nFreeSlot = i;
	ldhl	sp,	#0
	ld	c, (hl)
;enemies.c:520: break;
	jr	00103$
00107$:
;enemies.c:512: for (i = 0; i < MAX_ENEMIES; i++) 
	ldhl	sp,	#1
	inc	(hl)
	ld	a, (hl-)
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00106$
00103$:
;enemies.c:526: if (nFreeSlot == MAX_ENEMIES) return;
	ld	a, c
	sub	a, #0x10
	jr	Z, 00108$
;enemies.c:529: nSpawnIndex = GetNextSpawnIndex();
	push	bc
	call	_GetNextSpawnIndex
	pop	bc
;enemies.c:532: SpawnEnemy(nFreeSlot, nSpawnIndex);
	ld	e, a
	ld	a, c
	inc	sp
	inc	sp
	jp	_SpawnEnemy
00108$:
;enemies.c:533: }
	inc	sp
	inc	sp
	ret
;enemies.c:538: void TickSpawnTimer(void) 
;	---------------------------------
; Function TickSpawnTimer
; ---------------------------------
_TickSpawnTimer::
;enemies.c:540: if (m_nSpawnTimer > 0) 
	ld	hl, #_m_nSpawnTimer
	ld	a, (hl)
	or	a, a
	ret	Z
;enemies.c:542: m_nSpawnTimer--;
	dec	(hl)
;enemies.c:544: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__m_nNextSpriteID:
	.db #0x07	; 7
__xinit__m_nSpawnQueuePos:
	.db #0x00	; 0
__xinit__m_nCurrentSpeed:
	.db #0x01	; 1
__xinit__m_nTotalKilled:
	.dw #0x0000
__xinit__m_nKillsForNextSpeed:
	.dw #0x000f
__xinit__m_nKillsForNextSpawnRate:
	.dw #0x000f
__xinit__m_bMaxSpeedReached:
	.db #0x00	;  0
__xinit__m_bMaxSpawnRateReached:
	.db #0x00	;  0
__xinit__m_nLastSpawnRateKillCount:
	.dw #0x0000
__xinit__m_nSpawnTimer:
	.db #0x00	; 0
__xinit__m_nSpawnDelay:
	.db #0x64	; 100	'd'
__xinit__m_bPlayKillSoundEffect:
	.db #0x00	;  0
__xinit__m_bShowSpray:
	.db #0x00	;  0
	.area _CABS (ABS)
