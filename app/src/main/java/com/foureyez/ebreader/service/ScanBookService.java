package com.foureyez.ebreader.service;

import com.foureyez.ebreader.modal.Book;

public interface ScanBookService {
    public Book doScan(String path);
}
