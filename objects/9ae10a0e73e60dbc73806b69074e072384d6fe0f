.PHONY: clean

EXAMPLES = exemple.tex exemplesansTVA.tex exemplesansremise.tex
EXAMPLES_PDF = $(EXAMPLES:%.tex=%.pdf)

all: facture.pdf $(EXAMPLES_PDF)

facture.zip: all
	mkdir -p facture
	cp $(EXAMPLES) $(EXAMPLES_PDF) facture.{dtx,ins,pdf} README.md Makefile facture/
	zip -r facture.zip facture

facture.cls:
	@xelatex facture.ins

facture.pdf:
	@xelatex facture.dtx
	@makeindex -s gglo.ist -o facture.gls facture.glo
	@xelatex facture.dtx
	@xelatex facture.dtx

%.pdf: %.tex facture.cls
	@xelatex $*

clean:
	rm -f *.aux *.cls *.log *.glo *.gls *.hd *.idx *.ilg *.out *.pdf *.toc
	rm -f facture.zip
	rm -rf facture
