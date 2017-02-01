[README](README.md) - [Dissemination](oai-pmh.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md) [Text Corpora](text-corpora.md)

# Access to text search, retrieval etc

The text APIs are entirely new and related to 

* [Archive for Danish Literature, ADL](http://www.adl.dk/)
* [Danmark's Breve](http://danmarksbreve.kb.dk/)

The Royal Danish Library provide access to some text and language
resources. The APIs described here are provided with similar caveats
and limitations as the other services described here.

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
