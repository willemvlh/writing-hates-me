<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet expand-text="yes" exclude-result-prefixes="#all" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wvl="wvl" version="3.0">
   <xsl:output method="html" version="5" encoding="UTF-8" indent="no"/>
   <xsl:include href="header.xsl"/>
   <xsl:include href="shared.xsl"/>
   <xsl:mode on-no-match="shallow-copy"/>
   <xsl:template name="xsl:initial-template">
      <html>
         <head>
             <style>

         <xsl:sequence select="unparsed-text(('src/style.css')) => normalize-space() => replace('\r|\n', '')"/>  
      </style>
            <title>Writing hates me</title>
         </head>
         <body>
            <xsl:call-template name="header"/>
            <div id="posts">
               <xsl:apply-templates select="collection()"> <!-- filepath doesn't matter, it's hardcoded in transform.js -->
                  <xsl:sort select="post/date" order="descending" data-type="text"/>
               </xsl:apply-templates>
            </div>
         </body>
      </html>
   </xsl:template>
   
   <xsl:template match="post">
      <div class="post">
         <a href="{wvl:compute-url(.)}"><h2>{title}</h2></a>
         <span class="date">{date}</span>
      </div>
   </xsl:template>
   
   <xsl:template match="title">
      <h1>{.}</h1>
   </xsl:template>
   
   <xsl:template match="date">
      <h4>{.}</h4>
   </xsl:template>
   
   <xsl:template match="text()[normalize-space() = '']"/>
</xsl:stylesheet>
