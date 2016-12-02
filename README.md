# Access digital objects!

The Library has been digitizing Cultural Heritage Objects in its
collections since well over two decades. More recently, the last 6-7
years, we have tried to build our dissemination platforms using a REST
based architecture.

This collection of documents describes the various APIs we are using
ourselves to provide access to our data to library patrons, in the
hope that the access points could be useful for a new category library
patron whose research or studies would benefit from prammatic access
to our collections.


## Licences & Legalese

The documention here is provided as is, and mind you: __Everything
that's free comes with no guarantee__. As a matter of fact the
material in __this git repository__ is licensed to you as 
[GNU Free Documentation License](LICENSE)

The material we __provide access to using the APIs described__ are of two kinds:

1. Metadata: This comes to you as [https://creativecommons.org/publicdomain/zero/1.0/](CC0 1.0
Universal). I.e.,
our metadata is basically public domain.

2. Content: The content in our digital collections are delivered with
varous licenses, but the most common one is
[https://creativecommons.org/licenses/by-nc-nd/2.0/](Attribution-NonCommercial-NoDerivs 2.0
Generic)

## Caveats

The APIs described have used by us for many years. We, the developers,
created each of them for getting a job done. They are usually well
tested and works well, but they certainly not polished and neither are
there any helpful error messages etc.

The formats we are delivering are to a large extent based on
standards. That means that in many places we refer to external
documentation whenever possible. We do not guarantee that the
documents are strictly valid, though.

## Services by scope and purpose

### Dissemination of metadata

The dissemination services are aimed at aggregator services of various
kinds. Our dissemination API is OAI-PMH targets are COP, Aleph and the
national National aggregator. The most important aggregators are REX
och Europeana.

The purpose of dissemination is to enable Cultural Heritage
organisation to share data. To use the data you'll have to store them
in a database or index of your own. The [Open Archives Initives Protocol of Metadata Harvesting](http://www.openarchives.org/OAI/openarchivesprotocol.html)  (OAI PMH) is well
known, and we will not provide detailed information about here.

A few example to get an idea what it is about:

1. Each OAI provider should be able to [Identify](http://www.openarchives.org/OAI/openarchivesprotocol.html#Identify) itself.  
  + http://www.kb.dk/cop/oai/?verb=Identify

2. An OAI provider may contain multiple [collections or sets](http://www.openarchives.org/OAI/openarchivesprotocol.html#ListSets)
  + http://www.kb.dk/cop/oai/?verb=ListSets 

3. For a given set we provide access to a [list of records](http://www.openarchives.org/OAI/openarchivesprotocol.html#ListRecords),
  for instance of all manuscripts in the Judaica collection 
  + http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2010:maj:jsmss&metadataPrefix=mods
  
4. One should be able to get hold of a [single record, given its Identifier](http://www.openarchives.org/OAI/openarchivesprotocol.html#GetRecord)
  + http://www.kb.dk/cop/oai/?verb=GetRecord&identifier=oai:kb.dk:manus:judsam:2010:maj:jsmss:object62730&metadataPrefix=oai_dc

In the cases in the examples above we obtained the records in mods
format, other alternatives are oai_dc and ese. See below.

### Search and retrieval

Our most important is internally referred to as COP, an acronym for
which one possible interpretation could be **C**ommon **O**bject
**P**ublishing platform. The word _Common_ would refer to that it is
platform which is common between different collections and media
types. However, when it was released we intentionally never gave the
service a brand name.

The COP metadata is accessed from two front ends 

+ [Digital Editions](http://www.kb.dk/editions/any/2009/jul/editions/en/)
+ Aerial Photography Collection, [Danmark set fra Luften](http://www.kb.dk/danmarksetfraluften/) (DFSL)

The both services use the same web services, but DFSL has some
geographical extensions in order to run its map based interface. We
have two different documents describing the backend services

+ [General COP web services](cop-backend.md)
+ [Geographical extensions](open-search-dsfl.md)

### Image delivery

All images are with few exceptions are delivered via IIP Image using the APIn är IIIF Documents: http://iiif.io/api/image/2.1/

Our image cluent is OpenSeaDragon (OSD). OSD is used in COP and other
services. OSD is configured on a per object basis using a json-baserad
API.

### Metadata formats

[KML](https://developers.google.com/kml/documentation/)

### Text delivery

~~We don't write about this until after letters (or ADL or both) are published. Need demo of SOLR and snipets~~

~~Helt nya APIer kommer med ADL och Danmarks Brev. De består av de APIer som kommer med vår sökmaskin SOLR Hur sökning sker är dokumenterat externt: https://lucene.apache.org/solr/6_2_1/ (Vi använder betydligt äldre versioner än denna)~~

~~Text search and retrieval are made using  [https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets](solr-and-snippets)~~

### Acknowledgements

Andreas Borchsenius West contributed information about the JSON
service used for maps, notably our Aerial photography collection
Danmark Set Fra Luften.