<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:oa="http://www.openarchives.org/OAI/2.0/"
	       xmlns:ese="http://www.europeana.eu/schemas/ese/"
	       xmlns:dc="http://purl.org/dc/elements/1.1/"
	       xmlns:dcterms="http://purl.org/dc/terms/"
	       xmlns:exsl="http://exslt.org/common"
	       extension-element-prefixes="exsl"
	       version="1.0">

  <xsl:param name="base_uri" select="/oa:OAI-PMH/oa:request"/>
  <xsl:param name="set_spec" select="/oa:OAI-PMH/oa:request/@set"/>
  <xsl:param name="prefix"   select="/oa:OAI-PMH/oa:request/@metadataPrefix"/>

  <xsl:template match="/">
    <xsl:apply-templates select="/oa:OAI-PMH"/>
  </xsl:template>

  <xsl:template match="oa:OAI-PMH">
    <xsl:apply-templates select="oa:ListRecords"/>
  </xsl:template>

  <xsl:template match="oa:ListRecords">
    <xsl:apply-templates select="oa:record[oa:metadata/node()]"/>
    <xsl:apply-templates select="oa:resumptionToken"/>
  </xsl:template>

  <xsl:template match="oa:record">
    <exsl:document href="{concat(oa:header/oa:identifier/text(),'.xml')}"
		   method="xml" 
		   encoding="UTF-8"
		   indent="yes">
      <xsl:apply-templates select="oa:metadata"/>
    </exsl:document>
  </xsl:template>

  <xsl:template match="oa:metadata">
    <xsl:apply-templates select="ese:record"/>
  </xsl:template>

  <xsl:template match="oa:resumptionToken">
    <xsl:variable name="next_chunk_uri">
      <xsl:value-of select="concat($base_uri,'?resumptionToken=',.,'&amp;verb=ListRecords')"/>
    </xsl:variable>
    <xsl:message>
      Resuming harvesting with <xsl:value-of select="$next_chunk_uri"/>
    </xsl:message>
    <xsl:apply-templates select="document($next_chunk_uri)/oa:OAI-PMH"/>
  </xsl:template>

  <xsl:template match="ese:record">
    <DKA xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	 xsi:schemaLocation="http://www.danskkulturarv.dk/DKA2.xsd ../schemas/DKA.xsd"
	 xmlns="http://www.danskkulturarv.dk/DKA2.xsd"  >
      <Title>
	<xsl:for-each select="dc:title">
	  <xsl:value-of select="."/><xsl:if test="position() &lt; last()"><xsl:text>; </xsl:text></xsl:if>
	</xsl:for-each>
      </Title>
      <Abstract />
      <Description>
	<div xmlns="http://www.w3.org/1999/xhtml">
	  <div style="vertical-align:top;width:25%;float:left;">
	    <h4>
	      <xsl:for-each select="dc:title">
		<xsl:value-of select="."/>
		<xsl:if test="position() &lt; last()">
		  <br/>
		</xsl:if>
	      </xsl:for-each>
	    </h4>

	    <xsl:if test="dc:description">
	      <p>
		<strong>Beskrivelse</strong>
		<br/>
		<xsl:for-each select="dc:description">
		  <xsl:value-of select="."/>
		  <xsl:text>
		  </xsl:text>
		</xsl:for-each>
	      </p>
	    </xsl:if>

	    <xsl:if test="dc:format">
	      <p>
		<strong>Format</strong>
		<br/>
		<xsl:for-each select="dc:format">
		  <xsl:value-of select="."/>
		</xsl:for-each>
	      </p>
	    </xsl:if>

	    <xsl:if test="dc:creator|dc:contributor">
	      <p>
		<strong>Kolofon</strong>
		<br/>
		<xsl:for-each select="dc:creator|dc:contributor">
		  <xsl:if test="position() = last() and last() &gt; 1"><xsl:text> og </xsl:text></xsl:if>
		  <xsl:value-of select="."/>
		  <xsl:if test="position() &lt; last()"><xsl:text>, </xsl:text></xsl:if>
		</xsl:for-each>
	      </p>
	    </xsl:if>


	    <p>
	      <strong>
		<a target="_blank" href="{ese:isShownAt}">Mere om objektet</a>
	      </strong>
	    </p>

	    <p>
	      <strong>
		<a target="_blank">
		  <xsl:attribute name="href">
		    <xsl:value-of select="concat(substring-before(ese:isShownAt,'/object'),'/da/')"/>
		  </xsl:attribute>
		Mere fra samme udgivelse</a>
	      </strong>
	    </p>

	    <div><strong>Copyright</strong>
	    <br/>
	    © <xsl:value-of select="ese:dataProvider"/>
	    </div>

	  </div>

	  <div style="vertical-align:top;width:75%;float:left;">
	    <xsl:element name="img">
	      <xsl:attribute name="style">width:100%;</xsl:attribute>
	      <xsl:attribute name="alt">
		<xsl:value-of select="dc:title"/>
	      </xsl:attribute>
	      <xsl:attribute name="src">
		<xsl:value-of select="ese:object"/>
	      </xsl:attribute>
	    </xsl:element>
	  </div>

	</div>

      </Description>
      <Organization>
	<xsl:value-of select="ese:dataProvider"/>
      </Organization>
      <ExternalURL>
	<xsl:value-of select="ese:isShownAt"/>
      </ExternalURL>
      <Type>
	<xsl:for-each select="ese:type">
	  <xsl:value-of select="."/>
	</xsl:for-each>
      </Type> 

      <!--
      <CreatedDate/>
      <FirstPublishedDate/>
      -->

      <Contributors>
	<xsl:for-each select="dc:contributor">
	  <xsl:element name="Contributor">
	    <xsl:attribute name="Role">contributor</xsl:attribute>
	    <xsl:attribute name="Name">
	      <xsl:value-of select="."/>
	    </xsl:attribute>
	  </xsl:element>
	</xsl:for-each>
      </Contributors>

      <Creators>
	<xsl:for-each select="dc:creator">
	  <xsl:element name="Creator">
	    <xsl:attribute name="Role">creator</xsl:attribute>
	    <xsl:attribute name="Name">
	      <xsl:value-of select="."/>
	    </xsl:attribute>
	  </xsl:element>
	</xsl:for-each>
      </Creators>

      <TechnicalComment />
      <Location>
	<xsl:apply-templates select="dc:coverage"/>
      </Location>
      <RightsDescription>
	<xsl:text>Copyright © </xsl:text><xsl:value-of select="ese:dataProvider"/>
      </RightsDescription>
      <!--
      <GeoData>
	<Latitude/>
	<Longitude/>
      </GeoData>
      -->
      <Categories />
      <Tags>
	<xsl:for-each select="dc:subject">
	<Tag>
	  <xsl:apply-templates select="."/>
	</Tag>
	</xsl:for-each>
      </Tags>
    </DKA>
  </xsl:template>

</xsl:transform>
