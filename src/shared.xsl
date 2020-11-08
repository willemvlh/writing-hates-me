<xsl:stylesheet exclude-result-prefixes="#all" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xmlns:wvl="wvl" xmlns:xs="http://www.w3.org/2001/XMLSchema">
   <xsl:function name="wvl:compute-url" as="xs:string">
      <xsl:param name="post" as="element(post)"/>
      <xsl:sequence select="tokenize($post/title => lower-case(), ' ') => string-join('-') || '-' || $post/date || '.html'"/>
   </xsl:function>
   <xsl:function name="wvl:format-date" as="xs:string">
      <xsl:param name="date" as="xs:date"/>
      <xsl:sequence select="format-date($date, '[D01] [Mn] [Y]')"/>
   </xsl:function>
</xsl:stylesheet>
