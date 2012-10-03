# $Id: Makefile 36 2008-06-29 23:46:07Z lybrown $

export movie = ruff

movie.run:

atari = /c/Documents\ and\ Settings/lybrown/Documents/Altirra.exe

frames = $(shell cd orig; echo *.png | sed s/.png/.ppm.asm/g)
movie.obx: $(frames) $(movie).audc

%.u8: %.wav
	sox -v 0.7 $< -u -b 8 -r15600 -D $@ dcshift -0.5 remix -

%.raw: %.wav
	sox -v 0.15 $< -u -b 8 -r15600 -D $@

%.audc: %.raw
	./raw2audc $< > $@

%.ppm: orig/%.png
	convert +dither -compress none $< -remap pal.ppm $@

%.ppm.asm: %.ppm
	./ppm2asm $< > $@

%.run: %.xex
	$(atari) $<

%.xex: %.obx
	cp $< $@

%.asm.pl: %.asm.pp
	perl -pe 's/^\s*>>>// or s/(.*)/print <<\\EOF;\n$$1\nEOF/' $< > $@

%.asm: %.asm.pl
	perl $< > $@
	
%.obx: %.asm
	xasm /l /d:pwm=0 $<

clean:
	rm -f *.{obx,atr,lst} *.{tmc,tm2,pgm,wav}.asm *~

.PRECIOUS: %.obx %.lis %.atr %.xex %.asm.pl %.asm
