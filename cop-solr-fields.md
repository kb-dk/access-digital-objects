# COP SOLR fields

The index is built for the purpose of making a single bibliographic search index on top of a heterogeneous collection.
It is built based on a much more fine grained description in MODS.
The index contains 

1. fields required by SOLR and related functions
2. fairly course grained fields having  [Dublin Core](http://dublincore.org/documents/dces/) or [ESE](http://pro.europeana.eu/page/ese-documentation) semantics
3. fine grained fields for access to some data in the MODS

The source, when given, is the xpath to where it is stored in the MODS

| field(s) | source | value examples | semantics | purpose |
|:---------|:-------|:----------|:--------|:--------|
| id | /md:mods/md:recordInfo/md:recordIdentifier |
| cataloging_language_ssi | /md:mods/md:recordInfo/md:languageOfCataloging/md:languageTerm | 'da' or 'en' | default language for strings in the record ||
| full_title_tsim | /md:mods/md:titleInfo/md:title || All titles concatenated |
| title_tesim, title_tdsim, title_tsim | /md:mods/md:titleInfo/md:title || Lists of all titles in English (tesim), Danish (tdsim) or other languages (tsim), respectively | Isn't used in any clever way |
| author_tsim, author_nasim, creator_tsim, creator_nasim, creator_tsi | /md:mods/md:name[md:role/md:roleTerm[@type='text']='creator' or md:role/md:roleTerm[@type='code']='cre' or md:role/md:roleTerm[@type='code']='aut']  || author and creator are synonymous | nasim is **untokenized** and tsim **tokenized** text. The tsi fields contain the **first** instance of the field in the MODS record |
| contributor_tesim, contributor_tdsim, contributor_tsim, contributor_tsi |  DC translation of the MODS name roles||| the tsi fields contain the **first** instance of the field in the MODS record |
| publisher_tesim, publisher_tdsim, publisher_tsim, publisher_tsi |  DC translation of the MODS  name roles||| the tsi fields contain the **first** instance of the field in the MODS record |
| medium_ssi | Record ID | images, letters, maps, manus, pamphlets, books, editions, categories |
| description_tesim, description_tdsim, description_tsim  | DC translation of the MODS |
| format_tesim, format_tdsim, format_tsim | DC translation of the MODS |
| type_tesim, type_tdsim, type_tsim | DC translation of the MODS |
| language_tsim |  DC translation of the MODS | Usually a RFC 4646 language tag |
| rights_tsim |  DC translation of the MODS | Usually link to the appropriate CC license | 
| coverage_tsim |  DC translation of the MODS | Can be place names, or lat log for aerial photography |
| subject_tsim |  DC translation of the MODS |

 

 



