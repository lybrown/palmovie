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
    ift pwm
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
    eif
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
    ift pwm
    mva #$af AUDC1
    mva #$71 AUDCTL
    els
    mva $80 AUDC1
    eif
    mva <dlist DLISTL
    mva >dlist DLISTH
    ldx #0
image
    ldy audio,x
    sta WSYNC
    mva #0 COLBK
    mva #$32 COLPF0
    mva #$72 COLPF1
    mva #$d2 COLPF2
    ift pwm
    sty AUDF1
    sta STIMER
    els
    sty AUDC1
    eif
    :2 inx
    ldy audio-1,x
    sta WSYNC
    mva #0 COLBK
    mva #6 COLPF0
    mva #10 COLPF1
    mva #14 COLPF2
    ift pwm
    sty AUDF1
    sta STIMER
    els
    sty AUDC1
    eif
    cpx #240
    bne image
    ldx #0
blank
    ldy audio+240,x
    sta WSYNC
    :4 mva #0 COLBK
    :1 nop
    ift pwm
    sty AUDF1
    sta STIMER
    els
    sty AUDC1
    eif
    inx
    cpx #[312-240]
    bne blank
    sty $80
    rts
freeze
    jsr showframe
    jmp freeze
bitmap equ [$4000+$10]
audio equ [bitmap+240*40+16]
dlist
    dta $4e,a(bitmap)
    :101 dta $e
    dta $4e,a(bitmap+$1000-$10)
    :101 dta $e
    dta $4e,a(bitmap+$2000-$10)
    :35 dta $e
    dta $41,a(dlist)
    ini init
>>> use strict; use warnings;
>>> my @frames = <$ENV{movie}*.ppm.asm>;
>>> splice @frames, 1500;
>>> sub audio {
>>>   my ($count) = @_;
>>>   print "   ins '$ENV{movie}.audc',$count*312,312\n";
>>> }
>>> my $count = 0;
>>> for my $frame (@frames) {
    org bitmap
>>> print "   icl '$frame'\n";
    org audio
>>> audio($count++);
    ini showframe
    org audio
>>> audio($count++);
    ini showframe
>>> }
    org audio
    ift pwm
    :312 dta 0
    els
    :312 dta $18
    eif
    ini freeze
