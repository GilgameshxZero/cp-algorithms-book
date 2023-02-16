SRCS = $(wildcard e-maxx-eng/src/*/*.md)
TEXS = $(patsubst %.md, %.tex, $(SRCS))
LATEXMK_FLAGS = -pdf

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

%.tex: %.md misc/fixes.pl misc/fixes.py
	perl misc/fixes.pl $< | python3 misc/fixes.py | pandoc -f markdown -o $@

clean:
	@rm -f $(TEXS)
	@rm -f e-maxx.*
