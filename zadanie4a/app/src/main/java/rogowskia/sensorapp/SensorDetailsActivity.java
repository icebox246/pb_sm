package rogowskia.sensorapp;

import android.annotation.SuppressLint;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class SensorDetailsActivity extends AppCompatActivity implements SensorEventListener {
    private SensorManager sensorManager;
    private Sensor sensor;
    private TextView sensorTextView;
    private TextView accChgCntTextView;
    int accChgCnt = 0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sensor_details);

        String sensorName = getIntent().getStringExtra("sensor_name");

        sensorTextView = findViewById(R.id.sensor_label);
        accChgCntTextView = findViewById(R.id.accuracy_change_count);
        TextView sensorNameView = findViewById(R.id.sensor_name);
        sensorNameView.setText(sensorName);

        sensorManager = (SensorManager)getSystemService(Context.SENSOR_SERVICE);
        sensor = sensorManager.getSensorList(Sensor.TYPE_ALL)
                .stream()
                .filter(s -> s.getName().equals(sensorName))
                .findFirst()
                .orElse(null);

        if(sensor == null) {
            sensorTextView.setText(R.string.missing_sensor);
        }
    }

    @Override
    protected void onStart() {
        super.onStart();

        if (sensor != null) {
            sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_NORMAL);
        }
    }

    @SuppressLint("DefaultLocale")
    @Override
    public void onSensorChanged(SensorEvent event) {
        StringBuilder sb = new StringBuilder();
        sb.append(getResources().getString(R.string.sensor_value_label));
        sb.append("\n");

        boolean first = true;
        for (float v : event.values) {
            if(!first)
                sb.append(", ");
            else
                first = false;
            sb.append(String.format("%6.3f", v));
        }

        sensorTextView.setText(sb.toString());
    }

    @SuppressLint("SetTextI18n")
    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
        accChgCnt++;
        accChgCntTextView.setText(Integer.toString(accChgCnt));
    }
}