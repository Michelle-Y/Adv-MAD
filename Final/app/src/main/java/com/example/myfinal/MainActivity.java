package com.example.myfinal;

import android.app.FragmentTransaction;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.support.v4.app.FragmentManager;
import android.os.Bundle;
import android.view.View;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

//done the question1 a,b,c,d
//add the fab button
//long press to delete data->need to click again to show the effect
//data persistent
//loading url of web link of the restaurant -> try to make it run in app but didn't finish yet; could run outside
public class MainActivity extends android.app.Activity implements TypeListFragment.UniverseListListener, ActivityDetailFragment.ButtonClickListener {

    public static final String MY_PREFS_NAME = "persis_prefs_1";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    @Override public void itemClicked(long id){
        //create new fragment instance
        ActivityDetailFragment frag = new ActivityDetailFragment();
        frag.setUniverse(id);
        FragmentTransaction ft = getFragmentManager().beginTransaction();
        ft.replace(R.id.fragment_container, frag);
        ft.addToBackStack(null);
        ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
        ft.commit();
    }

    @Override public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount() > 0 ){
            getFragmentManager().popBackStack();
        } else {
            super.onBackPressed();
        }
    }

    @Override public void addheroclicked(View view){
        ActivityDetailFragment fragment= (ActivityDetailFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
//        ActivityDetailFragment fragment = (ActivityDetailFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addhero();
    }


    public void webOnClick(View view) {
        Uri uri = Uri.parse("http://www.google.com");
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }











    List<ActivityWithURL> retrievePrefs(String type) {
        SharedPreferences prefs = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE);

        String restoredText = prefs.getString(type, null);

        Type gsonType = new TypeToken< List < ActivityWithURL >>() {}.getType();
        List < ActivityWithURL > actitiesWithURLs = new Gson().fromJson(restoredText, gsonType);


        return actitiesWithURLs;
    }

    void setPrefs(String type, ArrayList<ActivityWithURL> activities) {

        String JSONstring = new Gson().toJson(activities);

        SharedPreferences.Editor editor = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE).edit();
        editor.putString(type, JSONstring);
        editor.apply();
    }

}
