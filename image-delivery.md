
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

The identifier of an image is found in an element called md:identifier (see the metadata section)

```
 <md:identifier displayLabel="image" 
                type="uri"> Image Uri  </md:identifier>
```

http://www.kb.dk/imageService/online_master_arkiv_3/non-archival/Images/SKETCHBOOKS_VANDMAERKER/alfred_schmidt_sketchbooks/2002-179_20/db_alfred_schmidt_02242.jpg

## Constructing IIIF json URIs

Our image client is OpenSeaDragon (OSD). OSD is used in COP and other
services. OSD is configured on a per object basis using a json-baserad
API.
