images := $(wildcard *.tex)
images := $(patsubst %.tex,%.pdf,$(images))

# .PHONY tells make that these rules don't create any file
# --> if there is a file called all it will still run
.PHONY: all clean alone


all : $(images) 

mrproper: clean
	rm -f *.pdf

clean:
	rm -f *.aux *.log *.bbl *.blg *.brf *.cb *.ind *.idx *.ilg  \
		*.inx *.ps *.dvi *.toc *.out *.lot *~ *.lof *.ttt *.fff \
		*.nav *.snm *.vrb

alone: clean all

%.pdf : %.tex
	    pdflatex $<

