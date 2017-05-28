
LATEX=pdflatex
BIBTEX=bibtex
PS2PDF=ps2pdf
DVIPS=dvips
READ=evince

filename=rapport_final.pdf 

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

interface.pdf : interface.tex
	$(LATEX) interface.tex
	$(BIBTEX) interface ||true
	$(LATEX) interface.tex
	$(LATEX) interface.tex

rapport_final.pdf : rapport_final.tex
	$(LATEX) rapport_final.tex
	$(BIBTEX) rapport_final ||true
	$(LATEX) rapport_final.tex
	$(LATEX) rapport_final.tex
