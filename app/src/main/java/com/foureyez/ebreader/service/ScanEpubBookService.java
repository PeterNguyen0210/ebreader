package com.foureyez.ebreader.service;

import android.os.Environment;

import com.foureyez.ebreader.modal.Book;
import com.foureyez.ebreader.utils.FileUtilitiy;

import java.io.File;

public class ScanEpubBookService implements ScanBookService {

    @Override
    public Book doScan(String path) {

        if(FileUtilitiy.isExternalStorageReadable()){
            File sdcard = Environment.getExternalStorageDirectory();

        }else {

        }
        //ZipFile zipFile = new ZipFile(sdcard, "");
        return null;
    }
}
