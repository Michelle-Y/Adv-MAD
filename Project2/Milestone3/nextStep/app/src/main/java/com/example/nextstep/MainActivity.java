package com.example.nextstep;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Build;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;
import com.example.nextstep.model.StepModel;
import com.example.nextstep.step.SharedPreferencesUtils;
import com.example.nextstep.step.StepService;
import com.example.nextstep.model.StepTransaction;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import io.realm.Realm;
import lecho.lib.hellocharts.gesture.ContainerScrollType;
import lecho.lib.hellocharts.gesture.ZoomType;
import lecho.lib.hellocharts.model.Axis;
import lecho.lib.hellocharts.model.AxisValue;
import lecho.lib.hellocharts.model.Line;
import lecho.lib.hellocharts.model.LineChartData;
import lecho.lib.hellocharts.model.PointValue;
import lecho.lib.hellocharts.model.ValueShape;
import lecho.lib.hellocharts.view.LineChartView;
import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;


public class MainActivity extends AppCompatActivity implements CompoundButton.OnCheckedChangeListener {
    private TextView showSteps;
    private View mLayout;
    //    private SharedPreferencesUtils sp;
    Switch on_off;
    SharedPreferences sharedPreferences;
    long numSteps;
    boolean isServiceRun;
    TextView btn;
    TextView about;
    TextView setting;
    LineChartView lineChart;
    List<PointValue> mPointValues = new ArrayList<>();
    List<AxisValue> mAxisXValues = new ArrayList<>();


    public void mybt(View v) {
        showPopupWindow(v);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        btn = (TextView) findViewById(R.id.bt);
        Typeface Font = Typeface.createFromAsset(this.getAssets(), "iconfont.ttf");
        btn.setText(getResources().getText(R.string.setting));
        btn.setTypeface(Font);

        Log.d("eee", "on create()");
        showSteps = (TextView) findViewById(R.id.showSteps);
        mLayout = findViewById(R.id.mylayout);
        on_off = (Switch) findViewById(R.id.on_off);


        sharedPreferences = getSharedPreferences("conf", MODE_PRIVATE);

        detectService();


        Realm realm = Realm.getDefaultInstance();
        StepModel result = realm.where(StepModel.class)
                .equalTo("date", DateTimeHelper.getToday())
                .findFirst();
        numSteps = result == null ? 0 : result.getNumSteps();
        updateShowSteps();
        realm.close();

        drawChart();


    }

    public void drawChart() {

        // WeatherChartView mCharView = (WeatherChartView) findViewById(R.id.line_char);
        Date[] days = DateTimeHelper.get6days();

        Realm realm = Realm.getDefaultInstance();

        int[] data = new int[]{0, 0, 0, 0, 0, 0};
        int i = 0;
        for (Date d : days) {
            Log.d("eee","date "+d);
            if (i == 5) {
                data[i] = Integer.parseInt(String.valueOf(numSteps));
            }
            else {
                StepModel result = realm.where(StepModel.class)
                        .equalTo("date", d)
                        .findFirst();
                if (result != null) {
                    Log.d("eee","r !null  ");
                    data[i] = Integer.parseInt(String.valueOf(result.getNumSteps()));
                }
            }
            i++;
        }

        realm.close();

        String[] xValues = DateTimeHelper.get6days(true);


        lineChart = (LineChartView) findViewById(R.id.line_chart);
        for (i = 0; i < xValues.length; i++) {
            mAxisXValues.add(new AxisValue(i).setLabel(xValues[i]));
        }

        for (i = 0; i < data.length; i++) {
            mPointValues.add(new PointValue(i, data[i]));
        }
        initLineChart();

    }

    private void initLineChart() {
        Line line = new Line(mPointValues).setColor(Color.parseColor("#FFFAFA"));
        List<Line> lines = new ArrayList<>();
        line.setShape(ValueShape.CIRCLE);
        line.setCubic(false);
        line.setFilled(false);//area
        line.setHasLabels(true);//label
        line.setHasLines(true);
        line.setHasPoints(true);//dot show
        lines.add(line);
        LineChartData data = new LineChartData();
        data.setLines(lines);

        Axis axisX = new Axis();
        axisX.setHasTiltedLabels(true);
        axisX.setTextColor(Color.WHITE);
        axisX.setTextSize(10);
        axisX.setMaxLabelChars(8);
        axisX.setValues(mAxisXValues);
        data.setAxisXBottom(axisX);
        axisX.setHasLines(true);

        Axis axisY = new Axis();
        axisY.setName("");
        axisY.setTextColor(Color.parseColor("#ffffff"));
        data.setAxisYLeft(axisY);

        lineChart.setInteractive(true);
        lineChart.setZoomType(ZoomType.HORIZONTAL);
        lineChart.setMaxZoom((float) 2);
        lineChart.setContainerScrollEnabled(true, ContainerScrollType.HORIZONTAL);
        lineChart.setLineChartData(data);
        lineChart.setVisibility(View.VISIBLE);
    }


    @Subscribe(threadMode = ThreadMode.MAIN)
    public void updateSteps(Long num) {
        numSteps = num;
        updateShowSteps();
    }

    public void updateShowSteps() {
        String text = "" + numSteps;

        if (numSteps >= 100000)
            showSteps.setTextSize(55);
        else if (numSteps >= 10000) {
            notifyIsUpToStandard( "Great, you have achieve the goal");
            showSteps.setTextSize(60);
        }
        else {
            showSteps.setTextSize(66);
            if (numSteps>=5000) notifyIsUpToStandard("Almost there, you can do it!");
            else notifyIsUpToStandard("Far away from your plan. It's time to do exercise.");
        }
        showSteps.setText(text);

    }

    private void notifyIsUpToStandard(String msg)
    {
        MyApplication app = (MyApplication) getApplication();
        if(!app.isShowToast()) {
            Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
            app.setShowToast(true);
        }

    }

    private void showPopupWindow(View view) {

        MyApplication app = (MyApplication) getApplication();
        isServiceRun=app.getServiceRun();

        View contentView = LayoutInflater.from(this).inflate(
                R.layout.setting_layout, null);
        PopupWindow popupWindow = new PopupWindow(contentView,
                370, LinearLayout.LayoutParams.WRAP_CONTENT, true);
        on_off = (Switch) contentView.findViewById(R.id.on_off);
        on_off.setChecked(isServiceRun);
        on_off.setOnCheckedChangeListener(this);
        about = (TextView) contentView.findViewById(R.id.history);
        about.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showAbout();
//                showSetting();
            }
        });
        setting = (TextView) contentView.findViewById(R.id.setting);
        setting.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showSetting();
            }
        });
        popupWindow.showAsDropDown(view);

    }

    private static PackageInfo getPackageInfo(Context context) {
        PackageInfo pi = null;

        try {
            PackageManager pm = context.getPackageManager();
            pi = pm.getPackageInfo(context.getPackageName(),
                    PackageManager.GET_CONFIGURATIONS);

            return pi;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return pi;
    }

    public static String getVersionName(Context context) {
        return getPackageInfo(context).versionName;
    }
    public void showSetting() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Setting");
        builder.setPositiveButton("Yes", null);
        builder.setCancelable(true);
        View mview = LayoutInflater.from(this).inflate(R.layout.setting, null);
        builder.setView(mview);
        builder.create().show();
    }
    public void showAbout() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("History");
        builder.setPositiveButton("Yes", null);
        builder.setCancelable(true);
        View mview = LayoutInflater.from(this).inflate(R.layout.history, null);
        String s = getVersionName(this);
        builder.setView(mview);
        builder.create().show();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d("eee", "activity stop()");
    }


    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

        if (buttonView.getId() == R.id.on_off) {
            SharedPreferences.Editor editor = sharedPreferences.edit();
            editor.putBoolean("switch_on", isChecked);
            editor.apply();
            Intent intent = new Intent(this, StepService.class);

            if (isChecked) {
                intent.putExtra("isActivity", true);
//                if (!bus.isRegistered(this))
//                    bus.register(this);
//                startService(intent);
//                bus.post(true);
            }
        }

    }

    public void detectService() {
        MyApplication app = (MyApplication) getApplication();
        isServiceRun = app.getServiceRun();
        boolean temp = sharedPreferences.getBoolean("switch_on", false);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        if (isServiceRun != temp) {
            if (!isServiceRun) {
                Toast.makeText(getApplicationContext(), "App is close.",
                        Toast.LENGTH_LONG).show();
            }
            editor.putBoolean("switch_on", isServiceRun);
            editor.apply();
        }

    }

    public int getStatusBarHeight() {
        int result = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            result = getResources().getDimensionPixelSize(resourceId);
        }
        return result;
    }

    public void sdWrite() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (this.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_DENIED) {
                if (this.shouldShowRequestPermissionRationale(Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
                    Snackbar.make(mLayout, "Ask Authority",
                            Snackbar.LENGTH_INDEFINITE)
                            .setAction("OK", new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {
                                    ActivityCompat.requestPermissions(MainActivity.this,
                                            new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},
                                            0);
                                }
                            })
                            .show();
                } else {
                    this.requestPermissions(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 0);
                }


            }
        }
    }

}
