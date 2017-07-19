# COP SOLR fields

The index is built for the purpose of making a single bibliographic search index on top of a heterogeneous collection.
It is built based on a much more fine grained description in MODS.
The index contains 

1. fields required by SOLR and related functions
2. fairly course grained fields having  [Dublin Core](http://dublincore.org/documents/dces/) or [ESE](http://pro.europeana.eu/page/ese-documentation) semantics
3. fine grained fields for access to some data in the MODS

The source, when given, is the xpath to where it is stored in the
MODS. In the xpaths we occasionally refer to xml namespace for mods
(md), dc and xhtml (h).

| field(s) | source | value examples | semantics | purpose |
|:---------|:-------|:----------|:--------|:--------|
| id | /md:mods/md:recordInfo/md:recordIdentifier |
| cataloging_language_ssi | /md:mods/md:recordInfo/md:languageOfCataloging/md:languageTerm | 'da' or 'en' | default language for strings in the record ||
| full_title_tsim | /md:mods/md:titleInfo/md:title || All titles concatenated |
| title_tesim, title_tdsim, title_tsim | /md:mods/md:titleInfo/md:title || Lists of all titles in English (tesim), Danish (tdsim) or other languages (tsim), respectively | Isn't used in any clever way |
| author_tsim, author_nasim, creator_tsim, creator_nasim, creator_tsi | /md:mods/md:name[md:role/md:roleTerm[@type='text']='creator' or <br> md:role/md:roleTerm[@type='code']='cre' or <br> md:role/md:roleTerm[@type='code']='aut']  || author and creator are synonymous | nasim is **untokenized** and tsim **tokenized** text. The tsi fields contain the **first** instance of the field in the MODS record |
| contributor_tesim, contributor_tdsim, contributor_tsim, contributor_tsi |  DC translation of the MODS name roles||| the tsi fields contain the **first** instance of the field in the MODS record |
| publisher_tesim, publisher_tdsim, publisher_tsim, publisher_tsi |  DC translation of the MODS  name roles||| the tsi fields contain the **first** instance of the field in the MODS record |
| medium_ssi | Record ID | images, letters, maps, manus, pamphlets, books, editions, categories |
| description_tesim, description_tdsim, description_tsim  | DC translation of the MODS |
| format_tesim, format_tdsim, format_tsim | DC translation of the MODS |
| type_tesim, type_tdsim, type_tsim | DC translation of the MODS |
| language_tsim |  DC translation of the MODS | Usually a RFC 4646 language tag |
| rights_tsim |  DC translation of the MODS | Usually link to the appropriate CC license | 
| coverage_tsim |  DC translation of the MODS | Can be place names, or lat log for aerial photography |
| dcterms_spatial |  DC translation of the MODS | Can be place names, or lat log for aerial photography |
| subject_tesim, subject_tdsim, subject_tsim |  DC translation of the MODS |
| pub_dat_tsim | | Buggy |
| readable_dat_string_tsim | | Buggy |
| local_id_ssi, local_id_fngsi | image URI | ID containing image file name. Use for connecting image to physical instance |
| shelf_mark_tdsim, shelf_mark_tesim | | How to find the physical instance |
| subject_topic_id_ssim | /md:mods/md:extension/h:div/h:a/@h:href | The list of IDs of the categories a given resource belong to |
| subject_topic_facet_tesim, subject_topic_facet_tdsim | /md:mods/md:extension/h:div/h:a | The list of names of the categories a given resource belong to. The categories are either in Danish (tdsim) or English (tesim) |
| mods_ts, processed_mods_ts || original XML blobs. processed_mods_ts is the complete one with some keywords and descriptions from external databases |
| content_metadata_image_iiif_info_ssm || An array with URIs for images of all pages in a multipage document. See [Image delivery](image-delivery.md#constructing-iiif-uris)  |

 

 



