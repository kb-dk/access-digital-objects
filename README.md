[READ ME](README.md) - [OAI Dissemination](oai-pmh.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md) - [Text Corpora](text-corpora.md)

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

![Linked data](https://www.w3.org/DesignIssues/diagrams/lod/597992118v2_350x350_Back.jpg) [linked data](https://www.w3.org/DesignIssues/LinkedData.html)


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

The APIs described have been used successfully in projects (in some
cases for many years). We, their users & developers, created each of
them for getting a job done. They are usually well tested and works
well, but they are neither polished, nor are there helpful error
messages etc.

The formats we are delivering are to a large extent based on
standards. That means that in many places we refer to external
documentation whenever possible. We are not guaranteeing anything
concerning the external information sources, nor that our data are
strictly valid in relation to those documents.

## Services by scope and purpose

Our services builds upon the ideas

+ [COOL URIs](https://www.w3.org/Provider/Style/URI) 

and

+ [linked data](https://www.w3.org/DesignIssues/LinkedData.html)

as they are presented by Tim Berners-Lee. We don't promise that our
links will persist for 2000 years, but we do our best to keep them and
if we don't we promise to make redirects according to best practise.

As you will see, we are slightly better than three on Berners-Lee's
five grade scale. We do not provide access to RDF and SPARQL but RSS
and OpenSearch. Few provide access to RDF these days, so perhaps W3C
should redesign the cop (see above).

Neither do we link to external sources.

A brief introduction to the characters in the story

+ [Digital Editions - COP](http://www.kb.dk/editions/any/2009/jul/editions/en/), an acronym for which one possible interpretation could be **C**ommon **O**bject **P**ublishing platform. The word _Common_ would refer to that it is platform which is common between different collections and media types. However, when it was released we intentionally never gave the service a brand name.
+ [Aerial Photography collection - DSFL](http://www.kb.dk/danmarksetfraluften/) (DFSL)
+ National Aggregator - A system run by us aggregating material from Danish libraries, museums and archives on behalf of Europeana
+ [Archive for Danish Literature](http://www.adl.dk/), ADL

### Dissemination of metadata

The purpose of our dissemination is to enable us to synchronize data
between our own systems, but also to share our data with Cultural
Heritage communities at large. The dissemination services are aimed at
aggregator services of various kinds. Our dissemination [API is OAI-PMH](oai-pmh.md)

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

### Text and literature

Currently the whole [Archive for Danish Literature is available](text-corpora.md).

## Acknowledgements

Andreas Borchsenius West contributed information about feeds and the
JSON service used for maps, notably our Aerial photography collection
Danmark Set Fra Luften (DSFL).