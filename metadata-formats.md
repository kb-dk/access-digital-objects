
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

### Geography

```
<georss:point>55.27093341035208 10.155321304320978</georss:point>
<geo:lat>55.27093341035208</geo:lat>
<geo:long>10.155321304320978</geo:long>
```

Which is the position of a [building in DSFL](http://www.kb.dk/cop/syndication/images/luftfo/2011/maj/luftfoto/object176012/da/).

The `geo` name space refer to https://www.w3.org/2003/01/geo/wgs84_pos and the `georss` to http://www.georss.org/georss

### Other aspects




## format=mods

