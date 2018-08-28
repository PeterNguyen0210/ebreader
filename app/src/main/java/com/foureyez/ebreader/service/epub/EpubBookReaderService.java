package com.foureyez.ebreader.service.epub;

import android.os.Environment;
import android.util.Log;

import com.foureyez.ebreader.modal.Book;
import com.foureyez.ebreader.parser.epub.ContainerFileParser;
import com.foureyez.ebreader.parser.epub.OpfFileParser;
import com.foureyez.ebreader.service.ReaderService;
import com.foureyez.ebreader.utils.FileUtils;

import org.xml.sax.SAXException;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.file.Path;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

public class EpubBookReaderService implements ReaderService {

    private static final String TAG = "EpubBookReaderService";
    private static final String CONTAINER_LOCATION = "META-INF/container.xml";

    @Override
    public Book scanBook(String path) {

        if (FileUtils.isExternalStorageReadable()) {
            File sdcard = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
            Log.i(TAG, "External Storage available");

            File file = new File(sdcard, "Book.epub");

            try {

                ZipFile zipBook = new ZipFile(file);

                // Getting container.xml file and converting into InputStreamReader
                ContainerFileParser containerFileParser = new ContainerFileParser();
                ZipEntry containerEntry = zipBook.getEntry(CONTAINER_LOCATION);
                InputStream containerStream = zipBook.getInputStream(containerEntry);

                containerFileParser.parse(containerStream);
                String opfFilePath = containerFileParser.getOpfFilePath();

                Log.i(TAG, "OPF File Path retreived : " + opfFilePath);

                // Getting *.opf file and converting into InputStreamReader
                OpfFileParser opfFileParser = new OpfFileParser();
                ZipEntry opfFileEntry = zipBook.getEntry(opfFilePath);
                InputStream opfStream = zipBook.getInputStream(opfFileEntry);

                opfFileParser.parse(opfStream);
                Book book = opfFileParser.getBook();
                book.setBookPath(sdcard + File.separator + "Book.epub");
                Log.i(TAG, "OPF File  : " + book);

                return book;

            } catch (Exception e) {
                Log.e(TAG, "Exception Occured", e);
            }

        } else {

        }

        return null;
    }

    @Override
    public String getNextChapter(Book book) {
        File file = new File(book.getBookPath());
        StringBuilder str = new StringBuilder();
        try {
            ZipFile zipBook = new ZipFile(file);
            String chapterPath = "OEBPS" + File.separator + book.getNextChapterPath();
            Log.d(TAG, chapterPath);
            ZipEntry chapterEntry = zipBook.getEntry(chapterPath);
            InputStream chapterStream = zipBook.getInputStream(chapterEntry);

            int data = chapterStream.read();
            char c;
            while (data != -1) {
                c = (char) data;
                str.append(c);

                data = chapterStream.read();
            }
            chapterStream.close();

        } catch (Exception ex) {
            Log.e(TAG, "Exception Occured", ex);
        }

        return str.toString();
    }
}
