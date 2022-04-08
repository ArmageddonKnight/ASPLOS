all: main.pdf Makefile

%.pdf: %.tex
	pdflatex -synctex=1 -interaction=nonstopmode $<
	-bibtex $*.aux
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean upgrade
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)

YEAR := 2023
YR   := $(shell printf ${YEAR} | cut -c 3-)

upgrade:
	curl -LO https://asplos-conference.org/wp-content/uploads/${YEAR}/asplos${YR}-templates.zip
	unzip -o asplos${YR}-templates.zip asplos${YR}-templates/jpaper.cls
	cp asplos${YR}-templates/jpaper.cls jpaper.cls
	rm -rf asplos${YR}-templates.zip asplos${YR}-templates
