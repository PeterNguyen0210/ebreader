package com.foureyez.ebreader.service.epub;

import android.os.Environment;
import android.util.Log;

import com.foureyez.ebreader.modal.Book;
import com.foureyez.ebreader.parser.epub.ContainerFileParser;
import com.foureyez.ebreader.parser.epub.OpfFileParser;
import com.foureyez.ebreader.service.BookReaderService;
import com.foureyez.ebreader.utils.FileUtils;

import org.xml.sax.SAXException;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

public class EpubBookReaderService implements BookReaderService {

    private static final String TAG = "EpubBookReaderService";
    private static final String CONTAINER_LOCATION = "META-INF/container.xml";

    @Override
    public Book doRead(String path) {

        if (FileUtils.isExternalStorageReadable()) {
            File sdcard = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
            Log.i(TAG, "External Storage available");

            File file = new File(sdcard, "Book.epub");

            try {

                ZipFile zipBook = new ZipFile(file);
                String opfFilePath = getOpfFilePath(zipBook);

                Log.i(TAG, "OPF File Path retreived : " + opfFilePath);

                Book book = parseOpfFile(zipBook, opfFilePath);

                Log.i(TAG, "OPF File  : " + book);



            } catch (Exception e) {
                Log.e(TAG, "Exception Occured", e);
            }

        } else {

        }

        return null;
    }

    // Reads the container.xml and returns the location of opf file
    private String getOpfFilePath(ZipFile zipBook) throws SAXException, ParserConfigurationException {

        // Open container file and get the xml
        ZipEntry containerEntry = zipBook.getEntry(CONTAINER_LOCATION);
        ContainerFileParser containerFileParser = new ContainerFileParser();

        try (InputStream inputStream = zipBook.getInputStream(containerEntry)) {

            // Parse the XML to get the OPF file location
            SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
            SAXParser saxParser = saxParserFactory.newSAXParser();
            saxParser.parse(inputStream, containerFileParser);

        } catch (IOException e) {
            Log.e(TAG, "Container file could not be opened : Missing Container File", e);
        }

        return containerFileParser.getOpfFilePath();
    }

    // Reads and Parses the OPF File from the provided location
    private Book parseOpfFile(ZipFile zipBook, String opfFilePath) throws ParserConfigurationException, SAXException {

        Book book = new Book();
        ZipEntry opfFileEntry = zipBook.getEntry(opfFilePath);
        OpfFileParser opfFileParser = new OpfFileParser();

        try (InputStream inputStream = zipBook.getInputStream(opfFileEntry)) {

            // Parse the OPF File to get the book details
            SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
            SAXParser saxParser = saxParserFactory.newSAXParser();
            saxParser.parse(inputStream, opfFileParser);

        } catch (IOException e) {
            Log.e(TAG, "OPF file could not be opened : Missing OPF File", e);
        }

        return opfFileParser.getBook();
    }
}
