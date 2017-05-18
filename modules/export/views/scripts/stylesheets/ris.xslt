<?xml version="1.0" encoding="utf-8"?>
<!--
/**
 * This file is part of OPUS. The software OPUS has been originally developed
 * at the University of Stuttgart with funding from the German Research Net,
 * the Federal Department of Higher Education and Research and the Ministry
 * of Science, Research and the Arts of the State of Baden-Wuerttemberg.
 *
 * OPUS 4 is a complete rewrite of the original OPUS software and was developed
 * by the Stuttgart University Library, the Library Service Center
 * Baden-Wuerttemberg, the North Rhine-Westphalian Library Service Center,
 * the Cooperative Library Network Berlin-Brandenburg, the Saarland University
 * and State Library, the Saxon State Library - Dresden State and University
 * Library, the Bielefeld University Library and the University Library of
 * Hamburg University of Technology with funding from the German Research
 * Foundation and the European Regional Development Fund.
 *
 * LICENCE
 * OPUS is free software; you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the Licence, or any later version.
 * OPUS is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details. You should have received a copy of the GNU General Public License
 * along with OPUS; if not, write to the Free Software Foundation, Inc., 51
 * Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 * @category    Application
 * @package     Module_CitationExport
 * @author      Oliver Marahrens <o.marahrens@tu-harburg.de>
 * @author      Gunar Maiwald <maiwald@zib.de>
 * @author      Jens Schwidder <schwidder@zib.de>
 * @copyright   Copyright (c) 2017, OPUS 4 development team
 * @license     http://www.gnu.org/licenses/gpl.html General Public License
 */
-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    exclude-result-prefixes="php">

    <xsl:output method="text" omit-xml-declaration="yes" />

    <xsl:template match="/">
      <xsl:apply-templates select="Documents" />
    </xsl:template>
	
    <xsl:template match="Documents">
          <xsl:apply-templates select="Opus_Document" />
    </xsl:template>

    <!-- Suppress spilling values with no corresponding templates
      <xsl:template match="@*|node()" />-->
    <!--
        here you can change the order of the fields, just change the order of the
        apply-templates-rows 
        if there is a choose-block for the field, you have to move the whole
        choose-block
        if you wish new fields, you have to add a new line xsl:apply-templates...
        and a special template for each new field below, too
    -->
    <xsl:template match="Opus_Document">
	       <xsl:choose>
           <xsl:when test="@Type='book'">
               <xsl:text>TY  - BOOK</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='bookpart'">
               <xsl:text>TY  - CHAP</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='conferenceobject'">
               <xsl:text>TY  - CHAP</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='coursematerial' or @Type='image' or @Type='lecture' or @Type='other' or @Type='sound' or @Type='studythesis'">
               <xsl:text>TY  - GEN</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='preprint'">
               <xsl:text>TY  - INPR</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='periodical'">
               <xsl:text>TY  - JFULL</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='article' or @Type='periodicalpart' or @Type='review' or @Type='contributiontoperiodical'">
               <xsl:text>TY  - JOUR</xsl:text>
           </xsl:when>
           <!--xsl:when test="@Type='contributiontoperiodical'">
               <xsl:text>TY  - MGZN</xsl:text>
           </xsl:when-->
          <xsl:when test="@Type='patent'">
               <xsl:text>TY  - PAT</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='report'">
               <xsl:text>TY  - RPRT</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='bachelorthesis' or @Type='doctoralthesis' or @Type='habilitation' or @Type='masterthesis'">
               <xsl:text>TY  - THES</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='workingpaper'">
               <xsl:text>TY  - RPRT</xsl:text>
           </xsl:when>
           <xsl:when test="@Type='movingimage'">
               <xsl:text>TY  - VIDEO</xsl:text>
           </xsl:when>
           <xsl:otherwise>
               <xsl:text>TY  - GEN</xsl:text>
           </xsl:otherwise>
       </xsl:choose>
       <xsl:text>&#10;</xsl:text>
       
       <xsl:if test="string-length(PersonAuthor/@LastName)>0">
           <xsl:apply-templates select="PersonAuthor" />
       </xsl:if>
       <xsl:if test="string-length(PersonEditor/@LastName)>0">
           <xsl:apply-templates select="PersonEditor" />
       </xsl:if>
       <xsl:if test="string-length(TitleMain/@Value)>0">
           <xsl:apply-templates select="TitleMain" />
       </xsl:if>
       <xsl:if test="string-length(TitleSub/@Value)>0">
           <xsl:apply-templates select="TitleSub" />
       </xsl:if>
       <xsl:if test="string-length(TitleParent/@Value)>0">
           <xsl:apply-templates select="TitleParent" />
       </xsl:if>
       <xsl:if test="string-length(TitleAbstract/@Value)>0">
           <xsl:apply-templates select="TitleAbstract" />
       </xsl:if>
       <xsl:if test="string-length(TitleAdditional/@Value)>0">
           <xsl:apply-templates select="TitleAdditional" />
       </xsl:if>
       <xsl:if test="Series">
           <xsl:apply-templates select="Series" />
       </xsl:if>
       
       <xsl:if test="string-length(Enrichment[@KeyName='VolumeSource']/@Value)>0">
           <xsl:apply-templates select="Enrichment[@KeyName='VolumeSource']" />
       </xsl:if>

       <xsl:if test="string-length(Subject/@Value)>0">
           <xsl:apply-templates select="Subject" />
       </xsl:if>
       
       <!--<xsl:if test="string-length(@CompletedYear)>0">
            <xsl:text>Y1  - </xsl:text>
            <xsl:value-of select="@CompletedYear" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>-->
		
		 <xsl:choose>
		<xsl:when test="normalize-space(ComletedDate/@Year)">
             <xsl:text>Y1  - </xsl:text><xsl:value-of select="ComletedDate/@Year" />
         </xsl:when>
         <xsl:when test="string-length(PublishedDate/@Year)>0">
             <xsl:text>Y1  - </xsl:text><xsl:value-of select="PublishedDate/@Year" />
         </xsl:when>
         <xsl:when test="normalize-space(@CompletedYear)">
             <xsl:text>Y1  - </xsl:text><xsl:value-of select="@CompletedYear" />
         </xsl:when>
         <xsl:otherwise>
             <xsl:text>Y1  - </xsl:text><xsl:value-of select="@PublishedYear" />
         </xsl:otherwise>
       </xsl:choose>
       <xsl:text>&#10;</xsl:text>
		
       
        <!-- BSZ - Angaben
	   <xsl:choose>
        <xsl:when test="string-length(PublishedDate/@Year)>0">
             <xsl:text>Y1  - </xsl:text><xsl:value-of select="PublishedDate/@Year" />
		     <xsl:text>&#10;</xsl:text>
         </xsl:when>
         <xsl:otherwise>
             <xsl:text>Y1  - </xsl:text><xsl:value-of select="@PublishedYear" />
			 <xsl:text>&#10;</xsl:text>
         </xsl:otherwise>
       </xsl:choose>
	   -->

 <!--  Frontdoor-Link raus - Boris 19.10.15      
       <xsl:text>UR  - http://ids-pub.bsz-bw.de</xsl:text>
 Zeile doppelt auskommentiert:        <xsl:value-of select="$url_prefix" />
        <xsl:text>/frontdoor/index/index/docId/</xsl:text>
        <xsl:value-of select="@Id" />
        <xsl:text>&#10;</xsl:text> -->

        <xsl:if test="string-length(IdentifierUrn/@Value)>0">
            <xsl:apply-templates select="IdentifierUrn" />
        </xsl:if>

        <xsl:if test="string-length(IdentifierUrl/@Value)>0">
            <xsl:apply-templates select="IdentifierUrl" />
        </xsl:if>
        <xsl:if test="string-length(IdentifierIsbn/@Value)>0">
            <xsl:apply-templates select="IdentifierIsbn" />
        </xsl:if>
		<!-- DOI nur ausgeben wenn keine URN existiert - Boris 19.10.15 -->
        <!-- anscheinend doch immer ausgeben (laut FG, Mail v. 22.10.), sonst: -->  
		<xsl:if test="string-length(IdentifierDoi/@Value) > 0  and string-length(normalize-space(IdentifierUrn/@Value)) = 0">
        <!-- <xsl:if test="string-length(IdentifierDoi/@Value) > 0">-->
			<xsl:apply-templates select="IdentifierDoi" />
        </xsl:if>
        <xsl:if test="string-length(IdentifierIssn/@Value)>0">
            <xsl:apply-templates select="IdentifierIssn" />
        </xsl:if>
        <xsl:if test="string-length(Note/@Message)>0">
            <xsl:apply-templates select="Note" />
        </xsl:if>
        <xsl:if test="string-length(@Volume)>0">
            <xsl:text>VL  - </xsl:text>
            <xsl:value-of select="@Volume" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:if test="string-length(@Issue)>0">
            <xsl:text>IS  - </xsl:text>
            <xsl:value-of select="@Issue" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:if test="string-length(@PageFirst)>0">
            <xsl:text>SP  - </xsl:text>
            <xsl:value-of select="@PageFirst" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:if test="string-length(@PageLast)>0">
            <xsl:text>EP  - </xsl:text>
            <xsl:value-of select="@PageLast" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
		<!-- <xsl:if test="string-length(@PageNumber) > 0  and string-length(normalize-space(@PageFirst)) = 0">
		    <xsl:text>SP  - </xsl:text>
            <xsl:value-of select="@PageNumber" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if> -->
        <xsl:if test="string-length(@PublisherName)>0">
            <xsl:text>PB  - </xsl:text>
            <xsl:value-of select="@PublisherName" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:if test="string-length(@PublisherPlace)>0">
            <xsl:text>CY  - </xsl:text>
            <xsl:value-of select="@PublisherPlace" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:if test="string-length(@Edition)>0">
            <xsl:text>ET  - </xsl:text>
            <xsl:value-of select="@Edition" />
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:text>ER  - </xsl:text>
		<!-- Zeilenvorschub nach ER - Boris 19.10.15 -->
		<xsl:text>&#10;</xsl:text>
    </xsl:template>

    <!-- here begins the special templates for the fields -->
    <!-- Templates for "external fields". -->
    <xsl:template match="Enrichment[@KeyName='VolumeSource']">
        <xsl:text>VL  - </xsl:text>
        <xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
	
	<xsl:template match="IdentifierUrl">
        <xsl:text>UR  - </xsl:text>
        <xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
	
	<xsl:template match="IdentifierDoi">
        <xsl:text>U6  - http://dx.doi.org/</xsl:text>
        <xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="IdentifierUrn">
        <xsl:text>U6  - http://nbn-resolving.de/urn/resolver.pl?</xsl:text>
        <xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="IdentifierIsbn">
        <xsl:text>SN  - </xsl:text>
        <xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="IdentifierIssn">
        <xsl:text>SN  - </xsl:text>
        <xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    

    <xsl:template match="Note[@Visibility='public']">
        <xsl:text>N1  - </xsl:text><xsl:value-of select="@Message" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="Subject[@Type='uncontrolled' or @Type='swd']">
        <xsl:text>KW  - </xsl:text><xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="PersonAuthor">
        <xsl:text>A1  - </xsl:text><xsl:value-of select="concat(@LastName, ', ', @FirstName)" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="PersonEditor">
        <xsl:text>ED  - </xsl:text><xsl:value-of select="concat(@LastName, ', ', @FirstName)" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="TitleMain">
        <xsl:text>T1  - </xsl:text><xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="TitleSub">
        <xsl:text>BT  - </xsl:text><xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="TitleAbstract">
        <xsl:text>N2  - </xsl:text><xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <!--xsl:template match="TitleParent">
        <xsl:text>T2  - </xsl:text><xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template-->
	
	 <xsl:template match="TitleParent">
	   <xsl:choose>
	     <xsl:when test="../@Type='book'">
		 <xsl:text>T3  - </xsl:text><xsl:value-of select="@Value" />
         <xsl:text>&#10;</xsl:text>
		 </xsl:when>
		   <xsl:when test="../@Type='article' or ../@Type='review' or ../@Type='contributiontoperiodical'">
		 <xsl:text>JF  - </xsl:text><xsl:value-of select="@Value" />
         <xsl:text>&#10;</xsl:text>
		 </xsl:when>
		 <xsl:otherwise>
        <xsl:text>T2  - </xsl:text><xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
		 </xsl:otherwise>
		 </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TitleAdditional">
        <xsl:text>T2  - </xsl:text><xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="Edition">
        <xsl:text>ET  - </xsl:text>
        <xsl:value-of select="@Value" />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="Series[@Visible='1']">
        <xsl:text>T3  - </xsl:text>
        <xsl:value-of select="@Title" />
        <xsl:if test="@Number != ''">
            <xsl:text> - </xsl:text>
            <xsl:value-of select="@Number" />
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
