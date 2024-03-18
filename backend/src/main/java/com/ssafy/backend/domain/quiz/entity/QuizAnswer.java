package com.ssafy.backend.domain.quiz.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.ToString;

@Entity
@Getter
@ToString
public class QuizAnswer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long choiceId;

    private String choice;
    private boolean isAnswer;
    private String choiceImagePath;

    @ManyToOne
    private WordQuiz wordQuiz;
}
