
SHELL := /bin/bash

SRC	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
PDF	= $(SRC:%.tex=%.pdf)

RERUN = "(There were undefined references|Rerun to get (cross-references|the bars) right|Table widths have changed. Rerun LaTeX.|Linenumber reference failed)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"

# .PHONY tells make that these rules don't create any file
# --> if there is a file called all it will still run
.PHONY: all clean images alone

#all : $(SRC) alone
all : $(PDF)

images:
	$(MAKE) -C images

mrproper: clean
	$(MAKE) mrproper -C images
	rm -f *.pdf

clean:
	$(MAKE) clean -C images
	rm -f *.aux *.log *.bbl *.blg *.brf *.cb *.ind *.idx *.ilg  \
	      *.inx *.ps *.dvi *.toc *.out *.lot *~ *.lof *.ttt *.fff \
		  *.nav *.snm *.vrb

alone: clean all

%.pdf : %.tex images
	pdflatex $<
	egrep -c $(RERUNBIB) $*.log && (bibtex $*;pdflatex $<); true
	pdflatex $<
	pdflatex $<
#	egrep $(RERUN) $*.log && (pdflatex $<) ; true
#	egrep $(RERUN) $*.log && (pdflatex $<) ; true

#alone:
#	@echo "Removing ..." && rm -rf *.log *aux *.nav *.out *.snm *.toc && echo "... ok"
#
#clean :
#	@echo "Removing ..." && rm -rf *.log *aux *.nav *.out *.snm *.toc paper_Ibergrid2011.pdf && echo "... ok"
