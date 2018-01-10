section "hack RAM", wramx[$de00], BANK[$01]

wHackOldBank: ds 1
wTempH: ds 1
wTempL: ds 1
wTempA: ds 1

section "hack ROM", ROMX[$4000], BANK[$3E]
HackPredef:
    ; save hl
    ld a, h
    ld [wTempH], a
    ld a, l
    ld [wTempL], a
    
    push bc
    ld hl, HackPredefTable
    ld b, 0
    ld a, [wTempA] ; old a
    ld c, a
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a
    push bc
    pop hl
    pop bc
    
    push hl
    ld a, [wTempH]
    ld h, a
    ld a, [wTempL]
    ld l, a
    ret ; jumps to hl

hack_entry: MACRO
Hack\1Entry:
    dw Hack\1
ENDM

hack: MACRO
    ld a, (Hack\1Entry-HackPredefTable) / 2
    rst $8
ENDM

HackPredefTable:
    hack_entry Nop

HackNop:
    ret
