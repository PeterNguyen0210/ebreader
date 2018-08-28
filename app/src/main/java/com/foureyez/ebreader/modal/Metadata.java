package com.foureyez.ebreader.modal;

import java.time.LocalDate;
import java.util.Date;


public class Metadata {

    private String title;
    private String creator;
    private String publisher;
    private String contributor;
    private String date;
    private String type;
    private String format;
    private String identifier;
    private String source;
    private String language;
    private String rights;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getContributor() {
        return contributor;
    }

    public void setContributor(String contributor) {
        this.contributor = contributor;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getRights() {
        return rights;
    }

    public void setRights(String rights) {
        this.rights = rights;
    }

    @Override
    public String toString() {
        return "Metadata{" +
                "title='" + title + '\'' +
                ", creator='" + creator + '\'' +
                ", publisher='" + publisher + '\'' +
                ", contributor='" + contributor + '\'' +
                ", date=" + date +
                ", type='" + type + '\'' +
                ", format='" + format + '\'' +
                ", identifier='" + identifier + '\'' +
                ", source='" + source + '\'' +
                ", language='" + language + '\'' +
                ", rights='" + rights + '\'' +
                '}';
    }
}
