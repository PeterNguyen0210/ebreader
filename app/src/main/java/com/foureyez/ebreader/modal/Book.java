package com.foureyez.ebreader.modal;

import java.io.File;
import java.util.List;
import java.util.Map;


public class Book {

    private String bookPath;
    private Metadata metaData;
    private List<Item> manifest;
    private List<Item> spine;
    private int index = 0;

    public Metadata getMetaData() {
        return metaData;
    }


    public void setMetaData(Metadata metaData) {
        this.metaData = metaData;
    }

    public List<Item> getManifest() {
        return manifest;
    }

    public void setManifest(List<Item> manifest) {
        this.manifest = manifest;
    }


    public String getBookPath() {
        return bookPath;
    }

    public void setBookPath(String bookPath) {
        this.bookPath = bookPath;
    }

    public List<Item> getSpine() {
        return spine;
    }

    public void setSpine(List<Item> spine) {
        this.spine = spine;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public String getNextChapterPath() {
        String path = spine.get(index).getHref();
        index++;
        return path;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bookPath='" + bookPath + '\'' +
                ", metaData=" + metaData +
                ", manifest=" + manifest +
                ", spine=" + spine +
                '}';
    }
}
