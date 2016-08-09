BUILD_DIR := output
PANDOC := pandoc

BIBLIO := "/Users/jiri/Documents/Bookshelf/Papers/library.bib"
CSL  = "apa.csl"
REFERENCE_DOC := "reference.docx"

PANDOC_DOCX_OPTS := --reference-docx $(REFERENCE_DOC) --bibliography=$(BIBLIO) --csl=$(CSL)
# pandoc 11 -s -o %s

MANUSCRIPT := $(wildcard [^~]*.md)
DOCX := $(patsubst %.md,$(BUILD_DIR)/%.docx,$(MANUSCRIPT))
PDF  := $(patsubst %.md,$(BUILD_DIR)/%.pdf,$(MANUSCRIPT))

.PHONY: all checkdirs clean pdf docx

all: checkdirs $(DOCX)

docx: checkdirs $(DOCX)

pdf: checkdirs $(PDF)

checkdirs: $(BUILD_DIR)

$(BUILD_DIR):
		@mkdir -p $@

$(BUILD_DIR)/%.docx: %.md
		$(PANDOC) $< -s -o $@ $(PANDOC_DOCX_OPTS)

$(BUILD_DIR)/%.pdf: %.md
		$(PANDOC) $< -s -o $@ $(PANDOC_DOCX_OPTS)

clean:
		@rm -rf $(BUILD_DIR)
