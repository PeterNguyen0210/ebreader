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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OpfFileParser {
    private Book book;
    private Metadata metadata;
    private List<Item> manifest;
    private List<Item> spine;


    public void parse(InputStream stream) throws XmlPullParserException, IOException {
        XmlPullParser parser = Xml.newPullParser();
        parser.setFeature(XmlPullParser.FEATURE_PROCESS_NAMESPACES, false);
        parser.setInput(stream, null);
        int eventType = parser.getEventType();

        while (eventType != XmlPullParser.END_DOCUMENT) {
            switch (eventType) {
                case XmlPullParser.START_DOCUMENT:
                    book = new Book();
                    break;
                case XmlPullParser.START_TAG:
                    String name = parser.getName();
                    switch (name) {

                        // Reading Metadata
                        case "metadata":
                            metadata = new Metadata();
                            break;
                        case "dc:identifier":
                            metadata.setIdentifier(parser.nextText());
                            break;
                        case "dc:contributor":
                            metadata.setContributor(parser.nextText());
                            break;
                        case "dc:date":
                            metadata.setDate(parser.nextText());
                            break;
                        case "dc:creator":
                            metadata.setCreator(parser.nextText());
                            break;
                        case "dc:language":
                            metadata.setLanguage(parser.nextText());
                            break;
                        case "dc:publisher":
                            metadata.setPublisher(parser.nextText());
                            break;
                        case "dc:title":
                            metadata.setTitle(parser.nextText());
                            break;

                        //  Reading Manifest
                        case "manifest":
                            manifest = new ArrayList<>();
                            break;
                        case "item":
                            Item item = new Item();

                            item.setId(parser.getAttributeValue(null, "id"));
                            item.setMediaType(parser.getAttributeValue(null, "media-type"));
                            item.setHref(parser.getAttributeValue(null, "href"));

                            manifest.add(item);
                            break;

                        //Reading Spine
                        case "spine":
                            spine = new ArrayList<>();
                            break;
                        case "itemref":
                            String id = parser.getAttributeValue(null, "idref");
                            spine.add(findItemById(id));
                            break;
                    }

                    break;
                case XmlPullParser.END_TAG:
                    name = parser.getName();
                    switch (name) {
                        case "metadata":
                            book.setMetaData(metadata);
                            break;
                        case "manifest":
                            book.setManifest(manifest);
                            break;
                        case "spine":
                            book.setSpine(spine);
                            break;
                    }
                    break;
            }
            eventType = parser.next();
        }
    }

    private Item findItemById(String id) {

        for (Item i : manifest) {
            if (id.equalsIgnoreCase(i.getId())) {
                return i;
            }
        }
        return null;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}
