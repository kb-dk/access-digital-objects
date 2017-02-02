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

These APIs are work in progress. There are two kinds of services (and hence servers)

* search service
* snippet service

The meaning of search service is obvious, the snippet service is less so.
Snippet server is our internal nick name of a set of web services that retrieves, transforms and delivers text content to the frontend.

The search service is not described yet, basically because it is not available outside the applications.
That will change, hopefully really soon.
The search system is based on [SOLR & Lucene](http://lucene.apache.org/solr/).

### Links to related thinking

* http://www.dlib.org/dlib/march99/maly/03maly.html
* http://people.virginia.edu/~jmu2m//Kings.5-00/primitives.html
* http://sigfrid-lundberg.se/2008/dighum/digital_humanities.xml
* http://sigfrid-lundberg.se/2002/Laurentius/laurentius.pdf
* http://iiif.io/api/presentation/2.1/
* http://iiif.io/api/search/1.0/

## Text encoding

Most texts are from collected works and are critical editions.
All data and metadata available are in XML markup according Text Encoding Initiative, TEI, [Guidlines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/).

### The work

Our ADL service uses a work concept developed together with the original
service som 15 years ago by experienced reference librariance. It is
completely pragmatic and related to what their needs were when helping patrons by
providing pointers to texts in the information desk.

There the most common questions about literature were about

* individual poems, songs and psalms
* individual short stories
* novels and other longer pieces of prose (basically: "books")
* plays

With the exception for novels, most of these works are text fragments inside volumes, the unit delivered by the circulation desk.


After discussions in the [TEI listserv,
TEI-L](https://listserv.brown.edu/archives/cgi-bin/wa?A1=ind1408&L=TEI-L#2)
it seems that the simplest and most correct way seems to be to use
[the decls
attribute](http://www.tei-c.org/Vault/P5/2.5.0/doc/tei-p5-doc/en/html/CC.html#CCAS2)
which was suggested by [Lou
Bournard](https://listserv.brown.edu/archives/cgi-bin/wa?A2=ind1408&L=TEI-L&F=&S=&P=58469).

Just about any structure in the text can be used as a __work__, by
giving it a decls attribute which is an _idref_ pointing to a bibl or
biblStruct by it's _xml:id_ somewhere in sourceDesc in the teiHeader. The markup will
look like

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

### Anchors, searchability and retrievability

The XML text documents pass through a number of procedures before
entering the system. The most important one is to add an xml:id
attibute to each element in a document that has not got one to begin
with. Each element in the texts is then possible to use as an anchor
for linking. For building a [cool
service](https://www.w3.org/Provider/Style/URI.html) based on these
documents, their names must never be changed, nor must the xml:id.

There are TEI elements that containers and those that are empty. When
indexing we concentrate on the latter, since they are the ones that we
need to search. There are a very important class of empty elements
called milestones, and the most important one is presumably page
break, at least in a digitisation project.

The indexing system (which you cannot use just yet see above), creates
records corresponding to three levels

* volume
* work
* text item

where volume and work is defined as described above.

Text item is indexed in a way that a search result can address a single

* paragraph of prose
* strophe in poetry 
* speech in a play

Typically one volume contributes (obviously) one volume record, one to
dozens of work records and houndreds or thousands of text items.
The records for works and text items import basic metadata and includes

## API for our texts

Most Snippet Server scripts support the following arguments

* doc -- the name of the document to be rendered or transformed
* op, targetOp  -- is the operation to be performed upon the document doc, targetOp is the operation to be performed in links inside the service. Possible values of op and targetOp are
  * 'render' which implies that doc is transformed into HTML. 
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=render
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=render&q=samlede with an argument q giving a search string to be highlighted in the text, in this case _samlede_
  * 'solrize' which returns a solr <add> ... </add> which is ready to be sent to SOLR. C.f., http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=solrize
  * 'facsimile' which returns a HTML document with images of the pages. Since we introduced OSD, it is only used for PDF generation. http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=facsimile
  * 'toc' returns a HTML table of contents 
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=toc 
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=toc&targetOp=render 
* id  -- the id of a part inside the doc which is to be treated. 
* q -- assuming that 'q' is the query, the present.xq is labelling the hits in the text

Some more examples

* Holberg, vol 3, HTML: http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=render
* Den politiske Kandstøber, Actus II http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=render&id=idm140583366846000
* A single 'speak' in that play, 
  * as HTML http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=render&id=idm140583366681648
  * or as SOLR doc http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=solrize&id=idm140583366681648
* A TOC for a small work http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=toc&targetOp=render&id=workid59384
