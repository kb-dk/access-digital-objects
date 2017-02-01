[README](README.md) - [Dissemination](oai-pmh.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md) - [Text Corpora](text-corpora.md)

# Access to text search, retrieval etc

The Royal Danish Library provide access to some text and language
resources. The text APIs are entirely new and demonstrate programmatic
access to services like

* [Archive for Danish Literature, ADL](http://www.adl.dk/). The APIs
  described in this document apply to this data set, but the new
  service are not even released yet.
* [Danmark's Breve](http://danmarksbreve.kb.dk/) use the basically the
  same APIs, but we have not decided to release the API on this data
  set.

The APIs described here are provided with similar
[caveats](README.md#caveats) and [legal restrictions](README.md#licences--legalese) as the other services
described.

## Text encoding

Most texts are from collected works and are critical editions.
All data and metadata available are in XML markup according Text Encoding Initiative, TEI, [Guidlines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/).

Our services use a work concept developed together with the original
service som 15 years ago by experienced reference librariance. It is
completely heuristic and related to what their needs were when they provided pointers
to texts at the information desk:

At the information desk, the most common questions about literature were about

* individual poems, songs and psalms
* individual short stories
* novels and other longer pieces of prose (basically: ``books'')
* plays

With the exception for novels, most of these works are text fragments inside volumes.

After discussions in the [TEI listserv, TEI-L](https://listserv.brown.edu/archives/cgi-bin/wa?A1=ind1408&L=TEI-L#2) it seems that the simplest and most correct way seems to be to use  [the decls attribute](http://www.tei-c.org/Vault/P5/2.5.0/doc/tei-p5-doc/en/html/CC.html#CCAS2) which was suggested by [Lou Bournard](https://listserv.brown.edu/archives/cgi-bin/wa?A2=ind1408&L=TEI-L&F=&S=&P=58469).

Just about any structure in the text can be used as a __work__, by giving it a decls attribute which is an idref pointing to a bibl or biblStruct somewhere in sourceDesc in the teiHeader. The markup will look like

```
 <?xml version="1.0" encoding="UTF-8" ?>
 <TEI xmlns="http://www.tei-c.org/ns/1.0">
   <teiHeader>
     <fileDesc>
       <titleStmt>
 	<title>
 	</title>
       </titleStmt>
       <publicationStmt>
 	<publisher>
 	</publisher>
       </publicationStmt>
       <sourceDesc>
 	<listBibl>
 	  <bibl xml:id="bib101">
 	    <title>The name of the hymn</title>
 	    <author>The psalmist</author>
 	  </bibl>
 	</listBibl>
       </sourceDesc>
     </fileDesc>
   </teiHeader>
   <text>
     <body>
       <div decls="#bib101" >
 	<lg>
 	  <l>Angres det med ærlig Smerte,</l>
 	  <l>Vendes om med ydmyg Bøn,</l>
 	  <l>Kirken dog med Moder-Hjerte</l>
 	  <l>Favner den forlorne Søn!</l>
 	</lg>
       </div>
     </body>
   </text>
 </TEI>
```

### The whole is more than its parts

The TEI header is used for designating metadata for the whole volume.
Inside the volume there might be collections of short stories or poetry. These collections may or may not be __works__,
that may or may not contain poems, stories or whatever that are works.
the metadata to the parts it comprises, and
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
