# Access digital objects!

The Library has been digitizing Cultural Heritage Objects in its
collections since well over two decades. More recently, the last 6-7
years, we have tried to build our dissemination platforms using a REST
based architecture. This collection of documents describes the various
APIs we are using ourselves, in the hope that the access points could
be useful for a new category library patron whose research or studies
would benefit from prammatic access to our collections.


## Licences & Legalese

The documention here is provided as is, and mind you: __Everything
that's free comes with no guarantee__. As a matter of fact the material
in __this git repository__ is licensed to you as [GNU Free Documentation License](LICENSE)

The material we __provide access to using the APIs described__ are of two kinds:

1. Metadata: This comes to you as [CC0 1.0
Universal](https://creativecommons.org/publicdomain/zero/1.0/). I.e.,
our metadata is basically public domain.

2. Content: The content in our digital collections are delivered with
varous licenses, but the most common one is
[Attribution-NonCommercial-NoDerivs 2.0
Generic](https://creativecommons.org/licenses/by-nc-nd/2.0/)

## Caveats

The APIs described have used by us for many years. We, the developers,
created each of them for getting a job done. They are usually well
tested and works well, but they certainly not polished and neither are
there any helpful error messages etc.

The formats we are delivering are to a large extent based on
standards. That means that in many places we refer to external
documentation whenever possible.


## Services by scope and purposes

### Dissemination of metadata

The dissemination services are aimed at aggregator services of various
kinds. Our dissemination API is OAI-PMH targets are COP, Aleph and the
national National aggregator. The most important aggregators are REX
och Europeana.

1. Docuuments:
http://www.openarchives.org/OAI/openarchivesprotocol.html

2. Services:
+    http://oai.kb.dk/oai/provider?verb=Identify
+    http://www.kb.dk/cop/oai/?verb=Identify

### Search and retrieval

Blah, blah, blah. This is about COP including Luftfoto(Aerial Photography). Documents:

Open search: http://www.opensearch.org/Home
KML: https://developers.google.com/kml/documentation/

[aerial_photography.md](aerial_photography.md) by Andreas Borchsenius West 
[cop-backend.md](cop-backend.md)
Syndication services http://www.kb.dk/cop/syndication/*

http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/subject205/?format=kml&type=all&bbo=12.175383114685019,55.84732059821742,8.882231259216269,54.68945661135621&notBefore=1900-01-01&notAfter=2015-12-31&itemsPerPage=75&page=1&random=0.0

Aleph har en sök-API, och vi har även APIer för SFX och Primo.

### Image delivery

All images are with few exceptions are delivered via IIP Image using the APIn är IIIF Documents: http://iiif.io/api/image/2.1/

Our image cluent is OpenSeaDragon (OSD). OSD is used in COP and other
services. OSD is configured on a per object basis using a json-baserad
API.

### Text delivery

We don't write about this until after letters (or ADL or both) are published. Need demo of SOLR and snipets

~~Helt nya APIer kommer med ADL och Danmarks Brev. De består av de APIer som kommer med vår sökmaskin SOLR Hur sökning sker är dokumenterat externt: https://lucene.apache.org/solr/6_2_1/ (Vi använder betydligt äldre versioner än denna)~~

Text search and retrieval are made using  [https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets](solr-and-snippets)