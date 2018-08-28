package com.foureyez.ebreader.activity;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.EditText;

import com.foureyez.ebreader.R;
import com.foureyez.ebreader.modal.Book;
import com.foureyez.ebreader.service.ReaderService;
import com.foureyez.ebreader.service.epub.EpubBookReaderService;

public class ReaderActivity extends AppCompatActivity {

    private ReaderService bookReaderService;
    private Button scanButton;
    private EditText filePath;
    private WebView ebookView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scan_books);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        bookReaderService = new EpubBookReaderService();

        scanButton = (Button) findViewById(R.id.scanButton);
        filePath = (EditText) findViewById(R.id.filePath);
        ebookView = (WebView) findViewById(R.id.ebookView);

        scanButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String path = filePath.getText().toString();
                String unencodedHtml = "<html><body>% is the percent code for $</body></html>";

                Book book = bookReaderService.scanBook(path);
                String chapter = bookReaderService.getNextChapter(book);
                String encodedHtml = Base64.encodeToString(chapter.getBytes(), Base64.NO_PADDING);
                Log.d("READER", chapter);
                ebookView.loadData(encodedHtml, "text/html", "base64");
            }
        });


    }

}
