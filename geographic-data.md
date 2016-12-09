[README](README.md) - [OAI-PMH](oai-pmh.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md)

# Accessing the Aerial Photograph Collection
        
## Overview

This document describes the search interfaces for our Aerial
Photography Collection, [Danmark set fra
Luften](http://www.kb.dk/danmarksetfraluften/), (DFSL).  Because of
its geographical aspect it has its own frontend.

DSFL - draws its data from several sources, notably

+ The metadata is stored in Common Object Publishing (COP)
+ Vertical, photogrammetrical, images from 1954, 1995 and 2006. These are provided by [COWI](http://www.cowi.dk/menu/home/) based on originals in our collections.
        
The service is based on the Amazon A9 open Search web service protocol. A more [detailed description of that is available](cop-backend.md#open-search). 

~~Kendte mangler og kommende ændringer: Det er ikke muligt at begrænse resultater til kun at vise korrekt placerede luftfotos.~~

## COP Backend - Syndication Service
        
The whole dataset can (at least in principle) be accessed from http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/subject203/

A single record can be retrieved using a URI on this form http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/object59452/ (a single record)
        
A simple area search with result presented in [KML format](https://developers.google.com/kml/documentation/)

http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/subject203/?format=kml&type=all&bbo=10.80531074987789,55.57241860489453,10.568933033813437,55.48147359047444&notBefore=1920-01-01&notAfter=1970-12-31&itemsPerPage=50&page=1&random=0.0


### Parameters and sample values

format = (kml, rss, atom, mods)

type = all, 1,2,3

 all = Alle typer, all types of photos
 1   = Skråfoto, aerial photo with an angle.
 2   = Lodfoto, 90 degree aerial photo
 3   = Protokolside, Protocol page

bounding box

 bbo = 10.80531074987789,55.57241860489453,10.568933033813437,55.48147359047444

http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/subject203/?format=kml&type=all&bbo=10.80531074987789,55.57241860489453,10.568933033813437,55.48147359047444&notBefore=1920-01-01&notAfter=1970-12-31&itemsPerPage=50&page=1&random=0.0&correctness=1
        
 notBefore=1920-01-01
        Do not return pictures before this date YYYY-MM-DD
 notAfter=1970-12-31
        Do not return pictures after this date YYYY-MM-DD

 itemsPerPage=1-5000
        The number of items to be returned per page. If 10000 records
	is found in an area only 5000 will be displayed, the last items (5001
	to 10000) can be retrieved by setting the page variable to 2

 page= 1,2,3 etc. depending on the number of results. Works as an offset value.

 random= 0.1
        a value between 0.0 and 1.0. Optional and only relevant for
	the luftfoto frontend...

### Searching with a query string 

query= a search term.

Further specification on the query search term. Certain fields can be specified inside a query term. These are, currently

+ location:X
+ person:Y
+ address:Z
+ building:A

Example: Searching for "Lykkegård" in the full text of the record and
combining that with a boolean AND with a search for "Jørgensen" in
the person field yields

```
Lykkegård&person::Jørgensen
```

URI encoded and inserted as the value of the query CGI variable this gives
        
http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/subject203/?format=rss&query=lykkeg%C3%A5rd%26person%3A%3AJ%C3%B8rgensen&type=all&bbo=10.826596760620077,55.54834253439101,10.590219044555624,55.45734180334893&notBefore=1920-01-01&notAfter=1970-12-31&itemsPerPage=50&page=1&random=0.0

~~ To me it looks more like a bug than a feature to use '&' in this position ~~

~~ Honestly: Should we actually publish info on the kml? I have tried, but I can not get it to work. Perhaps we could get google maps to accept the rss instead ~~

Example Output in KML

```
<kml>
  <Document>
    <Style id="balloon-style">
      <BalloonStyle>
	<text>
	  <img src='$[subjectThumbnailSrc]' />
	  <br />
	  <b>Navn:</b> $[subjectName]<br />
	  <b>Årstal:</b> $[subjectCreationDate]<br />
	  <b>Sted:</b> $[subjectGeographic]<br /><br />
	  <a href='$[subjectLink]'>Mere info</a>
	</text>
      </BalloonStyle>
    </Style>
    <startIndex>1</startIndex>
    <itemsPerPage>3</itemsPerPage>
    <Query role="request" searchTerms="{}" startPage="1"/>
    <totalResults>511</totalResults>
    <link href="http://www.kb.dk/cop/images/luftfo/2011/maj/luftfoto" rel="search" type="application/opensearchdescription+xml"/>
    <link href="http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/" rel="search" type="application/kml+xml"/>
    <Placemark id="object78814">
      <name>Lykkegård, Valdemar, gårdejer (1948)</name>
      <styleUrl>#balloon-style</styleUrl>
      <atom:link href="http://www.kb.dk/images/luftfo/2011/maj/luftfoto/object78814"/>
      <Point>
	<coordinates>10.686429993629417,55.49797116219872</coordinates>
      </Point>
      <ExtendedData>
	<Data name="subjectLink">
	  <value>http://www.kb.dk/images/luftfo/2011/maj/luftfoto/object78814</value>
	</Data>
	<Data name="subjectName">
	  <value>Lykkegård, Valdemar, gårdejer</value>
	</Data>
	<Data name="subjectCreatorName">
	  <value>Sylvest Jensen</value>
	</Data>
	<Data name="subjectCreationDate">
	  <value>1948</value>
	</Data>
	<Data name="subjectGenre">
	  <value>Skråfoto</value>
	</Data>
	<Data name="subjectNote">
	  <value/>
	</Data>
	<Data name="subjectGeographic">
	  <value>Danmark, Fyn, Viby</value>
	</Data>
	<Data name="subjectImageSrc">
	  <value>http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3147/L3147_38.jpg</value>
	</Data>
	<Data name="subjectThumbnailSrc">
	  <value>http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3147/L3147_38.jpg</value>
	</Data>
	<Data name="recordCreationDate">
	  <value>2011-07-11</value>
	</Data>
	<Data name="recordChangeDate">
	  <value>2012-02-16</value>
	</Data>
	<Data name="correctness">
	  <value>1</value>
	</Data>
      </ExtendedData>
    </Placemark>
    <Placemark id="object78546">
      <name>Petersen, gårdejer (1936/1937/1938)</name>
      <styleUrl>#balloon-style</styleUrl>
      <atom:link href="http://www.kb.dk/images/luftfo/2011/maj/luftfoto/object78546"/>
      <Point>
	<coordinates>10.685745670318965,55.49695929660715</coordinates>
      </Point>
      <ExtendedData>
	<Data name="subjectLink">
	  <value>http://www.kb.dk/images/luftfo/2011/maj/luftfoto/object78546</value>
	</Data>
	<Data name="subjectName">
	  <value>Petersen, gårdejer</value>
	</Data>
	<Data name="subjectCreatorName">
	  <value>Sylvest Jensen</value>
	</Data>
	<Data name="subjectCreationDate">
	  <value>1936/1937/1938</value>
	</Data>
	<Data name="subjectGenre">
	  <value>Skråfoto</value>
	</Data>
	<Data name="subjectNote">
	  <value/>
	</Data>
	<Data name="subjectGeographic">
	  <value>Danmark, Fyn, Viby</value>
	</Data>
	<Data name="subjectImageSrc">
	  <value>http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L0271/L0271_12.jpg</value>
	</Data>
	<Data name="subjectThumbnailSrc">
	  <value>http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L0271/L0271_12.jpg</value>
	</Data>
	<Data name="recordCreationDate">
	  <value>2011-07-11</value>
	</Data>
	<Data name="recordChangeDate">
	  <value>2011-07-11</value>
	</Data>
	<Data name="correctness">
	  <value>1</value>
	</Data>
      </ExtendedData>
    </Placemark>
    <Placemark id="object78812">
      <name>Hansen, uddeler (1948)</name>
      <styleUrl>#balloon-style</styleUrl>
      <atom:link href="http://www.kb.dk/images/luftfo/2011/maj/luftfoto/object78812"/>
      <Point>
	<coordinates>10.68613495063778,55.496497415382834</coordinates>
      </Point>
      <ExtendedData>
	<Data name="subjectLink">
	  <value>http://www.kb.dk/images/luftfo/2011/maj/luftfoto/object78812</value>
	</Data>
	<Data name="subjectName">
	  <value>Hansen, uddeler</value>
	</Data>
	<Data name="subjectCreatorName">
	  <value>Sylvest Jensen</value>
	</Data>
	<Data name="subjectCreationDate">
	  <value>1948</value>
	</Data>
	<Data name="subjectGenre">
	  <value>Skråfoto</value>
	</Data>
	<Data name="subjectNote">
	  <value/>
	</Data>
	<Data name="subjectGeographic">
	  <value>Danmark, Fyn, Viby</value>
	</Data>
	<Data name="subjectImageSrc">
	  <value>http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3147/L3147_36.jpg</value>
	</Data>
	<Data name="subjectThumbnailSrc">
	  <value>http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3147/L3147_36.jpg</value>
	</Data>
	<Data name="recordCreationDate">
	  <value>2011-07-11</value>
	</Data>
	<Data name="recordChangeDate">
	  <value>2012-02-16</value>
	</Data>
	<Data name="correctness">
	  <value>1</value>
	</Data>
      </ExtendedData>
    </Placemark>
  </Document>
</kml>
```
## Shortcut - Luftfoto JSON Service 

As an alternative to the xml based webservice a JSON REST service is available:

type: POST

url: http://www.kb.dk/danmarksetfraluften/async/search/
request: bbo=10.395490670074423,55.22227193719089,10.296785378326376,55.18994697228769&zoom=14&lat=55.20611273543719&lng=10.346138024200382&page=1&q_fritekst=&q_stednavn=&q_bygningsnavn=&q_person=&q_adresse=&notBefore=1920&notAfter=1970&category=subject203&itemType=all&thumbnailSize=

sample response (slightly modified to display less results):

```
{

   "status":"OK",
   "kmlFeedUrl":"REPLACED_EXTERNAL_BACKEND_GUI_URI/syndication/images/luftfo/2011/maj/luftfoto/subject203/?format\u003dkml\u0026type\u003dall\u0026bbo\u003d10.395490670074423,55.22227193719089,10.296785378326376,55.18994697228769\u0026notBefore\u003d1920-01-01\u0026notAfter\u003d1970-12-31\u0026itemsPerPage\u003d50\u0026page\u003d1\u0026random\u003d0.0",
   "rssUrl":"http://cop-02.kb.dk:8080/cop/syndication/images/luftfo/2011/maj/luftfoto/subject203/?format\u003drss\u0026type\u003dall\u0026bbo\u003d10.395490670074423,55.22227193719089,10.296785378326376,55.18994697228769\u0026notBefore\u003d1920-01-01\u0026notAfter\u003d1970-12-31\u0026itemsPerPage\u003d50\u0026page\u003d1\u0026random\u003d0.0",
   "copjects":[
      {
         "id":"object80081",
         "title":"Larsen, Marius, gårdejer (1949)",
         "longitude":"10.299912225723233",
         "latitude":"55.20855233840371",
         "location":"Danmark, Fyn, Sandholt Lyndelse",
         "mods":"",
         "atomLink":"http://www.kb.dk/danmarksetfraluften/images/luftfo/2011/maj/luftfoto/object80081",
         "imgUrl":"http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3555/L3555_31a.jpg",
         "imgURLThumb":"http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3555/L3555_31a.jpg",
         "imgURLFull":"",
         "itemType":"Skråfoto",
         "stjerne":"",
         "photoYear":"1949",
         "photoName":"Larsen, Marius, gårdejer",
         "iconType":"",
         "isPartofCluster":false,
         "correctness":"1"
      },
      {

         "id":"object80083",
         "title":"Frederiksen, Fr., gårdejer (1949)",
         "longitude":"10.301543008804288",
         "latitude":"55.20570867133342",
         "location":"Danmark, Fyn, Sandholt Lyndelse",
         "mods":"",
         "atomLink":"http://www.kb.dk/danmarksetfraluften/images/luftfo/2011/maj/luftfoto/object80083",
         "imgUrl":"http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3555/L3555_32a.jpg",
         "imgURLThumb":"http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3555/L3555_32a.jpg",
         "imgURLFull":"",
         "itemType":"Skråfoto",
         "stjerne":"",
         "photoYear":"1949",
         "photoName":"Frederiksen, Fr., gårdejer",
         "iconType":"",
         "isPartofCluster":false,
         "correctness":"1"
      },
      {
         "id":"object79751",
         "title":"(1949)",
         "longitude":"10.344592463493541",
         "latitude":"55.20884006089258",
         "location":"Danmark, Fyn, Hillerslev",
         "mods":"",
         "atomLink":"http://www.kb.dk/danmarksetfraluften/images/luftfo/2011/maj/luftfoto/object79751",
         "imgUrl":"http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3542/L3542_37a.jpg",
         "imgURLThumb":"http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L-serien/Negativer/L3542/L3542_37a.jpg",
         "imgURLFull":"",
         "itemType":"Skråfoto",
         "stjerne":"",
         "photoYear":"1949",
         "photoName":"",
         "iconType":"",
         "isPartofCluster":false,
         "correctness":"1"
      },
      {
         "id":"object69117",
         "title":"(1939)",
         "longitude":"10.300898918628718",
         "latitude":"55.206124979742256",
         "location":"Danmark, Fyn, Sandholt Lyndelse",
         "mods":"",
         "atomLink":"http://www.kb.dk/danmarksetfraluften/images/luftfo/2011/maj/luftfoto/object69117",
         "imgUrl":"http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L0815_06.jpg",
         "imgURLThumb":"http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L0815_06.jpg",
         "imgURLFull":"",
         "itemType":"Skråfoto",
         "stjerne":"",
         "photoYear":"1939",
         "photoName":"",
         "iconType":"",
         "isPartofCluster":false,
         "correctness":"1"
      },
      {
         "id":"object69033",
         "title":"Bondesen, Rs., gårdejer (1939)",
         "longitude":"10.35555557834302",
         "latitude":"55.19091957553203",
         "location":"Danmark, Fyn, Nybølle",
         "mods":"",
         "atomLink":"http://www.kb.dk/danmarksetfraluften/images/luftfo/2011/maj/luftfoto/object69033",
         "imgUrl":"http://www.kb.dk/imageService/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L0812_16.jpg",
         "imgURLThumb":"http://www.kb.dk/imageService/w150/h150/online_master_arkiv_10/non-archival/Maps/FYNLUFTFOTO/L0812_16.jpg",
         "imgURLFull":"",
         "itemType":"Skråfoto",
         "stjerne":"",
         "photoYear":"1939",
         "photoName":"Bondesen, Rs., gårdejer",
         "iconType":"",
         "isPartofCluster":true,
         "correctness":"0"
      },
   ],
   "totalResultsCount":153,
   "currentPage":1,
   "copjectsCount":50,
   "pagesCount":4,
   "resultsPerPage":50,
   "zoomLvl":14
}
```

### The encoding of coordinates

`Lat,Long` or `Long,Lat?`  That depends ;^) 

* In a `KML`l feed the expected order is Longitude, Latitude format. See KML reference 
http://code.google.com/intl/da-DK/apis/kml/documentation/kmlreference.html#point
* In an `RSS` feed using the GeoRSS:point tag, the coordinates are Latitude, Longitude.
http://www.georss.org/georss
* In `MODS` the md:coordinates the order is Latitude, Longitude.
http://www.loc.gov/standards/mods/v3/mods-userguide-elements.html#coordinates


