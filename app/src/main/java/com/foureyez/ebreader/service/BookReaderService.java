package com.foureyez.ebreader.service;

import com.foureyez.ebreader.modal.Book;

public interface BookReaderService {
    public Book doRead(String path);
}
