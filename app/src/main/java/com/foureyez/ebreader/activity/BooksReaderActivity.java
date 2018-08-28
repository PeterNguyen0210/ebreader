package com.foureyez.ebreader.activity;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.foureyez.ebreader.R;
import com.foureyez.ebreader.service.BookReaderService;
import com.foureyez.ebreader.service.epub.EpubBookReaderService;

public class BooksReaderActivity extends AppCompatActivity {

    private BookReaderService bookReaderService;
    private Button scanButton;
    private EditText filePath;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scan_books);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        bookReaderService = new EpubBookReaderService();
        scanButton = (Button) findViewById(R.id.scanButton);
        filePath = (EditText) findViewById(R.id.filePath);
        scanButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String path = filePath.getText().toString();
                bookReaderService.doRead(path);
            }
        });
    }

}
