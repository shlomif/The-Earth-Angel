STORY = The-Earth-Angel
HEB_STORY = $(STORY)-hebrew
ENG_STORY = $(STORY)-english

include $(SCREENPLAY_COMMON_INC_DIR)/fictions_common.mak

ENG_DB_POST_PROCESSED = $(ENG_STORY).postproc-db5.xml

$(DOCS_FICTION_DB5): %.db5.xml: %.fiction-xml.xml
	perl -MXML::Grammar::Fiction::App::ToDocBook -e 'run()' -- \
		-o $@ $<

$(ENG_DB_POST_PROCESSED): $(ENG_DB_PROCESSED) $(DB5_TO_DB5_XSLT)
	xsltproc -o $@ $(DB5_TO_DB5_XSLT) $(ENG_DB_PROCESSED)

$(ENG_EPUB) : $(ENG_DB_POST_PROCESSED)
	$(JING) $<
	ruby $(EPUB_SCRIPT) -s $(ENG_EPUB_XSLT) -o $@ $<
