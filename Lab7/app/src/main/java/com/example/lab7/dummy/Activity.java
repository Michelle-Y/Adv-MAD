package com.example.lab7.dummy;

import android.content.res.XmlResourceParser;

import com.example.lab7.MyApplication;
import com.example.lab7.R;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Activity {
    public List<DummyContent.DummyItem> loadXML() throws XmlPullParserException, IOException {
        String new_teaname = new String();
        String new_url = new String();
        int id_counter = 0;
        List<DummyContent.DummyItem> teas=new ArrayList<DummyContent.DummyItem>();
        //string for debugging purposes only
        StringBuffer stringBuffer = new StringBuffer();

        //get xml file
        XmlResourceParser xpp = MyApplication.getAppContext().getResources().getXml(R.xml.dataxml);

        //advances the parser to the next event
        xpp.next();
        //gets the event type/state of the parser
        int eventType = xpp.getEventType();
        while (eventType != XmlPullParser.END_DOCUMENT) {
            switch (eventType) {
                case XmlPullParser.START_DOCUMENT:
                    // start of document
                    break;
                case XmlPullParser.START_TAG:
                    if (xpp.getName().equals("tea")) {
                        stringBuffer.append("\nSTART_TAG: " + xpp.getName());
                    }
                    if (xpp.getName().equals("name")) {
                        stringBuffer.append("\nSTART_TAG: " + xpp.getName());
                        eventType = xpp.next();
                        new_teaname = xpp.getText(); //gets the name of the hero
                    }
                    else if (xpp.getName().equals("url")) {
                        stringBuffer.append("\nSTART_TAG: " + xpp.getName());
                        eventType = xpp.next();
                        new_url = xpp.getText(); //gets the url of the hero
                    }
                    break;
                case XmlPullParser.END_TAG:
                    if (xpp.getName().equals("tea")) {
                        id_counter++;
                        //create new item object
                        DummyContent.DummyItem new_item = new DummyContent.DummyItem(String.valueOf(id_counter), new_teaname, new_url);
                        teas.add(new_item);
                    }
                    break;

                case XmlPullParser.TEXT:
                    break;
            }
            eventType = xpp.next();
        }
        return teas;
    }
}
