# COP COLR fields

The index is built for the purpose of making a single bibliographic search index on top of a heterogeneous collection.
It is built based on a much more fine grained description in MODS.
The index contains 

1. fields required by SOLR and related functions
2. fairly course grained fields having Dublin Core or ESE semantics
3. fine grained fields for access to some data in the MODS

The source, when given, is the xpath to where it is stored in the MODS

| field(s) | source | semantics | purpose |
|:---------|:-------|:----------|:--------|
| id | /md:mods/md:recordInfo/md:recordIdentifier |||


