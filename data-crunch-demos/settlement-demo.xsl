<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:t="http://www.tei-c.org/ns/1.0"
	       version="1.0">

  <xsl:template match="/">
      <xsl:for-each select="//t:settlement[@xml:lang='en']">
	<xsl:element name="a">
	  <xsl:attribute name="href">http://www.kb.dk/cop/syndication/letters/judsam/2011/mar/dsa/en/?query=<xsl:value-of select="translate(.,' ','+')"/></xsl:attribute>
	  <xsl:value-of select="."/>
	</xsl:element><xsl:text>
</xsl:text>
      </xsl:for-each>
  </xsl:template>

</xsl:transform>