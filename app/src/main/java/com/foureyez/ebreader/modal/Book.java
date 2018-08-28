package com.foureyez.ebreader.modal;

import java.util.List;


public class Book {


    private Metadata metaData;
    private List<Item> manifest;

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

    @Override
    public String toString() {
        return "Book{" +
                "metaData=" + metaData +
                ", manifest=" + manifest +
                '}';
    }
}
