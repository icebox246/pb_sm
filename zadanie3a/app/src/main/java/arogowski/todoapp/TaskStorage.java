package arogowski.todoapp;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class TaskStorage {
    private static TaskStorage instance = new TaskStorage();

    public static TaskStorage getInstance() {
        return instance;
    }

    List<Task> taskList;

    private TaskStorage() {
        this.taskList = new ArrayList<>();
        for (int i = 1; i <= 100; i++) {
            Task t = new Task();
            t.setName("Pilne zadanie numer " + i);
            t.setDone(i % 3 == 0);
            taskList.add(t);
        }
    }

    public List<Task> getTasks() {
        return taskList;
    }

    public Task getTask(UUID taskId) {
        return taskList.stream().filter(t -> t.getId().equals(taskId)).findFirst().orElse(null);
    }
}
