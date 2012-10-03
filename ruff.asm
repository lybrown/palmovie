    opt l-h+f-
    icl 'hardware.asm'
    org $2000
    ; Digital sound via Pulse Width Modulation
    ; As reversed engineered from phaeron's side movie code:
    ; http://www.atariage.com/forums/topic/200051-need-help-with-ide-hardware/
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
    mva #0 COLBAK
    mva #$32 COLPF0
    mva #$72 COLPF1
    mva #$d2 COLPF2
    :2 inx
    mva audio-1,x WSYNC
    sta AUDF1
    sta STIMER
    mva #0 COLBAK
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
    cpx [312-240]
    bne blank
    rts
quiet
    mva #$00 AUDC1
    mva #$00 AUDC2
    mva #$00 AUDC3
    mva #$00 AUDC4
flip
    mva #0 COLBAK
    mva #$32 COLPF0
    mva #$72 COLPF1
    mva #$d2 COLPF2
    sta WSYNC
    mva #0 COLBAK
    mva #6 COLPF0
    mva #10 COLPF1
    mva #14 COLPF2
    sta WSYNC
    jmp flip
bitmap equ [$4000+$10]
audio equ [bitmap+240*40]
dlist
    dta $4e,a(bitmap)
    :203 dta $e
    dta $4e,a(bitmap+$2000-$10)
    :35 dta $e
    dta $41,a(dlist)
    FRAMES

    ; sox -v 0.5 ruff.wav -u -b 8 -r15600 -D ruff.u8 dcshift -0.5 remix -
dig equ *
    ini init
    org dig
    ins 'ruff.u8',offset,buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+1*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+2*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+3*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+4*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+5*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+6*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+7*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+8*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+9*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+10*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+11*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+12*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+13*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+14*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+15*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+16*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+17*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+18*[buftop-dig],buftop-dig
    ini play
    org dig
    ins 'ruff.u8',offset+19*[buftop-dig],buftop-dig
    ini play
;    org dig
;    ins 'ruff.u8',offset+20*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+21*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+22*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+23*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+24*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+25*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+26*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+27*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+28*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+29*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+30*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+31*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+32*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+33*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+34*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+35*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+36*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+37*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+38*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+39*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+40*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+41*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+42*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+43*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+44*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+45*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+46*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+47*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+48*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+49*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+50*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+51*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+52*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+53*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+54*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+55*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+56*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+57*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+58*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+59*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+60*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+61*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+62*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+63*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+64*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+65*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+66*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+67*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+68*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+69*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+70*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+71*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+72*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+73*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+74*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+75*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+76*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+77*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+78*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+79*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+80*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+81*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+82*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+83*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+84*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+85*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+86*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+87*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+88*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+89*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+90*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+91*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+92*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+93*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+94*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+95*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+96*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+98*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+98*[buftop-dig],buftop-dig
;    ini play
;    org dig
;    ins 'ruff.u8',offset+99*[buftop-dig],buftop-dig
;    ini play
    run quiet
http://www.atariage.com/forums/topic/197450-mode-15-pal-blending/#entry2609821
