;  0000,0008,0010,0018,0020,0028,0030,0038   for RST commands
;  0040,0048,0050,0058,0060                  for Interrupts

section "RST 0x0000", rom0 [$0000]
    jp   TableJump

section "RST 0x0008", rom0 [$0008]
    push af
    ld a, [wCurrentBank]
    ld [wHackOldBank], a
    ld a, BANK(HackPredef)
    ld [$2000], a
    pop af
    call HackPredef
    push af
    ld a, [wHackOldBank]
    ld [wHackOldBank], a
    pop af
    ret

section "Interrupt VBlank", rom0 [$0040]
    jp   InterruptVBlank

section "Interrupt LCD Stat", rom0 [$0048]
    jp   InterruptLCDStatus

section "Interrupt Timer", rom0 [$0050]
    reti

section "Interrupt Serial", rom0 [$0058]
    jp   InterruptSerial

section "Interrupt Joypad", rom0 [$0060]
    reti
