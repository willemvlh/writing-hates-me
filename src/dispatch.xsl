<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wvl="wvl" version="3.0">
   <xsl:include href="shared.xsl"/>
   <xsl:template name="xsl:initial-template">
      <xsl:result-document href="../pages/main.html" method="html">
         <xsl:sequence select="transform(map{
            'stylesheet-location': './main.xsl',
            'initial-template': xs:QName('xsl:initial-template')
            })?output"/>
      </xsl:result-document>
      <xsl:apply-templates select="collection('../posts')"/>
   </xsl:template>
   
   <xsl:template match="/">
      <xsl:result-document href="../pages/{wvl:compute-url(post)}">
         <xsl:sequence select="transform(map{
            'stylesheet-location': './post.xsl',
            'source-node': .
            })?output"/>
      </xsl:result-document>
   </xsl:template>
   
   
</xsl:stylesheet>
