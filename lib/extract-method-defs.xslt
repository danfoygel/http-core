<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:x="http://purl.org/net/xml2rfc/ext"
               xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'
               version="1.0"
               exclude-result-prefixes="rdf x"
>

<xsl:output indent="yes" omit-xml-declaration="yes"/>

<xsl:template match="/">
  <xsl:variable name="table">
    <table anchor="iana.method.registration.table">
      <thead>
        <tr>
          <th>Method</th>
          <th>Safe</th>
          <th>Idempotent</th>
          <th>See</th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="//section[iref[contains(@item,' method') and @primary='true']]">
          <xsl:sort select="iref[contains(@item,' method') and @primary='true']/@item"/>
        </xsl:apply-templates>
      </tbody>
    </table>
    <xsl:text>&#10;</xsl:text>
  </xsl:variable>

  <xsl:comment>AUTOGENERATED FROM extract-method-defs.xslt, do not edit manually</xsl:comment>
  <xsl:text>&#10;</xsl:text>
  <xsl:copy-of select="$table"/>
  <xsl:comment>(END)</xsl:comment>
  <xsl:text>&#10;</xsl:text>
  
  <!-- check against current version -->
  <xsl:variable name="oldtable" select="//table[@anchor='iana.method.registration.table']" />

  <xsl:variable name="s">
    <xsl:apply-templates select="$table//table" mode="tostring"/>
  </xsl:variable>
  
  <xsl:variable name="s1">
    <xsl:apply-templates select="$oldtable" mode="tostring"/>
  </xsl:variable>

  <xsl:if test="$s != $s1">
    <xsl:message>WARNING: table contained inside source document needs to be updated</xsl:message>
    <xsl:message><xsl:value-of select="$s"/></xsl:message>
    <xsl:message><xsl:value-of select="$s1"/></xsl:message>
  </xsl:if>
  
</xsl:template>

<xsl:template match="*" mode="tostring">
  <xsl:text>&lt;</xsl:text>
  <xsl:value-of select="name()"/>
  <xsl:for-each select="@*">
    <xsl:sort select="name()"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>=</xsl:text>
    <xsl:value-of select="."/>
  </xsl:for-each>
  <xsl:text>&gt;</xsl:text>
  
  <xsl:apply-templates select="node()" mode="tostring"/>
  
  <xsl:text>&lt;/</xsl:text>
  <xsl:value-of select="name()"/>
  <xsl:text>&gt;</xsl:text>

</xsl:template>

<xsl:template match="text()" mode="tostring">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="table/text()" mode="tostring"/>
<xsl:template match="tr/text()" mode="tostring"/>
<xsl:template match="thead/text()" mode="tostring"/>
<xsl:template match="tbody/text()" mode="tostring"/>
<xsl:template match="td[xref]/text()" mode="tostring"/>

<xsl:template match="section">
  <xsl:variable name="t" select="iref[contains(@item,' method')]/@item"/>
  <xsl:variable name="text" select="substring-before($t,' method')"/>

  <xsl:variable name="safe" xmlns:p2="urn:ietf:id:draft-ietf-httpbis-p2-semantics#">
    <xsl:choose>
      <xsl:when test="rdf:Description/p2:safe='yes'">yes</xsl:when>
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="idempotent" xmlns:p2="urn:ietf:id:draft-ietf-httpbis-p2-semantics#">
    <xsl:choose>
      <xsl:when test="rdf:Description/p2:idempotent='yes'">yes</xsl:when>
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:text>&#10;</xsl:text>
  <tr>
    <td><xsl:value-of select="$text"/></td>
    <td><xsl:value-of select="$safe"/></td>
    <td><xsl:value-of select="$idempotent"/></td>
    <td><xref target="{@anchor}" format="counter"/></td>
  </tr>
</xsl:template>

</xsl:transform>
