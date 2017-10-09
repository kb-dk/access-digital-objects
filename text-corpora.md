[READ ME](README.md) - [OAI Dissemination](oai-pmh.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md) - [Text Corpora](text-corpora.md)

# Access to web services for text search, retrieval and other operations

The Royal Danish Library provide access to some text and language
resources. Until recently these resources have been intended solely for
users coming to a site using a browser for searching, browsing and
reading.

Recently we have decided to complement these end user services with
various text APIs. We hope that they are useful for students and
scholars alike, and we also hope that this could seen as a
contribution to the discussions on what kind web services and what
APIs are useful within digital humanities and literary computing.

The text resources are

* [Archive for Danish Literature, ADL](http://www.adl.dk/). The APIs
  described in this document apply to this data set. The [literary texts used are available](https://github.com/Det-Kongelige-Bibliotek/public-adl-text-sources)
* [Danmark's Breve](http://danmarksbreve.kb.dk/) use the basically the
  same APIs, but we have not decided to release the API on this data
  set.

The APIs described here are provided with similar
[caveats](README.md#caveats) and [legal
restrictions](README.md#licences--legalese) as the other services
described, and like them, these APIs are work in progress as public
services. Also they are byproducts of our services and front ends.

There are two kinds of services (and thus servers hosting the corresponding APIs)

* text search service API
* text retrieval service API

The meaning of search service is obvious, the text retrieval service
is somewhat less so. _Snippet server_ is our internal nick name of a
set of web services that retrieves, transforms and delivers text
snippets to the front end or other components using it.

In order to be useful, the you need both search and retrieval APIs.
Then you may search and discover what works and snippets there are,
and retrieve and link to them.

## Text encoding

Most texts are from collected works and are critical editions.  All
data and metadata available are in XML markup according Text Encoding
Initiative, TEI,
[Guidelines](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/).

## Anchors, searchability and retrievability

The search system (which you cannot use just yet, see above), creates
records corresponding to three levels

* volume
* work
* text item

where volume and work is defined as described above. When indexing,
records are created taking

* metadata from the TEI header given the reference in the decls attribute
* text from the appropriate level, and below.

All work and text item records contain data on the xml:id of the
containing element and the xml:id page number of the preceding page
break.

The text items are indexed in a way that a search result can address a single

* paragraph of prose
* strophe in poetry 
* speech in a play

Please note that a strophe occurring inside speech are not recognised
as poetry.

Typically one volume contributes (obviously) one volume record, one to
dozens of work records and hundreds or thousands of text items.
The records for works and text items import basic metadata and includes

## Connecting text with facsimile

Our digital library have users interested in viewing the printed text,
if not for any other reason than for checking the original when there
is OCR errors.

## Text search

The search API is described in detail in a separate documents

* We use [SOLR for searching](https://cwiki.apache.org/confluence/display/solr/Searching)
* SOLR has its own [Common Query Parameters](https://cwiki.apache.org/confluence/display/solr/Common+Query+Parameters)
* We provide a [document about what search fields there are and how to use them](http://rawgit.com/Det-Kongelige-Bibliotek/access-digital-objects/master/form-demos/adl-form.html).

A search can be returned in json or xml format. Here is an example, where we search  for works

* which title contain Jerusalem
* that are writen by Gustaf Munch-Petersen

SOLR returns [JSON](http://public-index.kb.dk/solr/adl-core/select/?q=author_name_tesim%3AGustaf+Munch-Petersen%0D%0Aand%0D%0Acat_ssi%3Awork%0D%0Aand%0D%0Awork_title_tesim%3AJerusalem&wt=json&start=0&rows=10&defType=edismax&indent=on) or [XML](http://public-index.kb.dk/solr/adl-core/select/?q=author_name_tesim%3AGustaf+Munch-Petersen%0D%0Aand%0D%0Acat_ssi%3Awork%0D%0Aand%0D%0Awork_title_tesim%3AJerusalem&wt=xml&start=0&rows=10&defType=edismax&indent=on) and the returned is the same.

The simplest way to retrieve the data is to look for the url_ssi. In the example linked to it contains the value "texts/munp1.xml#workid72997", which is the concatenation of three variables

* collection (c) = texts
* document (doc) = munp1.xml
* id = workid72997

You can now construct the retrieval URI using the script present.xq and the three parameters:

* [http://labs.kb.dk/storage/adl/present.xq?c=texts&doc=munp1.xml&id=workid72997&op=render](http://labs.kb.dk/storage/adl/present.xq?c=texts&doc=munp1.xml&id=workid72997&op=render)
* [http://labs.kb.dk/storage/adl/present.xq?c=texts&doc=munp1.xml&id=workid72997&op=toc&targetOp=render](http://labs.kb.dk/storage/adl/present.xq?c=texts&doc=munp1.xml&id=workid72997&op=toc&targetOp=render)

More on what you can do with the text using the parameters below.

## Retrieval APIs for our texts

There are several text retrieval scripts in the Snippet Server.
[The source code is free](https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets).

We concentrate on two, present.xq. We use it for extracting snippets
and transforming them. The html produced is mere fragments that you
can include in your document just as you like it.

There is an alternative script, present-text.xq which does the same as
present.xq, except that it delivers the script as pure text.

Virtually all scripts work in a similarly, with the following arguments.

* doc -- the name of the document to be rendered or transformed. Here are some examples of doc names you can test
  * [hcaeventyr01val.xml](http://labs.kb.dk/storage/adl/texts/hcaeventyr01val.xml)
  * [hcaeventyr02val.xml](http://labs.kb.dk/storage/adl/texts/hcaeventyr02val.xml)
  * [munp1.xml](http://labs.kb.dk/storage/adl/texts/munp1.xml)
  * [munp2.xml](http://labs.kb.dk/storage/adl/texts/munp2.xml)
* op, targetOp  -- op is the operation to be performed upon the document doc, targetOp is the operation to be performed in links inside the service. Possible values of op and targetOp are
  * 'render' which implies that doc is transformed into HTML. 
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=render
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=render&q=samlede with an argument q giving a search string to be highlighted in the text, in this case _samlede_
  * 'solrize' which returns a solr <add> ... </add> document, which is ready to be sent to SOLR. C.f., http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=solrize
  * 'toc' returns a HTML table of contents 
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=toc If a 'toc' and a text generated through 'render' are included into one document, all internal links will work.
     * http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=toc&targetOp=render 
     note the targetOp=render, which makes the toc script generate links to the _render_ed version of the doc. This is good for testing.
* id  -- the id of a part inside the doc which is to be treated. 
* q -- assuming that 'q' is the query, the present.xq is labelling the hits in the text

Some more examples

* Holberg, vol 3, HTML: http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=render
* Holberg, vol 3, page 18: http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=render#s18
* The TOC of the Den politiske Kandstøber http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=toc&targetOp=render&id=workid54980
* The TOC of Den politiske Kandstøber, Actus II http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=toc&targetOp=render&id=idm140583366846000
* Den politiske Kandstøber, Actus II http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=render&id=idm140583366846000
* A single 'speak' in that play, 
  * as HTML http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=render&id=idm140583366681648
  * or as SOLR doc http://labs.kb.dk/storage/adl/present.xq?doc=holb03val.xml&op=solrize&id=idm140583366681648
* A TOC for a small work http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=toc&targetOp=render&id=workid59384
  * The page 27 (of the original volume) inside that work http://labs.kb.dk/storage/adl/present.xq?doc=aakjaer01val.xml&op=toc&targetOp=render&id=workid593843#s27

