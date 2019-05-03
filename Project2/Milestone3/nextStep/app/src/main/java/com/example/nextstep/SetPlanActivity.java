package com.example.nextstep;

import android.app.TimePickerDialog;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.TimePicker;

import com.example.nextstep.step.SharedPreferencesUtils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class SetPlanActivity extends AppCompatActivity implements View.OnClickListener {

    private SharedPreferencesUtils sp;

    private LinearLayout layout_titlebar;
    private ImageView iv_right;
    private CheckBox cb_remind;
    private TextView tv_remind_time;
    private Button btn_save;
    private String remind;
    private String achieveTime;

    private void assignViews() {
        layout_titlebar = findViewById(R.id.layout_titlebar);
        iv_right = findViewById(R.id.iv_right);
        cb_remind = findViewById(R.id.cb_remind);
        tv_remind_time = findViewById(R.id.tv_remind_time);
        btn_save = findViewById(R.id.btn_save);
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.setting);
        assignViews();
        initData();
        addListener();
    }

    public void initData() {
        sp = new SharedPreferencesUtils(this);
        String remind = (String) sp.getParam("remind", "1");
        String achieveTime = (String) sp.getParam("achieveTime", "22:00");
        if (!remind.isEmpty()) {
            if ("0".equals(remind)) {
                cb_remind.setChecked(false);
            } else if ("1".equals(remind)) {
                cb_remind.setChecked(true);
            }
        }

        if (!achieveTime.isEmpty()) {
            tv_remind_time.setText(achieveTime);
        }

    }


    public void addListener() {
        iv_right.setOnClickListener(this);
        btn_save.setOnClickListener(this);
        tv_remind_time.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_save:
                save();
                break;
            case R.id.tv_remind_time:
                showTimeDialog1();
                break;
        }
    }

    private void save() {
//        remind = "";
        if (cb_remind.isChecked()) {
            remind = "1";
        } else {
            remind = "0";
        }
        achieveTime = tv_remind_time.getText().toString().trim();
        sp.setParam("remind", remind);

        if (achieveTime.isEmpty()) {
            sp.setParam("achieveTime", "21:00");
            this.achieveTime = "21:00";
        } else {
            sp.setParam("achieveTime", achieveTime);
        }
        finish();
    }


    private void showTimeDialog1() {
        final Calendar calendar = Calendar.getInstance(Locale.US);
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int minute = calendar.get(Calendar.MINUTE);
//        String time = tv_remind_time.getText().toString().trim();
        final DateFormat df = new SimpleDateFormat("HH:mm");
//        Date date = null;
//        try {
//            date = df.parse(time);
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//
//        if (null != date) {
//            calendar.setTime(date);
//        }
        new TimePickerDialog(this, new TimePickerDialog.OnTimeSetListener() {
            @Override
            public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
                calendar.set(Calendar.HOUR_OF_DAY, hourOfDay);
                calendar.set(Calendar.MINUTE, minute);
                String remaintime = calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE);
                Date date = null;
                try {
                    date = df.parse(remaintime);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                if (null != date) {
                    calendar.setTime(date);
                }
                tv_remind_time.setText(df.format(date));
            }
        }, hour, minute, true).show();
    }
}

