

## Web services in COP

### Navigation service

delivers the subject hierarchy needed by users browsing the service. Links to RSS & HTML representations of the data -- ex

http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder and
http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder/subject841/

This service accepts the parameter ```opml_mode``` with values
```deep``` and ```shallow. For example:

http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder/subject2109/?opml_mode=deep

and

http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder/subject2109/?opml_mode=shallow

Shallow was intended to give the current subject and its descendants. (This seems broken in the current implementation)

### Content service 

delivers table of contents for complex digital objects. ex http://www.kb.dk/cop/content/manus/musman/2010/dec/viser/object23942/en/ and http://www.kb.dk/cop/content/letters/judsam/2011/mar/dsa/object10/en/ representing TOCs of a song book and a two page letter, respectively


### Syndication service 

The syndication service delivers by default rss. It supports a
'''format''' CGI parameter. When set to mods, the service delivers
<pre><modsCollection> ... </modsCollection></pre> rather than
<pre><rss> ... </rss></pre> The RSS syntax includes all data for
resultset navigation. I.e.,

   <opensearch:startIndex>10</opensearch:startIndex>
   <opensearch:itemsPerPage>5</opensearch:itemsPerPage>
   <opensearch:totalResults>54589</opensearch:totalResults>
   <opensearch:Query role="request" startPage="10" searchTerms=""/>
   <atom:link rel="search" 
            type="application/opensearchdescription+xml" 
            href="http://www.kb.dk:80/cop/syndication/images/billed/2010/okt/billeder/subject2109/en/"/>

+ search "by subject", searching by navigation -- ex
http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/en/?page=1&subject=2120&itemsPerPage=40
which is synonymous with
http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/subject2120/en/?page=1
The result set can be further molded by the itemsPerPage
parameter. For example
http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/subject2109/en/?itemsPerPage=5

+ search "by querying", ordinary search -- ex
http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/en/?page=1&query=jesus&itemsPerPage=40
supports currently mods and rss.

### OAI PMH service 

syndicates metadata using OAI, if you hadn't guessed that
already. http://www.kb.dk/cop/oai/?verb=Identify which should do what
an OAI server should

### GEO search service 

`Lat,Long` or `Long,Lat?`  That depends ;^) 

* In a `KML`l feed the expected order is Longitude, Latitude format. See KML reference 
http://code.google.com/intl/da-DK/apis/kml/documentation/kmlreference.html#point
* In an `RSS` feed using the GeoRSS:point tag, the coordinates are Latitude, Longitude.
http://www.georss.org/georss
* In `MODS` the md:coordinates the order is Latitude, Longitude.
http://www.loc.gov/standards/mods/v3/mods-userguide-elements.html#coordinates

Otherwise, see geographic search http://www.opensearch.org/Specifications/OpenSearch/Extensions/Geo/1.0/Draft_1

== Complete list of supported CGI parameters in COP ==

| Parameter | Used in PATH | Used in CGI | Comment | Status|
|-----------|:-------------|:------------|:--------|-------|
|q          | -            | -           | Synonym to query | deprecated|
|query | - | x | Synonym to q | ok |
|format | - | x | rss, mods and atom are supported. The implementation of Atom seems incomplete | ok |
|page | depr | x | | ok |
|pag|x|x|Synonym to page. Used for paging of result sets.|Deprecated, use page |
|lang |x | - | don't use in CGI | ok |
|itemsPerPage | - | x | |ok |
|object | x | deprecated | | ok |
|categories | -  | x | Synonym to subject| Deprecated, use subject |
|subject | x | depr | Synonym to categories | ok |
|img | x | - | In Danmarksbilleder only. Used for highlighting that image in the result set which is shown in the landing page part of the page. A function which is similar to the mouse over highlighting in luftfoto | Ready for deprecation? |
|image_number | - | x | In Danmarksbilleder only| Ready for deprecation? |
|mode | - | x | Used for "list" and "thumbnails" modes. It seems that a majority of the contributors would like to remove the list mode.| ok |
|bbo | - | x | Bounding Box |
|notBefore | - | x | Not before a given date | - |
|notAfter | - | x | Not after a given date | - |


