package com.foureyez.ebreader.utils;

import java.io.IOException;
import java.io.InputStream;

public class StringUtils {

    public static String convertInputStreamToString(InputStream in) throws IOException {
        StringBuilder sb = new StringBuilder();
        int i;

        while ((i = in.read()) != -1) {
            sb.append((char) i);
        }
        return sb.toString();
    }
}
