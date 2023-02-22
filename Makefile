SRCS = $(wildcard e-maxx-eng/src/*/*.md)
TEXS = $(patsubst %.md, %.tex, $(SRCS))
LATEXMK_FLAGS = --shell-escape -pdf

.PHONY: all clean book

# Book
book: e-maxx.pdf
travis: LATEXMK_FLAGS += -interaction=nonstopmode -auxdir=aux
travis: book

e-maxx.pdf: e-maxx.tex
	latexmk ${LATEXMK_FLAGS} $<

e-maxx.tex: $(TEXS) misc/imgfetch.sh misc/assemble.sh misc/parse_navigation.py misc/template.tex
	bash misc/imgfetch.sh
	bash misc/assemble.sh > $@

%.tex: %.md misc/prefix.py misc/fixes.pl misc/postfix.py
	cat $< | python3 misc/prefix.py > $<.tmp
	perl misc/fixes.pl $<.tmp | python3 misc/postfix.py | pandoc -f markdown -o $@
	rm $<.tmp

clean:
	@rm -f $(TEXS)
	@rm -f e-maxx.*
	@rm -rf e-maxx-eng/static
	@rm -rf svg-inkscape
