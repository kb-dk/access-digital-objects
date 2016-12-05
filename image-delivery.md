
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
(see the metadata section) with displayLabel="image" and
displayLabel="thumbnail", respectively.

```
 <md:identifier displayLabel="image" 
                type="uri"> Image Uri  </md:identifier>
```
or

```
 <md:identifier displayLabel="thumbnail" 
                type="uri"> Thumbnail Uri  </md:identifier>
```

The URIs in the two has the forms

http://www.kb.dk/imageService/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011.jpg
 
and

http://www.kb.dk/imageService/w150/h150/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011.jpg

respectivly. The forms are old and predates our implementation of
IIIF. The image's width and height ca be set using the parameters w
and h in the URI path. Only one of them are needed. E.g.,

http://www.kb.dk/imageService/w640/online_master_arkiv_6/non-archival/Images/BILLED/2008/Billede/dk_eksp_album_191/kbb_alb_2_191_friis_011.jpg

will return a 640 px wide image.


## Constructing IIIF URIs

Our image client is OpenSeaDragon (OSD). OSD is used in COP and other
services. OSD is configured on a per object basis using a json-baserad
API.
