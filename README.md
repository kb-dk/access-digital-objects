[README](README.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md)

# Access digital objects!

The Royal Library, Copenhagen, has been digitizing Cultural Heritage
Objects in its collections since well over two decades. More recently,
the last 6-7 years, we have tried to build our dissemination platforms
using a REST based architecture.

This collection of documents describes the various APIs we are using
ourselves to provide access to our data to library patrons, in the
hope that the access points could be useful for a new category library
patron whose research or studies would benefit from programmatic access
to our digital collections.


## Licences & Legalese

The documention here is provided as is, and mind you: __Everything
that's free comes with no guarantee__. As a matter of fact the
material in __this git repository__ is licensed to you as 
[GNU Free Documentation License](LICENSE)

The material we __provide access to using the APIs described__ are of two kinds:

1. Metadata: This comes to you as [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/). I.e.,
our metadata is basically public domain.

2. Content: The content in our digital collections are delivered with
varous licenses, but the most common one is
[Attribution-NonCommercial-NoDerivs 2.0 Generic](https://creativecommons.org/licenses/by-nc-nd/2.0/). I.e., our content is provided with a much more restrictive CC license.

## Caveats

The APIs described have been used by us for many years. We, their
developers, created each of them for getting a job done. They are
usually well tested and works well, but they are neither polished, nor are
there helpful error messages etc.

The formats we are delivering are to a large extent based on
standards. That means that in many places we refer to external
documentation whenever possible. We do not guarantee that the
documents are strictly valid, though.

## Services by scope and purpose

A brief introduction to the characters in the story

+ [Digital Editions - COP](http://www.kb.dk/editions/any/2009/jul/editions/en/), an acronym for which one possible interpretation could be **C**ommon **O**bject **P**ublishing platform. The word _Common_ would refer to that it is platform which is common between different collections and media types. However, when it was released we intentionally never gave the service a brand name.
+ [Aerial Photography collection - DSFL](http://www.kb.dk/danmarksetfraluften/) (DFSL)
+ [Rex - our Integrated Library System](http://rex.kb.dk/)
+ National Aggregator - A system run by us aggregating material from Danish libraries, museums and archives on behalf of Europeana

### Dissemination of metadata

The purpose of our dissemination is to enable us to synchronize data
between our own systems, but also to share our data with Cultural
Heritage communities at large. The dissemination services are aimed at
aggregator services of various kinds. Our dissemination API is
OAI-PMH, and our targets are COP, Aleph and the national National
aggregator. The most important aggregators are, the National
Aggregator (which is our own OAI to OAI gateway and aggregation
service), REX, our discovery system, och Europeana.

When using these service, you need to store them in a database or
index of your own. The [Open Archives Initives Protocol of Metadata
Harvesting](http://www.openarchives.org/OAI/openarchivesprotocol.html)
(OAI PMH) is well known, and we will not provide detailed information
about here.

A few example to get an idea what it is about:

1. Each OAI provider should be able to [Identify](http://www.openarchives.org/OAI/openarchivesprotocol.html#Identify) itself.  
  + http://www.kb.dk/cop/oai/?verb=Identify

2. An OAI provider may contain multiple [collections or sets](http://www.openarchives.org/OAI/openarchivesprotocol.html#ListSets)
  + http://oai.kb.dk/oai/provider?verb=ListSets
  + ~~http://www.kb.dk/cop/oai/?verb=ListSets is right now broken, sorry for that~~

3. For a given set we provide access to a [list of records](http://www.openarchives.org/OAI/openarchivesprotocol.html#ListRecords),
  for instance of all manuscripts in the Judaica collection 
  + http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2010:maj:jsmss&metadataPrefix=mods
  
4. One should be able to get hold of a [single record, given its Identifier](http://www.openarchives.org/OAI/openarchivesprotocol.html#GetRecord)
  + http://www.kb.dk/cop/oai/?verb=GetRecord&identifier=oai:kb.dk:manus:judsam:2010:maj:jsmss:object62730&metadataPrefix=oai_dc

You can easily harvest any of our editions by choosing the
desired set in the ListSets example above and insert it into the
ListRecords URI. In the cases in the examples above we obtained the
records in mods format, other alternatives are oai_dc and ese. See
below .

Examples:

+ http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2010:maj:jsmss&metadataPrefix=ese
+ http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2010:maj:jsmss&metadataPrefix=oai_dc

| Set Spec | Set Name |
|----------|----------|
| [oai:kb.dk:letters:judsam:2011:mar:dsa](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:letters:judsam:2011:mar:ds&metadataPrefix=ese) | David Simonsens Arkiv |
| [oai:kb.dk:manus:judsam:2010:maj:jsmss](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2010:maj:jsmss&metadataPrefix=ese) | Judaistisk Samling: Håndskrifter | 
| [oai:kb.dk:images:luftfo:2011:maj:luftfoto](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:images:luftfo:2011:maj:luftfoto&metadataPrefix=ese) | Luftfoto |
| [oai:kb.dk:pamphlets:dasmaa:2012:jul:smaatryk](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:pamphlets:dasmaa:2012:jul:smaatryk&metadataPrefix=ese) | Småtryk |
| [oai:kb.dk:maps:kortsa:2012:jul:kortatlas](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:maps:kortsa:2012:jul:kortatlas&metadataPrefix=ese) | Kort og Atlas |
| [oai:kb.dk:pamphlets:dasmaa:2008:feb:partiprogrammer](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:pamphlets:dasmaa:2008:feb:partiprogrammer&metadataPrefix=ese) | Partiprogram |
| [oai:kb.dk:images:billed:2010:okt:billeder](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:images:billed:2010:okt:billeder&metadataPrefix=ese) | Billeder | 
| [oai:kb.dk:manus:ortsam:2009:okt:orientalia](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:ortsam:2009:okt:orientalia&metadataPrefix=ese) | Oriental Collection: Manuscripts |
| [oai:kb.dk:pamphlets:dasmaa:2008:feb:daellsvarehus](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:pamphlets:dasmaa:2008:feb:daellsvarehus&metadataPrefix=ese) | Varehuskataloger |
| [oai:kb.dk:books:judsam:2010:maj:jstryk](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:books:judsam:2010:maj:jstryk&metadataPrefix=ese) | Judaistisk Samling: Tidlige & sjældne tryk |
| [oai:kb.dk:manus:judsam:2009:sep:dsh](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2009:sep:dsh&metadataPrefix=ese) | David Simonsens Håndskrifter |
| [oai:kb.dk:books:ortsam:2011:mar:ostryk](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:books:ortsam:2011:mar:ostryk&metadataPrefix=ese) | Tidlige tryk i Orientalsk Samling |
| [oai:kb.dk:manus:musman:2010:dec:viser](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:musman:2010:dec:viser&metadataPrefix=ese) | DFS |
| [oai:kb.dk:images:billed:2014:jun:hca](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:images:billed:2014:jun:hca&metadataPrefix=ese) | H.C. Andersen |
| [oai:kb.dk:manus:vmanus:2011:dec:ha](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:vmanus:2011:dec:ha&metadataPrefix=ese) | Vesterlandske håndskrifter |

### Search and retrieval

The metadata and objects in COP are accessible from two front ends 

+ [Digital Editions](http://www.kb.dk/editions/any/2009/jul/editions/en/)
+ Aerial Photography Collection, [Danmark set fra Luften](http://www.kb.dk/danmarksetfraluften/) (DFSL)

The both services use the same web services, but DFSL has some
geographical extensions in order to run its map based interface

+ [General COP web services](cop-backend.md)
+ [Geographical extensions](geographic-data.md)

### Metadata formats

Through COP we deliver metadata to various services, in [different
formats](metadata-formats.md).

### Content formats 

Virtually all content in COP is delivered as images; their delivery is
described in a [separate document](image-delivery.md).

### Text delivery

~~We don't write about this until after letters (or ADL or both) are published. Need demo of SOLR and snipets~~

~~Helt nya APIer kommer med ADL och Danmarks Brev. De består av de APIer som kommer med vår sökmaskin SOLR Hur sökning sker är dokumenterat externt: https://lucene.apache.org/solr/6_2_1/ (Vi använder betydligt äldre versioner än denna)~~

~~Text search and retrieval are made using  [https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets](solr-and-snippets)~~

## Acknowledgements

Andreas Borchsenius West contributed information about feeds and the
JSON service used for maps, notably our Aerial photography collection
Danmark Set Fra Luften (DSFL).