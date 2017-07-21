# COP SOLR fields

The index is built for the purpose of making a single bibliographic search index on top of a heterogeneous collection.
It is built based on a much more fine grained description in MODS.
The index contains 

1. fields required by SOLR and related functions
2. fairly course grained fields having  [Dublin Core](http://dublincore.org/documents/dces/), [ESE](http://pro.europeana.eu/page/ese-documentation) semantics or TEI semantics
3. fine grained fields for access to some data in the MODS

__NB:__ The fields here are also available for use through [COP web services](cop-backend.md)

The source, when given, is the xpath to where it is stored in the
MODS. In the xpaths we occasionally refer to xml namespace for mods
(md), dc and xhtml (h).

## Global fields 

| field(s) | source | Comments |
|:---------|:-------|:---------|
| id || as everywhere else ;) |
| medium_ssi | Record ID | For resources images, letters, maps, manus, pamphlets, books. Then medium_ssi can be editions and categories for whole collections and subject areas, respectively |

medium_ssi is categories, editions we can retrieve information about topics and collections respectively;
the remaining medium_ssi values return to actual resources.

## Edition fields 

| field(s) | source | Comments |
|:---------|:-------|:---------|
| id || as everywhere else ;) |
| medium_ssi || Always 'editions' for editions, what else could it be? |
| name_ssi, name_en_ssi || Name of the edition in Danish and English respectively |
| top_cat_ssi || Category ID of the subject being the root of the editions subject tree |  
| description_tdsim, description_tesim || Sequence of paragraphs descripting the resource in Danish and English, respectively | 
| collection_da_ssi, collection_en_ssi || The name of the library collection from where the edition emanates |
| department_da_ssi, department_en_ssi || The the English and Danish names of the organisational unit whithin the library responsible for that collection |
| contact_email_ssi || Contact information for that unit | 

## Category fields 

| field(s) | source | Comments |
|:---------|:-------|:---------|
| id | /md:mods/md:recordInfo/md:recordIdentifier | The record ID as given in the MODS record |
| medium_ssi || Always 'categories' for subject matter. Surprised? |
| parent_ssi || id of parent node in the tree
| node_tdsi || Danish name of the node
| node_tesi || English name of the node
| bread_crumb_ssim || array of category ids starting from the parent_ssi, through to the id of the edition |

## Fields for COP and Aerial photography resources

| field(s) | source | Comments |
|:---------|:-------|:---------|
| cataloging_language_ssi | /md:mods/md:recordInfo/md:languageOfCataloging/md:languageTerm | 'da' or 'en', i.e., the  default language for strings in the record |
| full_title_tsim | /md:mods/md:titleInfo/md:title | All titles concatenated |
| title_tesim, title_tdsim, title_tsim | /md:mods/md:titleInfo/md:title | Lists of all titles in English (tesim), Danish (tdsim) or other languages (tsim), respectively. Isn't used in any clever way |
| author_tsim, author_nasim, creator_tsim, creator_nasim, creator_tsi | /md:mods/md:name[md:role/md:roleTerm[@type='text']='creator' or <br> md:role/md:roleTerm[@type='code']='cre' or <br> md:role/md:roleTerm[@type='code']='aut']  | Author and creator are synonymous. nasim is **untokenized** and tsim **tokenized** text. The tsi fields contain the **first** instance of the field in the MODS record |
| contributor_tesim, contributor_tdsim, contributor_tsim, contributor_tsi, contributor_nasim |  DC translation of the MODS name roles| The tsi fields contain the **first** instance of the field in the MODS record |
| publisher_tesim, publisher_tdsim, publisher_tsim, publisher_tsi, publisher_nasim | MODS  | Currently not used because of the nature of the collections in the service |
| description_tesim, description_tdsim, description_tsim  | DC translation of the MODS descriptions |
| format_tesim, format_tdsim, format_tsim | DC translation of the MODS |
| type_tesim, type_tdsim, type_tsim | DC translation of the MODS | **messy** |
| dc_type_tesim, dc_type_tdsim, dc_type_tsim | Translated directly from MODS | **messy** |
| language_tsim |  DC translation of the MODS | Usually a RFC 4646 language tag |
| rights_tsim |  DC translation of the MODS | Usually link to the appropriate CC license | 
| coverage_tdsim, coverage_tesim |  DC translation of the MODS | Can be place names |
| dcterms_spatial |  DC translation of the MODS | lat long, especially for aerial photography |
| subject_tesim, subject_tdsim, subject_tsim |  DC translation of the MODS |
| pub_dat_tsim || Buggy |
| readable_dat_string_tsim || Buggy |
| local_id_ssi, local_id_fngsi | image URI | ID containing image file name. Use for connecting image to physical instance |
| shelf_mark_tdsim, shelf_mark_tesim | | How to find the physical instance |
| subject_topic_id_ssim | /md:mods/md:extension/h:div/h:a/@h:href | The list of IDs of the categories a given resource belong to |
| subject_topic_facet_tesim, subject_topic_facet_tdsim | /md:mods/md:extension/h:div/h:a | The list of names of the categories a given resource belong to. The categories are either in Danish (tdsim) or English (tesim) |
| mods_ts, processed_mods_ts || original XML blobs. processed_mods_ts is the complete one with some keywords and descriptions from external databases |
| thumbnail_square_url_ssm || An array of one square image URI for the resource |
| thumbnail_url_ssm || An array of one image URI for the resource |
| content_metadata_image_iiif_info_ssm || An array with URIs for images of all pages in a multipage document. See [Image delivery](image-delivery.md#constructing-iiif-uris)  |
| cobject_not_before_dtsi | /md:mods/md:originInfo/md:dateCreated/@t:notBefore | [Using TEI date model](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-date.html) |
| cobject_not_after_dtsi | /md:mods/md:originInfo/md:dateCreated/@t:notAfter | [Using TEI date model](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-date.html) |
| cobject_edition_ssi | assigned during ingest |
| cobject_title_ssi | extracted from MODS during ingest |
| cobject_id_ssi || synonym to id |
| cobject_person_tsim, cobject_person_ssim | /md:mods/md:name[@type='personal']/md:namePart | Name of persons regardless of their relation to the work |
| cobject_location_tsi, cobject_location_tsim, cobject_location_ssim | /md:mods/md:subject/md:geographic/md:location | Place as a subject |
| cobject_random_number_dbsi | generated on database ingest | used for various sorting and selection tasks |

### Fields added for Spotlight exhibitions

| spotlight_exhibition_ssi || The name the exhibition in which the object appear. |

### Crowd sourced fields in Aerial photography

| field(s) | source | Comments |
|:---------|:-------|:---------|
| luftfo_type_ssim, luftfo_type_tdsim |
| cobject_bookmark_ssi || currently not used|
| cobject_building_ssim, cobject_building_tsim || Name of a building |
| cobject_correctness_isi || Indicator of whether crowd sourcing is pending (0) or completed (1) |
| cobject_interestingness_isi || An integer [0.. 10] indicating how much interest or effort the object has generated among users |
| cobject_last_modified_lsi || Long integer. Unix date |
| area_area_tsim | Encoded as a hierarchicalGeographic subject in MODS. See Appendix below. | Usually a comma seperated list of places from more general to more specific like "Danmark, Sjælland, Arnøje" which together specifies a place. |
| area_cadastre_tsim | See Appendix below | matrikelnummer in Denmark |
| area_parish_tsim | See Appendix below | Sogn in Denmark |
| area_building_tsim | See Appendix below | Overlaps with cobject_building_ssim above, but seems to be more precise |
| citySection_zipcode_tsim | See Appendix below | Postnummer |
| citySection_housenumber_tsim | See Appendix below |
| citySection_street_tsim | See Appendix below |




### Appendix: Hierarchical geographic subject
```
    <md:subject xml:lang="da">
      <md:hierarchicalGeographic>
        <md:area areaType="area" displayLabel="lokalitet">Havrebjerg</md:area>
        <md:area areaType="cadastre" displayLabel="matrikelnummer">34</md:area>
        <md:area areaType="parish" displayLabel="sogn">Havrebjerg</md:area>
        <md:area areaType="building" displayLabel="Bygningsnavn">Havrebjerg Brugsforening</md:area>
        <md:citySection citySectionType="zipcode" displayLabel="postnummer">4200</md:citySection>
        <md:citySection citySectionType="housenumber" displayLabel="husnummer">69</md:citySection>
        <md:citySection citySectionType="street" displayLabel="vejnavn">Krænkerupvej</md:citySection>
        <md:city>Slagelse</md:city>
      </md:hierarchicalGeographic>
    </md:subject>
```