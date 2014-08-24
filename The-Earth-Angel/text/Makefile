STORY = The-Earth-Angel
HEB_STORY = $(STORY)-hebrew
ENG_STORY = $(STORY)-english

include $(SCREENPLAY_COMMON_INC_DIR)/fictions_common.mak

ENG_DB_POST_PROCESSED = $(ENG_STORY).postproc-db5.xml

DOCBOOK5_XSL_STYLESHEETS_PATH := $(HOME)/Download/unpack/file/docbook/docbook-xsl-ns-snapshot

HOMEPAGE := $(HOME)/Docs/homepage/homepage/trunk
DOCBOOK5_XSL_STYLESHEETS_XHTML_PATH := $(DOCBOOK5_XSL_STYLESHEETS_PATH)/xhtml
DOCBOOK5_XSL_STYLESHEETS_FO_PATH := $(DOCBOOK5_XSL_STYLESHEETS_PATH)/fo
DOCBOOK5_XSL_CUSTOM_XSLT_STYLESHEET := $(HOMEPAGE)/lib/sgml/shlomif-docbook/xsl-5-stylesheets/shlomif-essays-5-xhtml-onechunk.xsl
DOCBOOK5_XSL_CUSTOM_FO_XSLT_STYLESHEET := $(HOMEPAGE)/lib/sgml/shlomif-docbook/xsl-5-stylesheets/shlomif-essays-5-fo.xsl

all: $(DOCS_FICTION_XHTML) $(ENG_EPUB) $(ENG_HTML_FOR_OOO)

odt: $(DOCS_FICTION_ODT)

upload:
	rsync -v --progress -a $(FILES) $${HOMEPAGE_SSH_PATH}/$(THE_ENEMY_DEST)/

$(DOCS_FICTION_DB5): %.db5.xml: %.fiction-xml.xml
	perl -MXML::Grammar::Fiction::App::ToDocBook -e 'run()' -- \
		-o $@ $<

$(DOCS_FICTION_XML): %.fiction-xml.xml: %.fiction-text.txt
	perl -MXML::Grammar::Fiction::App::FromProto -e 'run()' -- \
	-o $@ $<

DOCS_FICTION_XHTML__HEB = $(filter %-hebrew.fiction-text.xhtml,$(DOCS_FICTION_XHTML))
DOCS_FICTION_XHTML__ENG = $(filter %-english.fiction-text.xhtml,$(DOCS_FICTION_XHTML))

$(DOCS_FICTION_XHTML__HEB): %.fiction-text.xhtml: %.db5.xml
	xsltproc --stringparam root.filename $@ \
		--stringparam html.stylesheet "style-heb.css" \
		--path $(DOCBOOK5_XSL_STYLESHEETS_XHTML_PATH) \
		-o $@ \
		$(DOCBOOK5_XSL_CUSTOM_XSLT_STYLESHEET) $<
	mv -f $@.html $@

$(DOCS_FICTION_XHTML__ENG): %.fiction-text.xhtml: %.db5.xml
	xsltproc --stringparam root.filename $@ \
		--path $(DOCBOOK5_XSL_STYLESHEETS_XHTML_PATH) \
		-o $@ \
		$(DOCBOOK5_XSL_CUSTOM_XSLT_STYLESHEET) $<
	mv -f $@.html $@

$(DOCS_FICTION_FO): %.fiction-text.fo : %.db5.xml
	xsltproc --stringparam root.filename $@ \
		--stringparam html.stylesheet "style-heb.css" \
		--path $(DOCBOOK5_XSL_STYLESHEETS_FO_PATH) \
		-o $@ \
		$(DOCBOOK5_XSL_CUSTOM_FO_XSLT_STYLESHEET) $<

$(DOCS_FICTION_RTF): %.rtf: %.fo
	fop -fo $< -rtf $@

rtf: $(DOCS_FICTION_RTF)

$(DOCS_FICTION_ODT): $(DOCS_FICTION_DB5)
	docbook2odf $< -o $@

# DOCBOOK_RNG = http://www.docbook.org/xml/5.0/rng/docbook.rng

DOCBOOK_RNG = ./rng/docbook.rng

JING = jing $(DOCBOOK_RNG)

# XSL_SNAPSHOT_HOME = $(HOME)/Download/unpack/file/docbook/docbook-xsl-ns-snapshot
XSL_SNAPSHOT_HOME = $(HOME)/Download/unpack/file/docbook/docbook-xsl-snapshot/

EPUB_SCRIPT = $(XSL_SNAPSHOT_HOME)/epub/bin/dbtoepub

DB5_TO_DB5_XSLT = docbook-to-docbook.xslt

$(ENG_DB_POST_PROCESSED): $(ENG_DB_PROCESSED) $(DB5_TO_DB5_XSLT)
	xsltproc -o $@ $(DB5_TO_DB5_XSLT) $(ENG_DB_PROCESSED)

$(ENG_EPUB) : $(ENG_DB_POST_PROCESSED)
	$(JING) $<
	ruby $(EPUB_SCRIPT) -s $(ENG_EPUB_XSLT) -o $@ $<

$(DOCS_FICTION_HTML_FOR_OOO): %.for-openoffice.html: %.xhtml
	cat $< | perl -lne 's{(</title>)}{$${1}<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />}; print unless m{\A<\?xml}' > $@

oohtml: $(ENG_HTML_FOR_OOO) $(HEB_HTML_FOR_OOO)

openoffice: oohtml
	ooffice3.2 $(ENG_HTML_FOR_OOO)

.PHONY: epub_ff

epub: $(ENG_EPUB)

epub_ff: epub
	firefox $(ENG_EPUB)

epub_ok: epub
	okular $(ENG_EPUB)

%.show:
	@echo "$* = $($*)"

clean:
	rm -f $(DOCS_FICTION_XHTML) $(DOCS_FICTION_XML) $(DOCS_FICTION_DB5)
