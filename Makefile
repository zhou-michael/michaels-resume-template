# ==============================================================================
# Cross-Platform Resume Template Makefile (macOS & Linux)
# ==============================================================================

OS       := $(shell uname -s)
LATEXMK  := $(shell command -v latexmk 2>/dev/null)
XELATEX  := $(shell command -v xelatex 2>/dev/null)
PDFLATEX := $(shell command -v pdflatex 2>/dev/null)

# Platform-specific PDF viewer
ifeq ($(OS),Darwin)
	VIEWER ?= open -a Skim
else
	VIEWER ?= zathura
endif

BUILD_DIR   := build
SRC         := $(wildcard *.tex)
PDFS        := $(patsubst %.tex,$(BUILD_DIR)/%.pdf,$(SRC))
PRIMARY_PDF := $(if $(wildcard resume.tex),$(BUILD_DIR)/resume.pdf,$(BUILD_DIR)/resume_template.pdf)
PRIMARY_SRC := $(if $(wildcard resume.tex),resume.tex,resume_template.tex)

.PHONY: all clean preview view watch

all: $(PDFS)

$(BUILD_DIR)/%.pdf: %.tex michael-resume.cls
ifneq ($(LATEXMK),)
	@echo "==> Building $< via latexmk on $(OS)..."
	latexmk $<
else ifneq ($(XELATEX),)
	@mkdir -p $(BUILD_DIR)
	@echo "==> Building $< via XeLaTeX..."
	xelatex -output-directory=$(BUILD_DIR) -synctex=1 -interaction=nonstopmode $<
	xelatex -output-directory=$(BUILD_DIR) -synctex=1 -interaction=nonstopmode $<
else ifneq ($(PDFLATEX),)
	@mkdir -p $(BUILD_DIR)
	@echo "==> Building $< via pdfLaTeX..."
	pdflatex -output-directory=$(BUILD_DIR) -synctex=1 -interaction=nonstopmode $<
	pdflatex -output-directory=$(BUILD_DIR) -synctex=1 -interaction=nonstopmode $<
else
	$(error No LaTeX compiler found. Please install TeX Live (pdflatex, xelatex, or latexmk))
endif

# Open PDF in platform viewer
preview: $(PRIMARY_PDF)
	@echo "==> Launching $(VIEWER)..."
	$(VIEWER) $(PRIMARY_PDF) &

view: preview

# Continuous live-reload preview
watch:
ifneq ($(LATEXMK),)
	@echo "==> Starting continuous watch mode with latexmk -pvc..."
	latexmk -pvc $(PRIMARY_SRC)
else
	@echo "==> Watch mode requires latexmk."
endif

clean:
ifneq ($(LATEXMK),)
	@echo "==> Cleaning with latexmk -C..."
	latexmk -C
endif
	@echo "==> Cleaning intermediate build artifacts..."
	rm -rf $(BUILD_DIR) *.aux *.log *.out *.synctex.gz *.fdb_latexmk *.fls *.xdv *.png *.pbm
	@echo "==> Clean complete."
