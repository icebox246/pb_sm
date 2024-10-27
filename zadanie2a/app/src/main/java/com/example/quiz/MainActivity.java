package com.example.quiz;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    private TextView questionTextView;

    private static final String KEY_CURRENT_INDEX = "currentIndex";
    public static final String KEY_EXTRA_ANSWER = "com.example.correctAnswer";
    private boolean answerWasShown;

    private final Question[] questions = {
            new Question(R.string.q_long, false),
            new Question(R.string.q_vla, true),
            new Question(R.string.q_array, true),
            new Question(R.string.q_func_pointer, false),
            new Question(R.string.q_char_ptr, false),
    };

    private int currentIndex = 0;

    private void checkAnswerCorrectness(boolean userAnswer) {
        boolean actualAnswer = questions[currentIndex].isTrueAnswer();
        int resultMessageId;
        if (answerWasShown) {
            resultMessageId = R.string.answer_was_shown;
        } else {
            if (userAnswer == actualAnswer) {
                resultMessageId = R.string.correct_answer;
            } else {
                resultMessageId = R.string.incorrect_answer;
            }
        }
        Toast.makeText(this, resultMessageId, Toast.LENGTH_SHORT).show();
    }

    private void setNextQuestion() {
        questionTextView.setText(questions[currentIndex].getQuestionId());
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Log.d("QUIZZ", "onCreate was called");

        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);

        if(savedInstanceState != null) {
            currentIndex = savedInstanceState.getInt(KEY_CURRENT_INDEX);
        }

        Button trueButton = findViewById(R.id.true_button);
        Button falseButton = findViewById(R.id.false_button);
        Button nextButton = findViewById(R.id.next_button);
        Button promptButton = findViewById(R.id.prompt_button);
        questionTextView = findViewById(R.id.question_text_view);

        trueButton.setOnClickListener((View v) -> checkAnswerCorrectness(true));

        falseButton.setOnClickListener((View v) -> checkAnswerCorrectness(false));

        nextButton.setOnClickListener((View v) -> {
            currentIndex = (currentIndex + 1) % questions.length;
            answerWasShown = false;
            setNextQuestion();
        });

        ActivityResultLauncher<Intent> startForPrompt = registerForActivityResult(new ActivityResultContracts.StartActivityForResult(),
            (ActivityResult result) -> {
                if (result.getResultCode() != RESULT_OK) {
                    return;
                }
                Intent data = result.getData();
                if (data == null) {
                    return;
                }
                answerWasShown = data.getBooleanExtra(PromptActivity.KEY_EXTRA_ANSWER_SHOWN, false);
            }
        );

        promptButton.setOnClickListener((View v) -> {
            Intent intent = new Intent(MainActivity.this, PromptActivity.class);
            boolean correctAnswer = questions[currentIndex].isTrueAnswer();
            intent.putExtra(KEY_EXTRA_ANSWER, correctAnswer);
            startForPrompt.launch(intent);
        });

        setNextQuestion();

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }

    @Override
    protected void onStart() {
        super.onStart();

        Log.d("QUIZZ", "onStart was called");
    }

    @Override
    protected void onResume() {
        super.onResume();

        Log.d("QUIZZ", "onResume was called");
    }

    @Override
    protected void onPause() {
        super.onPause();

        Log.d("QUIZZ", "onPause was called");
    }

    @Override
    protected void onStop() {
        super.onStop();

        Log.d("QUIZZ", "onStop was called");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        Log.d("QUIZZ", "onDestroy was called");
    }

    @Override
    protected void onSaveInstanceState(@NonNull Bundle outState) {
        super.onSaveInstanceState(outState);

        Log.d("QUIZZ", "onSaveInstanceState was called");
        outState.putInt(KEY_CURRENT_INDEX, currentIndex);
    }
}