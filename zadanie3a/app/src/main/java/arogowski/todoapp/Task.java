package arogowski.todoapp;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.text.DateFormat;
import java.text.FieldPosition;
import java.text.ParsePosition;
import java.util.Date;
import java.util.UUID;

public class Task {
    public static final String dateFormat = "HH:mm dd-MM-yyyy";
    private final UUID id;
    private String name;
    private Date date;
    private boolean done;

    public Task() {
        id = UUID.randomUUID();
        date = new Date();
    }

    public void setName(String newName) {
        name = newName;
    }

    public Date getDate() {
        return date;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean newDone) {
        done = newDone;
    }

    public String getName() {
        return name;
    }

    public UUID getId() {
        return id;
    }
}
