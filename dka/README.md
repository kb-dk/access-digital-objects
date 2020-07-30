# Harvesting using OAI -- a worked example

Run as

```
cd harvested_records
xsltproc ../ese2dka.xsl 'http://oai.kb.dk/oai/provider?verb=ListRecords&metadataPrefix=ese&set=kb.partiprogrammer'
```

which will result in 2510 xml files in the directory harvested_records,
containing descriptions of as many political pamphlets. The ese2dka.xsl is
recursive and will retrieve all content for a given set (i.e., it is actually
a complete and simple OAI-PMH harvester written in XSLT 1.0).

Any edition from the Royal Library, Copenhagen and its content providers can
be harvested from oai.kb.dk. See 

http://oai.kb.dk/oai/provider?verb=ListSets

for a complete list of editions. Another possible harvests are

```
cd harvested_records
xsltproc ../ese2dka.xsl 'http://oai.kb.dk/oai/provider?verb=ListRecords&metadataPrefix=ese&set=kb.orientalmss'
xsltproc ../ese2dka.xsl 'http://oai.kb.dk/oai/provider?verb=ListRecords&metadataPrefix=ese&set=kb:kortatlas:ww1'
```

which yields descriptions of 42 oriental manuscripts and 180 maps related to
the first worldwar.

There is a set of files created during testing of the
harvester/transformation.

All harvested records validates against the DKA2.xsd






