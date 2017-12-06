<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:crs="http://www.examples.org/ClassRoomSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" doctype-public="html" encoding="UTF-8"
		indent="yes" />

	<xsl:variable name="pageTitle">
		List of Students
	</xsl:variable>
	<xsl:variable name="tableHeader">
		<tr>
			<th>Name</th>
			<th>Login</th>
		</tr>
	</xsl:variable>
	<xsl:variable name="url" select="//@webpage" />

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="$pageTitle" />
				</title>
			</head>
			<body>
				<h1>
					<xsl:value-of select="$pageTitle" />
				</h1>
				<table border="1">
					<xsl:copy-of select="$tableHeader" />
					<xsl:apply-templates select="crs:Class/crs:Student">
						<xsl:with-param name="nameSplitter" select="'-'" />
						<xsl:sort order="ascending" select="crs:LastName" />
					</xsl:apply-templates>
				</table>
				<h1>Professor</h1>
				<xsl:copy-of select="crs:Class/crs:Professor" />
				<xsl:for-each select="crs:Class/crs:Student">
					<br />
					<xsl:number value="position()" format="1" />
					<xsl:value-of select="./crs:FirstName" />
					<!-- <xsl:copy-of select="."></xsl:copy-of> -->
				</xsl:for-each>
				<br />
				<xsl:number value="250000.01" grouping-separator="." />

				<br />
				<br />
				<xsl:for-each select="crs:Class/crs:Student">
					<xsl:value-of select="./@Title" />
					<xsl:value-of select="./crs:FirstName"
						disable-output-escaping="yes" />
					<xsl:if test="position()!=last() and position()!=last()-1">
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:if test="position()=last()-1">
						<xsl:text> and </xsl:text>
					</xsl:if>
					<xsl:if test="position()=last()">
						<xsl:text>!</xsl:text>
					</xsl:if>
				</xsl:for-each>

				<br />
				<br />
				<br />
				<xsl:for-each select="crs:Class/crs:Student">
					<xsl:sort select="./crs:FirstName" order="ascending" />
					<xsl:value-of select="./@Title" />
					<xsl:value-of select="./crs:FirstName"
						disable-output-escaping="yes" />
					<xsl:choose>
						<xsl:when test="position()=last()-1">
							<xsl:text> and </xsl:text>
						</xsl:when>
						<xsl:when test="position()=last()">
							<xsl:text>!</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/crs:Class/crs:Student">
		<xsl:param name="nameSplitter" select="','">
			<xsl:call-template name="Name">
				<xsl:with-param name="nameSplitter">
					<xsl:value-of select="$nameSplitter" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:param>
		<tr>
			<td>
				<xsl:call-template name="Name" />
			</td>
			<td>
				<xsl:value-of select="./crs:Login" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="Name">
		<xsl:param name="nameSplitter" select="','" />
		<xsl:value-of select="./crs:FirstName"
			disable-output-escaping="yes" />
		<xsl:text disable-output-escaping="no"> </xsl:text>
		<xsl:value-of select="$nameSplitter" />
		<xsl:value-of select="./crs:LastName"
			disable-output-escaping="yes" />
	</xsl:template>

</xsl:stylesheet>