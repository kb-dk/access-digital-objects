[README](README.md) [Web services in COP](cop-backend.md) [Aerial Photograph Collection](geographic-data.md)  [Image delivery](image-delivery.md) [Metadata Formats](metadata-formats.md)

# Image delivery

Just about everything in COP is about images, i.e., digital images of
sheets of paper. Front and back of a photograph or a page in book is
special case of that. Note, however, that an image of a text is
actually a text, just as an image of a photograph is a photograph.

The COPs APIs are basically about enabling the building of user
interfaces for all these objects. The images themselves, however, are
delivered by a special protocol, IIIF Image API cf. the [IIIF
Documents](http://iiif.io/api/image/2.1/). We give a short
introduction on how to construct an image URI given the data you may
get from COP.

Two cases arise:

## Constructing single image URIs

The identifier of an image is found in an element called md:identifier
(see the [metadata section](metadata-formats.md#identifiers) for more
information on how to find them in the MODS section) with
displayLabel="image" and displayLabel="thumbnail", respectively.


```
 <md:identifier displayLabel="image" 
                type="uri"> Image Uri </md:identifier>
```
or

```
 <md:identifier displayLabel="thumbnail" 
                type="uri"> Thumbnail Uri </md:identifier>
```

The URIs in the two has the forms

http://www.kb.dk/imageService/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011.jpg
 
and

http://www.kb.dk/imageService/w150/h150/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011.jpg

and return 1024 and 150 px wide images, respectively.

These forms are old and deprecated and predate our implementation of IIIF. The
image's width and height ca be set using the parameters w and h in the
URI path. Only one of them are needed. E.g.,

http://www.kb.dk/imageService/w640/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011.jpg

will return a 640 px wide image.

## Constructing IIIF URIs

The [IIIF Image API](http://iiif.io/api/image/2.1/) use other syntaxes.

In the Image Uri mentioned above, the substing after `imageService` and before `.jpg` is

imageService/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011

prepending `http://kb-images.kb.dk/` and `appending` /info.json to
that string we get the URI of the technical metadata of the image in
json format from the server. I.e.,

http://kb-images.kb.dk/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011/info.json

returning

```
{
  "@context" : "http://iiif.io/api/image/2/context.json",
  "@id" : "http://kb-images.kb.dk/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011",
  "protocol" : "http://iiif.io/api/image",
  "width" : 2940,
  "height" : 2212,
  "sizes" : [
     { "width" : 183, "height" : 138 },
     { "width" : 367, "height" : 276 },
     { "width" : 735, "height" : 553 },
     { "width" : 1470, "height" : 1106 }
  ],
  "tiles" : [
     { "width" : 256, "height" : 256, "scaleFactors" : [ 1, 2, 4, 8, 16 ] }
  ],
  "profile" : [
     "http://iiif.io/api/image/2/level1.json",
     { "formats" : [ "jpg" ],
       "qualities" : [ "native","color","gray" ],
       "supports" : ["regionByPct","sizeByForcedWh","sizeByWh","sizeAboveFull","rotationBy90s","mirroring","gray"] }
  ]
}
```

Note the @id in the json-ld above. Append '/full/!2000,/0/native.jpg' to that you get 

http://kb-images.kb.dk/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011/full/!2000,/0/native.jpg

That is, you can dereference that URI to a 2000 px wide image.

Image URIs may appear in a few more formats. Note, for example, the
htmlUrl in outlines of [Chresten Jensens
Visebog](cop-backend.md#content-service) are actually links to tif
files. You can easily retrieve a 
[json-ld file for each page](http://kb-images.kb.dk/online_master_arkiv_5/non-archival/Manus/VMANUS/2009/jun/dfs_1906_6a_16/dfs_1906_6a_16_001/info.json)
in the manuscript and then [download them](http://kb-images.kb.dk/online_master_arkiv_5/non-archival/Manus/VMANUS/2009/jun/dfs_1906_6a_16/dfs_1906_6a_16_001/full/!1024,/0/native.jpg)

~~Our image client is OpenSeaDragon (OSD). OSD is used in COP and other services. OSD is configured on a per object basis using a json-baserad API~~
