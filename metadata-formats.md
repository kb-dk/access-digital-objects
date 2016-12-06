
# The Metadata Formats Used in Syndication and Dissemination 

Through the `format` CGI variable, data can be syndicated in the
following formats: `kml`, `rss` and `mods`

## format=kml

The [KML](https://developers.google.com/kml/documentation/) feed has
not been designed to be consumed directly by external software like
[Google MAPS](http://maps.google.com/), and as of writing this it is
not known if that works.

## format=rss

[RSS 2.0](https://cyber.harvard.edu/rss/rss.html) is the main
format. This feed includes Open Search, geo and GeoRSS extensions. For
example

```
<georss:point>55.27093341035208 10.155321304320978</georss:point>
<geo:lat>55.27093341035208</geo:lat>
<geo:long>10.155321304320978</geo:long>
```

Which is the position of [a building in
DSFL](http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/object176012/da/).

The `geo` name space refer to https://www.w3.org/2003/01/geo/wgs84_pos
and the `georss` to http://www.georss.org/georss.  The other rss
elements used `title` and `link`.

```
<title>Viby - 1952</title>
<link>http://www.kb.dk/images/luftfo/2011/maj/luftfoto/object154326/da/</link>
```

We embed the detailed bibliographic metadata directly inside the
RSS. So each item in the feed has the following outline.

<item>
   <title> ... </title>
   <link>http://www.kb.dk/...</link>
   <description/>
   <md:mods> ... </md:mods>
   <georss:point> latitude, longitude </georss:point>
   <geo:lat> latitude </geo:lat>
   <geo:long> longitude </geo:long>
</item>

So the RSS feed allows us to get everything, while it is actually
understood by browsers and other software. However, the `<md:mods>
... </md:mods>` is only understood by software aware of this practice.

## format=mods

A noted [elsewhere](cop-backend.md#syndication-service-formats), the mods format contains data in this form

```
<modsCollection>
   ... open search header ...
   <md:mods> ... </md:mods>
   <md:mods> ... </md:mods>
   <md:mods> ... </md:mods>
   ...
</modsCollection>
``` 

where the open search header is described in the [syndication service
documentation](cop-backend.md#open-search)

## Metadata conventions

The bulk of the data is in the mods object. The [Metadata Object
Description Schema
(mods)](http://www.loc.gov/standards/mods/mods-guidance.html) is
developed and maintained by Library of Congress and well
documented. Here we restrict ourselves to conventions and
idiosyncrasies in our implementations.

### Identifiers


| XPath | Example value | Comment |
|:------|:--------------|:--------|
| //md:identifier[@type="uri"][1] | ```<md:identifier type="uri">http://www.kb.dk/images/billed/2010/okt/billeder/object67582/da/</md:identifier>```| URI of the object |

| //md:identifier[@type="local"] | ```<md:identifier type="local">H02165_020.tif</md:identifier>``` | The local ID is usually the objects call number |
| //md:identifier[@type="domsGuid"] | ```<md:identifier type="domsGuid">Uid:dk:kb:doms:2007-01/d651d950-1e88-11e2-808e-0016357f605f</md:identifier>``` | A UUID in any of several formats, but usable for connecting it to the ID used for digital preservation if applicable |
| //md:identifier[@displayLabel="image"][@type="uri"] | ```<md:identifier displayLabel="image" type="uri">http://www.kb.dk/imageService/online_master_arkiv_12/non-archival/Maps/FYNLUFTFOTO/H-serien/H02165/H02165_020.jpg</md:identifier>``` | A fairly high resolution JPG |
| //md:identifier[@displayLabel="thumbnail"][@type="uri"] | ```<md:identifier displayLabel="thumbnail" type="uri">http://www.kb.dk/imageService/w150/h150/online_master_arkiv_12/non-archival/Maps/FYNLUFTFOTO/H-serien/H02165/H02165_020.jpg</md:identifier>``` | URI of a thumbnail |


### Language and other information about the records

The COP user interface is bilingual, supporting Danish and
English. Technically that implies that the cataloging language can be
either of these two languages. It is possible read the cataloguing
language from the recordinfo section of a record.


```
<md:recordInfo>
    <md:languageOfCataloging xmlns:java="http://xml.apache.org/xalan/java" xmlns:mix="http://www.loc.gov/mix/v10">
        <md:languageTerm authority="rfc4646">da</md:languageTerm>
    </md:languageOfCataloging>
    <md:recordIdentifier>http://www.kb.dk/cop/images/luftfo/2011/maj/luftfoto/object154326</md:recordIdentifier>
    <md:recordCreationDate encoding="w3cdtf">2012-09-26</md:recordCreationDate>
    <md:recordChangeDate encoding="w3cdtf">2012-10-25</md:recordChangeDate>
</md:recordInfo>
```

The ID of the record and its creation and revision dates can be found here as well.




