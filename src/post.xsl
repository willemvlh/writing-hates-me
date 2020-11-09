<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet expand-text="yes" exclude-result-prefixes="#all" xmlns:wvl="wvl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
   <xsl:output method="html" version="5" encoding="UTF-8" indent="no"/>
   <xsl:include href="header.xsl"/>
   <xsl:include href="shared.xsl"/>
   <xsl:mode on-no-match="shallow-copy"/>
   <xsl:template match="post">
      <xsl:result-document href="{wvl:compute-url(.)}">
         <html>
            <head>
               <style>
                  <xsl:sequence select="unparsed-text(('src/style.css')) => normalize-space() => replace('\r|\n', '')"/> <!--hack-->  
      </style>
               <title>{title}</title>
            </head>
            <body>
               <xsl:call-template name="header"/>
               <xsl:apply-templates select="title"/>
               <xsl:apply-templates select="date"/>
               <xsl:apply-templates select="body/(* | text())"/>   
            </body>
         </html>   
      </xsl:result-document>
      
   </xsl:template>
   
   <xsl:template match="title">
      <h1>{.}</h1>
   </xsl:template>
   
   <xsl:template match="date">
      <h4>{wvl:format-date(.)}</h4>
   </xsl:template>
   
   <xsl:template match="text()[normalize-space() = '']"/>
</xsl:stylesheet>
