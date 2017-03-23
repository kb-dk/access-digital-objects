# Examples

Our web services were created some years ago to be able to build our digital collection web portal http://www.kb.dk/editions/any/2009/jul/editions/da/
So here is a good place to start and explore our data.

Please note that it is important to understand that for historical reason:

 * The ID of every object in our system is not a number but a string who looks like an URL. 

    For example if you take this portrait of Søren Kiekegaard: 
http://www.kb.dk/images/billed/2010/okt/billeder/object76439/

    The ID of this image is not *object76439* but the string  *images/billed/2010/okt/billeder/object76439*
(Note then that changing any parameters here like the date or the year will not give any new result)

 * The "base URL" of our web service is http://ww.kb.dk/editions/any/2009/jul/editions/da/
 

The data is structured by editions, an object is unique but can be in several editions.
Each editions have categories, and each categories can have sub-categories.   
As you can notice in our [COP web portal](http://www.kb.dk/editions/any/2009/jul/editions/da/) we have around 14 editions 
 * Billede: http://www.kb.dk/images/billed/2010/okt/billeder/da/
 * Partiprogrammer: http://www.kb.dk/pamphlets/dasmaa/2008/feb/partiprogrammer/da/
 * Judaistisk Samling: Tidlige & sjældne tryk: http://www.kb.dk/books/judsam/2010/maj/jstryk/da/
 * and so on ...


her are a descriptions of three concrete examples:

+ If you want to find any data about Søren Kierkegaard:
  
  http://www.kb.dk/editions/any/2009/jul/editions/da/?searchAcrossEditions=true&query=Søren+kierkegaard
  
+ If you want to get all the "søkort" from Bornholm:

+ Or get all the småtry/partiprogrammer of the socialdemokraterne in the period 1900-1930: