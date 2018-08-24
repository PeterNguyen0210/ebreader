package com.foureyez.ebreader.activity;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.foureyez.ebreader.R;
import com.foureyez.ebreader.service.ScanBookService;
import com.foureyez.ebreader.service.ScanEpubBookService;

import java.nio.file.Path;

public class ScanBooksActivity extends AppCompatActivity {

    private ScanBookService scanBookService;
    private Button scanButton;
    private EditText filePath;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scan_books);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        scanBookService = new ScanEpubBookService();
        scanButton = (Button) findViewById(R.id.scanButton);
        filePath = (EditText) findViewById(R.id.filePath);
        scanButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String path = filePath.getText().toString();
                scanBookService.doScan(path);
            }
        });
    }

}
