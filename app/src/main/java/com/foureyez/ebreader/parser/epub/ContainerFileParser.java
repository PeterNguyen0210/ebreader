package com.foureyez.ebreader.parser.epub;

import android.util.Log;
import android.util.Xml;

import com.foureyez.ebreader.modal.Book;
import com.foureyez.ebreader.modal.Item;
import com.foureyez.ebreader.modal.Metadata;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class ContainerFileParser {
    private String opfFilePath = "";

    public void parse(InputStream stream) throws XmlPullParserException, IOException {
        XmlPullParser parser = Xml.newPullParser();
        parser.setFeature(XmlPullParser.FEATURE_PROCESS_NAMESPACES, false);
        parser.setInput(stream, null);
        int eventType = parser.getEventType();

        while (eventType != XmlPullParser.END_DOCUMENT) {
            switch (eventType) {
                case XmlPullParser.START_TAG:
                    String name = parser.getName();
                    switch (name) {
                        case "rootfile":
                            opfFilePath = parser.getAttributeValue(null, "full-path");
                            break;
                    }
                    break;
            }
            eventType = parser.next();
        }
    }

    public String getOpfFilePath() {
        return opfFilePath;
    }

    public void setOpfFilePath(String opfFilePath) {
        this.opfFilePath = opfFilePath;
    }
}