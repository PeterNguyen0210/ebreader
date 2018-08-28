package com.foureyez.ebreader.service;

import com.foureyez.ebreader.modal.Book;

public interface ReaderService {
    public Book scanBook(String path);
    public String getNextChapter(Book book);
}
