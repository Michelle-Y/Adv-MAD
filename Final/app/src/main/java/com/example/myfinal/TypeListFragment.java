package com.example.myfinal;

import android.content.Context;
import android.os.Bundle;
//import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.app.Fragment;


/**
 * A simple {@link Fragment} subclass.
 */
public class TypeListFragment extends Fragment implements AdapterView.OnItemClickListener {


    public TypeListFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        if (view != null){
            ListView listUniverse = (ListView) view.findViewById(R.id.listView);
            ArrayAdapter<Activity> listAdapter = new ArrayAdapter<Activity>(getActivity(), android.R.layout.simple_list_item_1, Activity.activities);
            listUniverse.setAdapter(listAdapter);
            listUniverse.setOnItemClickListener(this);
        }
    }

    //create interface
    interface UniverseListListener{
        void itemClicked(long id);
    }

    //create listener
    private UniverseListListener listener;

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (UniverseListListener) context;
    }

    @Override public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null){
            //tells the listener an item was clicked
            listener.itemClicked(id);
        }
    }


}
