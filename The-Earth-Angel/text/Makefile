STORY = The-Earth-Angel
HEB_STORY = $(STORY)-hebrew
ENG_STORY = $(STORY)-english

include $(SCREENPLAY_COMMON_INC_DIR)/fictions_common.mak

ENG_DB_POST_PROCESSED = $(ENG_STORY).postproc-db5.xml

$(DOCS_FICTION_DB5): %.db5.xml: %.fiction-xml.xml
	perl -MXML::Grammar::Fiction::App::ToDocBook -e 'run()' -- \
		-o $@ $<

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
