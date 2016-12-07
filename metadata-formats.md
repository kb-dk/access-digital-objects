
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

```
<item>
   <title> ... </title>
   <link>http://www.kb.dk/...</link>
   <description/>
   <md:mods> ... </md:mods>
   <georss:point> latitude, longitude </georss:point>
   <geo:lat> latitude </geo:lat>
   <geo:long> longitude </geo:long>
</item>
```

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
| //md:identifier[@type="uri"][1] | `<md:identifier type="uri">` http://www.kb.dk/images/billed/2010/okt/billeder/object67582/da/ `</md:identifier>` | URI of the object |
| //md:identifier[@type="local"] | `<md:identifier type="local">` H02165_020.tif `</md:identifier>` | The local ID is usually the objects call number |
| //md:identifier[@type="domsGuid"] | `<md:identifier type="domsGuid">` Uid:dk:kb:doms:2007-01/d651d950-1e88-11e2-808e-0016357f605f `</md:identifier>` | A UUID in any of several formats, but usable for connecting it to the ID used for digital preservation if applicable |
| //md:identifier[@displayLabel="image"][@type="uri"] | `<md:identifier displayLabel="image" type="uri">` http://www.kb.dk/imageService/online_master_arkiv_12/non-archival/Maps/FYNLUFTFOTO/H-serien/H02165/H02165_020.jpg `</md:identifier>` | A fairly high resolution JPG |
| //md:identifier[@displayLabel="thumbnail"][@type="uri"] | `<md:identifier displayLabel="thumbnail" type="uri">` http://www.kb.dk/imageService/w150/h150/online_master_arkiv_12/non-archival/Maps/FYNLUFTFOTO/H-serien/H02165/H02165_020.jpg `</md:identifier>` | URI of a thumbnail |


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

### Resource language

Some of the objects in COP are in unusual language and script
combinations, like judeo-arabic (arabic written in Hebr script) and
even western European languages like Italian and German written in
Hebrew. In our Oriental collections combinations of language and
script is not at all obvious. Through history people write those
languages they know, using the scripts they know. Which in some cases
give arise to texts like this [Die abhandlung der
algebra](http://www.kb.dk/manus/judsam/2009/sep/dsh/object28241/en/)
which is written in German but in Hebrew script.

To handle this we use an Internet standard for [language tagging,
namely RFC 4646](https://www.ietf.org/rfc/rfc4646.txt)

### Event metadata

In publishing the [Comics, caricature and newspaper cartoons
collection](http://www.kb.dk/images/billed/2010/okt/billeder/subject2427/da/)
we realized that it is more or less meaningful to publish artwork of
this kind without being able to connect it to a description of the
situation it was created. Find below an example of how such an event
is encoded as a related item, which in this case is a revue preformance.


```
 <md:relatedItem type="event">
     <md:note xml:lang="da">Revy af Heick, Hilda (f. 1946) sanger og Heick, Keld (f. 1946) musiker og sanger</md:note>
     <md:originInfo>
         <md:dateIssued xml:lang="da">1991</md:dateIssued>
         <md:place>
             <md:placeTerm xml:lang="da">Lindenborg Kro, Lindenborg, Roskilde</md:placeTerm>
         </md:place>
     </md:originInfo>
 </md:relatedItem>
```

A `<md:relatedItem>` element may contain any element allowed in the
`<md:mods>` root element, the relation can be given in `type`
attribute and can use an xlink:href instead of containing elements.

### Host publications

A newspaper cartoon, just as an example, appears as a
`<md:relatedItem>` of type host. Only a handful elements are supported
inside hosts.

```
<md:relatedItem  displayLabel="Publication" type="host">
    <md:titleInfo xml:lang="da">
        <md:title>B.T.</md:title>
    </md:titleInfo>
</md:relatedItem>
```

### Complex and multipage resources

COP supports a hierarchical table of contents. A fairly large
proportion of the objects are complex and use this feature. There,
however, only very few other fields than an image URI. The system
supports titles on each item though. [This is one such
object](http://www.kb.dk/cop/syndication/manus/musman/2010/dec/viser/object23942/en/?format=mods)


```
 <md:relatedItem>
     <md:identifier>online_master_arkiv_5/non-archival/Manus/VMANUS/2009/jun/dfs_1906_6a_16/dfs_1906_6a_16_001.tif</md:identifier>
     <md:titleInfo xml:lang="da">
        <md:title>Chresten Jensens Visebog</md:title>
     </md:titleInfo>
     <md:relatedItem type="constituent">
        <md:identifier>online_master_arkiv_5/non-archival/Manus/VMANUS/2009/jun/dfs_1906_6a_16/dfs_1906_6a_16_002.tif</md:identifier>
     </md:relatedItem>
     <md:relatedItem type="constituent">
        <md:identifier>online_master_arkiv_5/non-archival/Manus/VMANUS/2009/jun/dfs_1906_6a_16/dfs_1906_6a_16_003.tif</md:identifier>
        <md:titleInfo xml:lang="da">
          <md:title>01 Held Danmarks gamle rige</md:title>
        </md:titleInfo>
     </md:relatedItem>
     <md:relatedItem type="constituent">
        <md:identifier>online_master_arkiv_5/non-archival/Manus/VMANUS/2009/jun/dfs_1906_6a_16/dfs_1906_6a_16_004.tif</md:identifier>
        <md:relatedItem type="constituent">
          <md:identifier>online_master_arkiv_5/non-archival/Manus/VMANUS/2009/jun/dfs_1906_6a_16/dfs_1906_6a_16_005.tif</md:identifier>
          <md:titleInfo xml:lang="da">
            <md:title>02 Frivillige møder vi</md:title>
          </md:titleInfo>
        </md:relatedItem>
```

## Europeana Semantic Elements (ESE)

[ESE](http://pro.europeana.eu/page/ese-documentation) is only
supported by the [OAI server](README.md#dissemination-of-metadata),
not the syndication services. EDM is not supported.


