package com.foureyez.ebreader.parser.epub;

import com.foureyez.ebreader.modal.Book;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class OpfFileParser extends DefaultHandler {
    private Book book;

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        if (qName.equalsIgnoreCase("rootfile")) {

        }
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (qName.equalsIgnoreCase("Employee")) {

        }
    }

    @Override
    public void characters(char ch[], int start, int length) throws SAXException {


    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}
