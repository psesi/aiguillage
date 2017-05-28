
LATEX=pdflatex
BIBTEX=bibtex
PS2PDF=ps2pdf
DVIPS=dvips
READ=evince

filename= biblio.pdf

all: $(filename)

text: html
	html2text -width 100 -style pretty ${filename}/${filename}.html | sed -n '/./,$$p' | head -n-2 >${filename}.txt

html:
	@#latex2html -split +0 -info "" -no_navigation ${filename}
	htlatex ${filename}

ps:	dvi
	$(DVIPS) -t letter ${filename}.dvi

.pdf.tex: 
	$(LATEX) $<
	$(BIBTEX) $<||true
	$(LATEX) $<
	$(LATEX) $<

clean:
	rm -f *.{ps,pdf,log,aux,out,dvi,bbl,blg}


biblio.pdf : biblio.tex
	$(LATEX) biblio.tex
	$(BIBTEX) biblio ||true
	$(LATEX) biblio.tex
	$(LATEX) biblio.tex
