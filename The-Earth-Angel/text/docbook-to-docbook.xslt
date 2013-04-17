<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns="http://docbook.org/ns/docbook"
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    >

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"
    />
    <!--Identity template,
        provides default behavior that copies all content into the output -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//d:article/d:info">
        <info>
            <xsl:apply-templates />
            <authorgroup>
                <author>
                    <personname>
                        <firstname>Shlomi</firstname>
                        <surname>Fish</surname>
                    </personname>
                    <affiliation>
                        <address>
                            <email>shlomif@shlomifish.org</email>
                            <uri type="homepage" xlink:href="http://www.shlomifish.org/">Shlomi Fish’s Homepage</uri>
                        </address>
                    </affiliation>
                </author>
            </authorgroup>
            <copyright>
                <year>2004</year>
                <holder>Shlomi Fish</holder>
            </copyright>
            <legalnotice>
                <para>
                    This document is copyrighted by Shlomi Fish
                    under the
                    <link xlink:href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative
                        Commons Attribution
                        Noncommercial Share-Alike (Unported) License (CC-by-nc-sa) version
                        3.0</link>
                    (or at your option, any greater version).
                </para>
                <para>
                    Note that the original text of the story and its DocBook source is
                    under "CC-by-sa", but the author relicensed the final EPUB to
                    "CC-by-nc-sa" upon publishing.
                </para>
            </legalnotice>
            <abstract>
                <para>
                    A hectic week in the life of an American female graphic artist
                    called Rachel Southern. A typical Hollywood story with some
                    uncommon elements.
                </para>
            </abstract>
        </info>
    </xsl:template>

    <xsl:template match="//d:article">
        <article>
            <xsl:attribute name="version">
                <xsl:value-of select="version" />
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id" />
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="'en-GB'" />
            </xsl:attribute>
            <xsl:apply-templates />
        </article>
    </xsl:template>

</xsl:stylesheet>
