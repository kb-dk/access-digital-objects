[READ ME](README.md) - [OAI Dissemination](oai-pmh.md) - [Web services in COP](cop-backend.md) - [Aerial Photography](geographic-data.md) - [Image delivery](image-delivery.md) - [Metadata Formats](metadata-formats.md) - [Text Corpora](text-corpora.md)

# OAI Dissemination API

Our dissemination API is OAI-PMH, and our targets are COP, Aleph (our
OPAC) and the National aggregator. The most important aggregators are,
the National Aggregator (which is our own OAI to OAI gateway and
aggregation service), REX, our discovery system and Europeana.

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
| [oai:kb.dk:letters:judsam:2011:mar:dsa](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:letters:judsam:2011:mar:dsa&metadataPrefix=ese) | David Simonsens Arkiv |
| [oai:kb.dk:manus:judsam:2010:maj:jsmss](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2010:maj:jsmss&metadataPrefix=ese) | Judaistisk Samling: Håndskrifter | 
| [oai:kb.dk:images:luftfo:2011:maj:luftfoto](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:images:luftfo:2011:maj:luftfoto&metadataPrefix=ese) | Luftfoto |
| [oai:kb.dk:pamphlets:dasmaa:2012:jul:smaatryk](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:pamphlets:dasmaa:2012:jul:smaatryk&metadataPrefix=ese) | Småtryk |
| [oai:kb.dk:maps:kortsa:2012:jul:kortatlas](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:maps:kortsa:2012:jul:kortatlas&metadataPrefix=ese) | Kort og Atlas |
| [oai:kb.dk:pamphlets:dasmaa:2008:feb:partiprogrammer](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:pamphlets:dasmaa:2008:feb:partiprogrammer&metadataPrefix=ese) | Partiprogram |
| [oai:kb.dk:images:billed:2010:okt:billeder](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:images:billed:2010:okt:billeder&metadataPrefix=ese) | Billeder | 
| [oai:kb.dk:manus:ortsam:2009:okt:orientalia](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:ortsam:2009:okt:orientalia&metadataPrefix=ese) | Oriental Collection: Manuscripts |
| [oai:kb.dk:pamphlets:dasmaa:2008:feb:daellsvarehus](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:pamphlets:dasmaa:2008:feb:daellsvarehus&metadataPrefix=ese) | Varehuskataloger |
| [oai:kb.dk\\:books:judsam:2010:maj:jstryk](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:books:judsam:2010:maj:jstryk&metadataPrefix=ese) | Judaistisk Samling: Tidlige & sjældne tryk |
| [oai:kb.dk:manus:judsam:2009:sep:dsh](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:judsam:2009:sep:dsh&metadataPrefix=ese) | David Simonsens Håndskrifter |
| [oai:kb.dk\\:books:ortsam:2011:mar:ostryk](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:books:ortsam:2011:mar:ostryk&metadataPrefix=ese) | Tidlige tryk i Orientalsk Samling |
| [oai:kb.dk:manus:musman:2010:dec:viser](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:musman:2010:dec:viser&metadataPrefix=ese) | DFS |
| [oai:kb.dk:images:billed:2014:jun:hca](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:images:billed:2014:jun:hca&metadataPrefix=ese) | H.C. Andersen |
| [oai:kb.dk:manus:vmanus:2011:dec:ha](http://www.kb.dk/cop/oai/?verb=ListRecords&set=oai:kb.dk:manus:vmanus:2011:dec:ha&metadataPrefix=ese) | Vesterlandske håndskrifter |


