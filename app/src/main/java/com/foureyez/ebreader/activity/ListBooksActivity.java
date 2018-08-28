package com.foureyez.ebreader.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;

import com.foureyez.ebreader.R;

public class ListBooksActivity extends AppCompatActivity {

    private Button scanBook;

    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_books);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        scanBook = (Button) findViewById(R.id.scanBookBtn);

        scanBook.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent();
                intent.setClass(view.getContext(), BooksReaderActivity.class);
                startActivity(intent);
            }
        });

    }


}
