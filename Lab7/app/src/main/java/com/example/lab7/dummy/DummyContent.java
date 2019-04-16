package com.example.lab7.dummy;

import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Helper class for providing sample content for user interfaces created by
 * Android template wizards.
 * <p>
 * TODO: Replace all uses of this class before publishing your app.
 */
public class DummyContent {

    /**
     * An array of sample (dummy) items.
     */
    public static final List<DummyItem> ITEMS = new ArrayList<DummyItem>();

    /**
     * A map of sample (dummy) items, by ID.
     */
    public static final Map<String, DummyItem> ITEM_MAP = new HashMap<String, DummyItem>();

    private static final int COUNT = 25;
    public void dataSetup(){
    List<DummyContent.DummyItem> xmlData=new ArrayList<DummyContent.DummyItem>();
    Activity xmlDataActivity = new Activity();
    if (ITEMS.size() == 0) {
        try {
            xmlData = xmlDataActivity.loadXML();
            for (int i = 0; i < xmlData.size(); i++) {
                addItem(xmlData.get(i));
            }
        } catch (XmlPullParserException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
        static {
            addItem(new DummyItem("1", "eBookFrenzy",
                    "https://www.ebookfrenzy.com"));
            addItem(new DummyItem("2", "Amazon",
                    "https://www.amazon.com"));
            addItem(new DummyItem("3", "New York Times",
                    "https://www.nytimes.com"));
        }
    static {
        // Add some sample items.
        for (int i = 1; i <= COUNT; i++) {
            addItem(createDummyItem(i));
        }
    }

    private static void addItem(DummyItem item) {
        ITEMS.add(item);
        ITEM_MAP.put(item.id, item);
    }

    private static DummyItem createDummyItem(int position) {
        return new DummyItem(String.valueOf(position), "Item " + position, makeDetails(position));
    }

    private static String makeDetails(int position) {
        StringBuilder builder = new StringBuilder();
        builder.append("Details about Item: ").append(position);
        for (int i = 0; i < position; i++) {
            builder.append("\nMore details information here.");
        }
        return builder.toString();
    }

    /**
     * A dummy item representing a piece of content.
     */
    public static class DummyItem {
        public final String id;
        public final String name;
        public final String url;

        public DummyItem(String id, String content, String details) {
            this.id = id;
            this.name = content;
            this.url = details;
        }

        @Override
        public String toString() {
            return name;
        }
    }
}
