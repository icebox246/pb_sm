package rogowskia.sensorapp;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

public class SensorActivity extends AppCompatActivity {

    private class SensorHolder extends RecyclerView.ViewHolder implements View.OnClickListener, View.OnLongClickListener {
        private Sensor sensor;
        private final ImageView sensorImage;
        private final TextView sensorText;

        public SensorHolder(LayoutInflater inflater, ViewGroup parent) {
            super(inflater.inflate(R.layout.sensor_item_list, parent, false));
            itemView.setOnClickListener(this);
            itemView.setOnLongClickListener(this);

            sensorImage = itemView.findViewById(R.id.image);
            sensorText = itemView.findViewById(R.id.text);
        }

        public void bind(Sensor sensor) {
            this.sensor = sensor;

            sensorText.setText(sensor.getName());
//            sensorImage.setImageDrawable(getResources().getDrawable(R.drawable.baseline_sensors_24, getTheme()));
        }

        @Override
        public void onClick(View v) {
            int sensorType = sensor.getType();
            if (sensorType == Sensor.TYPE_MAGNETIC_FIELD) {
                Log.d("FOOBAR", "onClick: hello");
                Intent intent = new Intent(SensorActivity.this, LocationActivity.class);
                startActivity(intent);
            } else {
                Log.d("FOOBAR", "onClick: hello");
                Intent intent = new Intent(SensorActivity.this, SensorDetailsActivity.class);
                intent.putExtra("sensor_name", sensor.getName());
                startActivity(intent);
            }
        }

        @Override
        public boolean onLongClick(View v) {
            Log.d("FOOBAR", "onLongClick: hello");
            AlertDialog.Builder b = new AlertDialog.Builder(SensorActivity.this);
            b.setTitle(R.string.vendor_info);
            b.setMessage(sensor.getVendor());
            b.show();
            return true;
        }
    }
    private class SensorAdapter extends RecyclerView.Adapter<SensorHolder> {
        private final List<Sensor> sensors;

        public SensorAdapter(List<Sensor> sensors) {
            this.sensors = sensors;
        }

        @NonNull
        @Override
        public SensorHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            LayoutInflater layoutInflater = LayoutInflater.from(SensorActivity.this);
            return new SensorHolder(layoutInflater, parent);
        }

        @Override
        public void onBindViewHolder(@NonNull SensorHolder holder, int position) {
            Sensor sensor = sensors.get(position);
            holder.bind(sensor);
        }

        @Override
        public int getItemCount() {
            return sensors.size();
        }
    }
    private SensorManager sensorManager;
    private List<Sensor> sensorList;

    private RecyclerView recyclerView;
    private SensorAdapter adapter;

    @SuppressLint("NotifyDataSetChanged")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.sensor_activity);

        recyclerView = findViewById(R.id.sensor_recycler_view);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        sensorList = sensorManager.getSensorList(Sensor.TYPE_ALL);

        if(adapter == null) {
            adapter = new SensorAdapter(sensorList);
            recyclerView.setAdapter(adapter);
        } else {
            adapter.notifyDataSetChanged();
        }
    }
}