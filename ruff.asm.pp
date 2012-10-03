    opt l-h+f-
    icl 'hardware.asm'
    org $2000
    ; Digital sound via Pulse Width Modulation per phaeron's side movie demo:
    ; http://www.atariage.com/forums/topic/200051-need-help-with-ide-hardware/
    ; Mode E PAL Blending per popmilo:
    ; http://www.atariage.com/forums/topic/197450-mode-15-pal-blending/#entry2609821
init
    sei
    lda #0
    sta IRQEN
    sta NMIEN
    sta DMACTL
    mva #15 COLPM0
    mva #$ff AUDF1
    mva #$ff AUDF2
    mva #$00 AUDF3
    mva #$00 AUDF4
    mva #$af AUDC1
    mva #$a0 AUDC2
    mva #$a0 AUDC3
    mva #$a0 AUDC4
    mva #$71 AUDCTL
    mva #$01 SKCTL
    mva #0 GRACTL
    mva #0 GRAFP0
    mva #0 GRAFP1
    mva #0 GRAFP2
    mva #0 GRAFP3
    mva #0 GRAFM
    mva #$22 DMACTL
    lda #3
    cmp:rne VCOUNT
    sta WSYNC
    rts
showframe
    mva #$af AUDC1
    mva #$71 AUDCTL
    mva <dlist DLISTL
    mva >dlist DLISTH
    ldx #0
image
    mva audio,x WSYNC
    sta AUDF1
    sta STIMER
    mva #0 COLBK
    mva #$32 COLPF0
    mva #$72 COLPF1
    mva #$d2 COLPF2
    :2 inx
    mva audio-1,x WSYNC
    sta AUDF1
    sta STIMER
    mva #0 COLBK
    mva #6 COLPF0
    mva #10 COLPF1
    mva #14 COLPF2
    cpx #240
    bne image
    ldx #0
blank
    mva audio+240,x WSYNC
    sta AUDF1
    sta STIMER
    inx
    cpx #[312-240]
    bne blank
    rts
freeze
    jsr showframe
    jmp freeze
bitmap equ [$4000+$10]
audio equ [bitmap+240*40]
dlist
    dta $4e,a(bitmap)
    :203 dta $e
    dta $4e,a(bitmap+$2000-$10)
    :35 dta $e
    dta $41,a(dlist)
    ini init
    ;org bitmap
    ;:10000 dta [<#]
>>> for () {
    org bitmap

>>> }
    ini freeze
