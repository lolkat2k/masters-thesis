### VARS Output directory
OUT_DIR=texout
IN_DIR=input/content

# Name - the latex main document
TEX_MAIN=main

# PDF-file name
PDF_TITLE=Hellfritzsch.Sune

.PHONY: main all spellcheck clean rmbak

all: main

main: $(TEX_MAIN).tex $(IN_DIR)/*
	latexmk -pdf -jobname=$(PDF_TITLE) -outdir=$(OUT_DIR) $(TEX_MAIN).tex

spellcheck: $(IN_DIR)/*
	find $(IN_DIR) -maxdepth 1 -type f -name "*.tex" -exec \
		aspell \
		--conf="./aspell/aspell.conf" \
		--extra-dicts="./aspell/thesis.pws" \
		check {} \;

rmbak:
	find $(IN_DIR) -maxdepth 1 -type f -name "*.bak" -delete

clean:
	rm $(OUT_DIR)/*
