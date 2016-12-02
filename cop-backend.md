

## Web services in COP

### Syndication service formats

The syndication service is for searching. By default it delivers a
search result set in [rss 2.0](https://cyber.harvard.edu/rss/rss.html).

1. For RSS 2.0, the root document is rss, i.e., 

``` <rss> ... </rss> ```

The syndication service supports some other formats as well, the most
important ones are mods and kml. You can "toggle" between the formats using the 
`format` CGI parameter. 

2. When set to `mods`, the service delivers

```
<modsCollection> ... </modsCollection>
```

3. When set to `kml` it delivers a `kml` document
```
<kml> ... </kml>
```

Format 1 and 3 are used internally in our services. All search and retrieval in 
[Digital Editions - COP](http://www.kb.dk/editions/any/2009/jul/editions/en/)
is based on the former,
the latter is tranlated to ```json``` and is then used in [DSFL](http://www.kb.dk/danmarksetfraluften/) (DFSL)

### Open Search

Clients communicates with the server with Amazon A9.com [Open
search](http://www.opensearch.org/Home) protocol.

The RSS syntax includes all data for resultset navigation. I.e.,

```
<startIndex xmlns="http://a9.com/-/spec/opensearch/1.1/">1</startIndex>
    <itemsPerPage xmlns="http://a9.com/-/spec/opensearch/1.1/">40</itemsPerPage>
    <Query xmlns="http://a9.com/-/spec/opensearch/1.1/" role="request" searchTerms="{}" startPage="1"/>
    <totalResults xmlns="http://a9.com/-/spec/opensearch/1.1/">104820</totalResults>
    <link xmlns="http://www.w3.org/2005/Atom" 
          href="http://www.kb.dk/cop/images/billed/2010/okt/billeder" 
	  rel="search" 
	  type="application/opensearchdescription+xml"/>
    <link xmlns="http://www.w3.org/2005/Atom" href="http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/" 
          rel="search" 
	  type="application/rss+xml"/>
```

+ search "by subject", searching by navigation -- examples
  + http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/en/?page=1&subject=2120&itemsPerPage=40
    which is synonymous with
  + http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/subject2120/en/?page=1 
    The result set can be further molded by the itemsPerPage parameter. For example
  + http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/subject2109/en/?itemsPerPage=5
+ search "by querying", ordinary search -- for example
  http://www.kb.dk/cop/syndication/images/billed/2010/okt/billeder/en/?page=1&query=jesus&itemsPerPage=40

We have more [detailed information on geographical searching](open-search-dsfl.md).

### Navigation service

The subject hierarchy needed for filtering and for building the
browsing service can be retrieved from the navigation service. Links
to RSS & HTML representations of the data -- ex

http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder and
http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder/subject841/

This service accepts the parameter `opml_mode` with values
`deep` and `shallow`. For example:

```
http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder/subject2109/?opml_mode=deep
```

and

```
http://www.kb.dk/cop/navigation/images/billed/2010/okt/billeder/subject2109/?opml_mode=shallow
```

Shallow was intended to give the current subject and its descendants. (This seems broken in the current implementation)

### Content service 

Tables of contents for complex digital objects are delivered through the content service. 

http://www.kb.dk/cop/content/manus/musman/2010/dec/viser/object23942/en/

and

http://www.kb.dk/cop/content/letters/judsam/2011/mar/dsa/object10/en/

representing TOCs of a song book and a two page letter, respectively


### Complete list of supported CGI parameters in COP 

| Parameter | Used in PATH | Used in CGI | Comment | Status|
|-----------|:-------------|:------------|:--------|-------|
|query | - | x | Synonym to q | ok |
|format | - | x | kml, rss and mods | ok |
|page | - | x | | ok |
|itemsPerPage | - | x | |ok |
|object | x | - | | ok |
|subject | x | - | Synonym to categories | ok |
|bbo | - | x | Bounding Box |
|notBefore | - | x | Not before a given date | - |
|notAfter | - | x | Not after a given date | - |


