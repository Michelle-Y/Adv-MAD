package com.example.nextstep;

import android.app.Application;
import android.util.Log;

import io.realm.Realm;
import io.realm.RealmConfiguration;

public class MyApplication extends Application {

    private boolean serviceRun;

    private boolean isShowToast=false;

    public boolean isShowToast() {
        return isShowToast;
    }

    public void setShowToast(boolean showToast) {
        isShowToast = showToast;
    }

    public boolean getServiceRun() {
        return serviceRun;
    }

    public void setServiceRun(boolean serviceRun) {
        this.serviceRun = serviceRun;
    }


    @Override
    public void onCreate() {
        super.onCreate();
        serviceRun=false;
        Realm.init(this);
        RealmConfiguration realmConfig = new RealmConfiguration.Builder()
                .name("step_db")
                .build();
        Log.d("app","app create()");
        Realm.setDefaultConfiguration(realmConfig); // Make this Realm the default
    }
}

