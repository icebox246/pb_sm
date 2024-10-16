package com.example.quiz;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    private Button trueButton;
    private Button falseButton;
    private Button nextButton;
    private TextView questionTextView;

    private Question[] questions = {
            new Question(R.string.q_long, false),
            new Question(R.string.q_vla, true),
            new Question(R.string.q_array, true),
            new Question(R.string.q_func_pointer, false),
            new Question(R.string.q_char_ptr, false),
    };

    private int currentIndex = 0;

    private void checkAnswerCorrecteness(boolean userAnswer) {
        boolean actualAnswer = questions[currentIndex].isTrueAnswer();
        int resultMessageId;
        if (userAnswer == actualAnswer) {
            resultMessageId = R.string.correct_answer;
        } else {
            resultMessageId = R.string.incorrect_answer;
        }
        Toast.makeText(this, resultMessageId, Toast.LENGTH_SHORT).show();
    }

    private void setNextQuestion() {
        questionTextView.setText(questions[currentIndex].getQuestionId());
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);

        trueButton = findViewById(R.id.true_button);
        falseButton = findViewById(R.id.false_button);
        nextButton = findViewById(R.id.next_button);
        questionTextView = findViewById(R.id.question_text_view);

        trueButton.setOnClickListener((View v) -> {
            checkAnswerCorrecteness(true);
        });

        falseButton.setOnClickListener((View v) -> {
            checkAnswerCorrecteness(false);
        });

        nextButton.setOnClickListener((View v) -> {
            currentIndex = (currentIndex + 1) % questions.length;
            setNextQuestion();
        });

        setNextQuestion();

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}