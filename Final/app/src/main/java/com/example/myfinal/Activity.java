package com.example.myfinal;

import java.util.ArrayList;
import java.util.Arrays;

public class Activity {
    private String type;
    private ArrayList<ActivityWithURL> activityList = new ArrayList<>();

    //constructor
    private Activity(String _type, ArrayList<ActivityWithURL> _activity){
        this.type = _type;
        this.activityList = new ArrayList<ActivityWithURL>(_activity);
    }

    public static final Activity[] activities = {
            new Activity("Boulder", new ArrayList<ActivityWithURL>(Arrays.asList(new ActivityWithURL("Buffs", "google.com"), new ActivityWithURL("Terra Thai", "google.com"),new ActivityWithURL("C4C", "google.com")))),
            new Activity("Denver", new ArrayList<ActivityWithURL>(Arrays.asList(new ActivityWithURL("Golden Shanghai", "google.com"), new ActivityWithURL("Piatti Denver", "google.com"), new ActivityWithURL("Sakura House", "google.com")))),
            new Activity("Longmont", new ArrayList<ActivityWithURL>(Arrays.asList(new ActivityWithURL("Domino", "google.com"), new ActivityWithURL("The Twisted Noodle", "google.com"), new ActivityWithURL("The Roost", "google.com"))))
    };

    public String getType(){
        return type;
    }

    public ArrayList<ActivityWithURL> getActivityList(){
        return activityList;
    }

    public String toString(){
        return this.type;
    }
}
