package com.example.myfinal;


import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
//import android.support.v4.app.Fragment;
import android.support.design.widget.FloatingActionButton;
import android.util.Log;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.app.Fragment;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;


/**
 * A simple {@link Fragment} subclass.
 */
public class ActivityDetailFragment extends Fragment implements  View.OnClickListener {


    public static final String MY_PREFS_NAME = "persis_prefs_1";
    private ArrayAdapter<String> adapter;
    private long universeId;

    public ActivityDetailFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        if (savedInstanceState !=null){
            universeId = savedInstanceState.getLong("universeId");
        }
        return inflater.inflate(R.layout.fragment_detail, container, false);
    }

    @Override public void onStart(){
        super.onStart();

        View view = getView();
        ListView listHeroes = (ListView) view.findViewById(R.id.herolistView);
        List<ActivityWithURL> herolist = new ArrayList<ActivityWithURL>();
        herolist = retrievePrefs(Activity.activities[(int) universeId].getType());
        //herolist = Activity.activities[(int) universeId].getActivityList();
        if (herolist == null) {
            herolist = Activity.activities[(int) universeId].getActivityList();
        }
        List<String> heroListNamesOnly = new ArrayList<>();
        for (ActivityWithURL a : herolist) {
            heroListNamesOnly.add(a.getActivityName());
        }
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, heroListNamesOnly);
        listHeroes.setAdapter(adapter);

        listHeroes.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
                                    long arg3) {

                String name = Activity.activities[(int) universeId].getActivityList().get((int) arg3).getActivityName();
                Uri uri = Uri.parse("http://www.google.com/search?client=safari&rls=en&q=" + name.toString());
                Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                startActivity(intent);
            }

        });

        FloatingActionButton fab = (FloatingActionButton) view.findViewById(R.id.addHeroButton);
        fab.setOnClickListener(this);
        registerForContextMenu(listHeroes);

    }

    public void setUniverse(long id){
        this.universeId = id;
    }

    @Override public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("universeId", universeId);
    }

    //create interface
    interface ButtonClickListener{
        void addheroclicked(View view);
    }

    //create listener
    private ButtonClickListener listener;

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (ButtonClickListener)context;
    }

    @Override public void onClick(View view){
        if (listener !=null){
            listener.addheroclicked(view);
        }
    }

    public void addhero(){
        AlertDialog.Builder dialog = new AlertDialog.Builder(getActivity());
        final EditText edittext = new EditText(getActivity());
        dialog.setView(edittext);
        dialog.setTitle("Add Activity");
        dialog.setPositiveButton("Add", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                String heroName = edittext.getText().toString();
                if(!heroName.isEmpty()){
                    Activity.activities[(int) universeId].getActivityList().add(new ActivityWithURL(heroName, "google.com"));
                    setPrefs(Activity.activities[(int) universeId].getType(), Activity.activities[(int) universeId].getActivityList());
                }
                ActivityDetailFragment.this.adapter.notifyDataSetChanged();
            }
        });

        dialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
            }
        });
        dialog.show();
    }

    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String heroname = adapter.getItem(adapterContextMenuInfo.position);
        menu.setHeaderTitle("Delete " + heroname);
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        int itemId = item.getItemId();
        if (itemId == 1) {
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            Log.i("Mich", Activity.activities[(int) universeId].getActivityList().toString());
            Activity.activities[(int) universeId].getActivityList().remove(info.position);
            setPrefs(Activity.activities[(int) universeId].getType(), Activity.activities[(int) universeId].getActivityList());
            ActivityDetailFragment.this.adapter.notifyDataSetChanged();
        }
        return true;
    }


    List<ActivityWithURL> retrievePrefs(String type) {

        SharedPreferences prefs = getActivity().getSharedPreferences(MY_PREFS_NAME, getActivity().MODE_PRIVATE);

        String restoredText = prefs.getString(type, null);

        Type gsonType = new TypeToken< List < ActivityWithURL >>() {}.getType();
        List < ActivityWithURL > actitiesWithURLs = new Gson().fromJson(restoredText, gsonType);


        return actitiesWithURLs;
    }

    void setPrefs(String type, ArrayList<ActivityWithURL> activities) {

        String JSONstring = new Gson().toJson(activities);

        SharedPreferences.Editor editor = getActivity().getSharedPreferences(MY_PREFS_NAME, getActivity().MODE_PRIVATE).edit();
        editor.putString(type, JSONstring);
        editor.apply();
    }

}
