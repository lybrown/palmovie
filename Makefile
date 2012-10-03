# $Id: Makefile 36 2008-06-29 23:46:07Z lybrown $

ruff.run:

atari = /c/Documents\ and\ Settings/lybrown/Documents/Altirra.exe

images:
	for f in $$(cd orig; echo *.png); do \
	convert +dither -compress none orig/$$f -remap pal.ppm $${f/.png/.ppm}; \
	done

%.run: %.xex
	$(atari) $<

%.xex: %.obx
	cp $< $@

%.asm.pl: %.asm.pp
	perl -pe 's/^\s*>>>// or s/(.*)/print <<\\EOF;\n$$1\nEOF/' $< > $@

%.asm: %.asm.pl
	perl $< > $@
	
%.obx: %.asm
	xasm /l $<

clean:
	rm -f *.{obx,atr,lst} *.{tmc,tm2,pgm,wav}.asm *~

.PRECIOUS: %.obx %.lis %.atr %.xex
