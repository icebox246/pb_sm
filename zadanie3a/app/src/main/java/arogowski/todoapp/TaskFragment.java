package arogowski.todoapp;

import java.util.UUID;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

public class TaskFragment extends Fragment {
    private static final String ARG_TASK_ID = "arogowski.task_id";
    private Task task;

    private EditText nameField;
    private Button dateButton;
    private CheckBox checkBox;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        assert getArguments() != null;
        UUID taskId = (UUID)getArguments().getSerializable(ARG_TASK_ID);
        task = TaskStorage.getInstance().getTask(taskId);
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_task, container, false);

        nameField = view.findViewById(R.id.task_name);
        nameField.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                task.setName(s.toString());
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        dateButton = view.findViewById(R.id.task_date);
        if (task.getDate() != null) {
            dateButton.setText(task.getDate().toString());
            dateButton.setEnabled(true);
        }

        checkBox = view.findViewById(R.id.task_done);
        checkBox.setChecked(task.isDone());

        checkBox.setOnCheckedChangeListener((buttonView, isChecked) -> task.setDone(isChecked));

        return view;
    }

    public static TaskFragment newInstance(UUID taskId) {
        Bundle bundle = new Bundle();
        bundle.putSerializable(ARG_TASK_ID, taskId);
        TaskFragment taskFragment = new TaskFragment();
        taskFragment.setArguments(bundle);
        return taskFragment;
    }
}
