# COP COLR fields

The index is built for the purpose of making a single bibliographic search index on top of a heterogeneous collection.
It is built based on a much more fine grained description in MODS.
The index contains 

1. fields required by SOLR and related functions
2. fairly course grained fields having Dublin Core or ESE semantics
3. fine grained fields for access to some data in the MODS

The source, when given, is the xpath to where it is stored in the MODS

| field(s) | source | value examples | semantics | purpose |
|:---------|:-------|:----------|:--------|:--------|
| id | /md:mods/md:recordInfo/md:recordIdentifier |
| cataloging_language_ssi | /md:mods/md:recordInfo/md:languageOfCataloging/md:languageTerm | 'da' or 'en' | default language for strings in the record ||
| full_title_tsim | /md:mods/md:titleInfo/md:title || All titles concatenated |
| title_tesim, title_tdsim, title_tsim | /md:mods/md:titleInfo/md:title | Lists of all titles in English (tesim), Danish (tdsim) or other languages (tsim) | Isn't used in any clever way |
| author_tsim, author_nasim, creator_tsim, creator_nasim | /md:mods/md:name[md:role/md:roleTerm[@type='text']='creator' or 
md:role/md:roleTerm[@type='code']='cre' or
md:role/md:roleTerm[@type='code']='aut']  |



