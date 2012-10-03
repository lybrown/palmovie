# $Id: Makefile 36 2008-06-29 23:46:07Z lybrown $

ruff.run:

atari = /c/Documents\ and\ Settings/lybrown/Documents/Altirra.exe

%.run: %.xex
	$(atari) $<

%.xex: %.obx
	cp $< $@

%.obx: %.asm
	if grep -q "^ *icl" $<; then \
	make $$(perl -ne "/^ *icl '(.+)'/&&print qq{\$$1 }" $< | sort -u); fi
	if grep -q "^ *ins" $<; then \
	make $$(perl -ne "/^ *ins '(.+)'/&&print qq{\$$1 }" $< | sort -u); fi
	xasm /l $<

clean:
	rm -f *.{obx,atr,lst} *.{tmc,tm2,pgm,wav}.asm *~

.PRECIOUS: %.obx %.lis %.atr %.xex
