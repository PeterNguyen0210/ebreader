package com.foureyez.ebreader.parser.epub;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class ContainerFileParser extends DefaultHandler {
    private String opfFilePath = "";

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        if (qName.equalsIgnoreCase("rootfile")) {
            opfFilePath = attributes.getValue("full-path");

        }
    }

    public String getOpfFilePath() {
        return opfFilePath;
    }

    public void setOpfFilePath(String opfFilePath) {
        this.opfFilePath = opfFilePath;
    }
}