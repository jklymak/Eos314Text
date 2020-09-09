TEXMFOUTPUT := ".texpadtmp"

upload: all
	rsync -av Eos314.pdf ocean-physics.seos.uvic.ca:Sites/Eos314Text
	rsync -av Chap*.pdf ocean-physics.seos.uvic.ca:Sites/Eos314Text

all: Eos314.pdf pdfs

Chapters = Chap01Estuaries.tex  Chap02Eos.tex  Chap03Fluxes.tex  Chap04Masses.tex  Chap05Thermohaline.tex  Chap06Waves.tex  Chap07Tides.tex

Eos314.pdf: $(texs) Eos314.tex
	pdflatex --output-directory=. Eos314
	cp .texpadtmp/Eos314.pdf .

Chapters = Chap01Estuaries.pdf  Chap02Eos.pdf  Chap03Fluxes.pdf  Chap04Masses.pdf  Chap05Thermohaline.pdf  Chap06Waves.pdf  Chap07Tides.pdf

pdfs: $(Chapters)

Chap%.pdf: Chap%.tex
	pdflatex --output-directory=.texpadtmp --jobname=$(basename $@)out "\includeonly{$(basename $@)}\input{Eos314}"
	TEXMFOUTPUT=".texpadtmp" bibtex .texpadtmp/$(basename $@)out
	echo "done"
	pdflatex --output-directory=.texpadtmp --jobname=$(basename $@)out "\includeonly{$(basename $@)}\input{Eos314}"
	cp .texpadtmp/$(basename $@)out.pdf ./$@

#Chap01Estuaries.pdf: Chap01Estuaries.tex
#	pdflatex --output-directory=.texpadtmp --jobname=Chap01 "\includeonly{Chap01Estuaries}\input{Eos314}"
#	cp .texpadtmp/Chap01.pdf .
