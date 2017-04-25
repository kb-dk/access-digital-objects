<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:t="http://www.tei-c.org/ns/1.0"
	       xmlns:md="http://www.loc.gov/mods/v3"
	       version="1.0">

  <!-- <xsl:text> </xsl:text><xsl:value-of select="md:dateCreated/@t:notAfter"/> -->

  <xsl:template match="/">

      <xsl:for-each select="//md:originInfo[1]">
	  <xsl:value-of select="md:dateCreated/@t:notBefore"/><xsl:text>
</xsl:text>
      </xsl:for-each>

  </xsl:template>

</xsl:transform>