[README](README.md) - [Dissemination](oai-pmh.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md) - [Text Corpora](text-corpora.md)

# Access to text search, retrieval etc

The Royal Danish Library provide access to some text and language resources. The text APIs are entirely new and demonstrate programmatic access to services like

* [Archive for Danish Literature, ADL](http://www.adl.dk/). The APIs described in this document apply to this data set, but the new service are not even released yet.
* [Danmark's Breve](http://danmarksbreve.kb.dk/) use the basically the same APIs, but we have not decided to release the API on this data set.

The APIs described here are provided with similar
[caveats](README.md#caveats) and [legal restrictions](README.md#licences--legalese) as the other services
described.

## Text encoding

The texts available are in []

### TEI Metadata

This document does not prescribe any specific constraints for the [http://www.tei-c.org/release/doc/tei-p5-doc/en/html/HD.html TEI header]. Any TEI application should have a valid TEI header from which it is possible to extract a valid Chronos metadata set.

The aim of this is to describe how to indicate that a segment of text inside a larger corpus indeed is a work.

### Collected Works and Anthologies

The texts in ADL are from collections many of which were produced by DSL. 

The correct way to handle collections or anthologies is structure the  texts are usually structured using &lt;group&gt; elements. There are good examples in the Guidlines, eg the one based on   [http://www.tei-c.org/release/doc/tei-p5-doc/en/html/DS.html#DSGRP ''The Adventures of Sherlock Holmes'']. Hence this practice applies to "traditional" works, where title are defined as in the original version of DCMI metadata: [https://tools.ietf.org/html/rfc2413#page-3 ''The name given to the resource, usually by the Creator or Publisher'']

The document will be structured as follows

 &lt;TEI xmlns="http://www.tei-c.org/ns/1.0">
  &lt;teiHeader>
 &lt;!-- .... -->
  &lt;/teiHeader>
  &lt;text>
   &lt;front>
 &lt;!-- front matter for composite text -->
   &lt;/front>
   &lt;group>
    &lt;text>
     &lt;front>
 &lt;!-- front matter of first unitary text, if any -->
     &lt;/front>
     &lt;body>
 &lt;!-- body of first unitary text -->
     &lt;/body>
     &lt;back>
 &lt;!-- back matter of first unitary text, if any -->
     &lt;/back>
    &lt;/text>
    &lt;text>
     &lt;body>
 &lt;!-- body of second unitary text -->
     &lt;/body>
    &lt;/text>
   &lt;/group>
  &lt;back>
 &lt;!-- back matter for composite text, if any -->
   &lt;/back>
  &lt;/text>
 &lt;/TEI>

== Works with supplied or uniform titles ==

There are other needs for works, which are related to a class of interesting and important use cases arising through the requirements for the provision of access to digital resources. I.e., text fragment like objects, such as poems, short stories, even parts of novels (individual chapters or other more or less arbitrary text segments) may need independent dissemination because that is the way they are used. In the case of ADL, this is mainly the case for poetry, songs and psalms. 

After discussions in [https://listserv.brown.edu/archives/cgi-bin/wa?A1=ind1408&L=TEI-L#2 TEI-L] it seems that the simplest and most correct way seems to be to use  [http://www.tei-c.org/Vault/P5/2.5.0/doc/tei-p5-doc/en/html/CC.html#CCAS2 decls attribute] which was suggested by [https://listserv.brown.edu/archives/cgi-bin/wa?A2=ind1408&L=TEI-L&F=&S=&P=58469 Lou Bournard].

Just about any structure in the text can be used as a '''work''', by giving it a decls attribute which is an idref pointing to a bibl or biblStruct somewhere in sourceDesc in the teiHeader. The markup will look like

 &lt;?xml version="1.0" encoding="UTF-8" ?>
 &lt;TEI xmlns="http://www.tei-c.org/ns/1.0">
   &lt;teiHeader>
     &lt;fileDesc>
       &lt;titleStmt>
 	&lt;title>
 	&lt;/title>
       &lt;/titleStmt>
       &lt;publicationStmt>
 	&lt;publisher>
 	&lt;/publisher>
       &lt;/publicationStmt>
       &lt;sourceDesc>
 	&lt;listBibl>
 	  &lt;bibl xml:id="bib101">
 	    &lt;title>The name of the hymn&lt;/title>
 	    &lt;author>The psalmist&lt;/author>
 	  &lt;/bibl>
 	&lt;/listBibl>
       &lt;/sourceDesc>
     &lt;/fileDesc>
   &lt;/teiHeader>
   &lt;text>
     &lt;body>
       &lt;div decls="#bib101" >
 	&lt;lg>
 	  &lt;l>Angres det med ærlig Smerte,&lt;/l>
 	  &lt;l>Vendes om med ydmyg Bøn,&lt;/l>
 	  &lt;l>Kirken dog med Moder-Hjerte&lt;/l>
 	  &lt;l>Favner den forlorne Søn!&lt;/l>
 	&lt;/lg>
       &lt;/div>
     &lt;/body>
   &lt;/text>
 &lt;/TEI>

### The whole is more than its parts

Note that the various methods will be used together. 

The TEI header is used for designating metadata for the whole volume, 
the &lt;group&gt; for designating metadata to the parts it comprises, and
finally, the fine granularity metadata arising through curatorial procedures are asigned using the decls attribute as described


## API for our texts

Most Snippet Server scripts support the following arguments

* doc -- the name of the document to be rendered or transformed
* c   -- if there are more sub-collections inside the data set, c is the name of the dirctory where doc is to be retrieved. Default is 'texts' for ADL, other are 'periods' and 'authors'
* op  -- is the operation to be performed upon the document doc. Possible op are
  * 'render' which implies that doc is transformed into HTML. http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=aakjaer01val.xml&op=render
  * 'solrize' which returns a solr <add> ... </add> which is ready to be sent to SOLR. C.f., http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=aakjaer01val.xml&op=solrize
  * 'facsimile' which returns a HTML document with images of the pages. Since we introduced OSD, it is only used for PDF generation. http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=aakjaer01val.xml&op=facsimile
  * 'toc' returns a HTML table of contents http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=aakjaer01val.xml&op=toc 
* id  -- the id of a part inside the doc which is to be treated. 
* q -- assuming that 'q' is the query, the present.xq is labelling the hits in the text

Some more examples

* Holberg, vol 3, HTML: http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=holb03val.xml&op=render
* Den politiske Kandstøber, Actus II http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=holb03val.xml&op=render&id=idm140583366846000
* A single 'speak' in that play, 
  * as HTML http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=holb03val.xml&op=render&id=idm140583366681648
  * or as SOLR doc http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=holb03val.xml&op=solrize&id=idm140583366681648
* A TOC for a small work http://bifrost-test-01.kb.dk:8080/exist/rest/db/adl/present.xq?doc=aakjaer01val.xml&op=toc&id=workid59384
