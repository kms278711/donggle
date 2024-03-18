package com.ssafy.backend.domain.quiz.entity;

import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.education.entity.Education;
import jakarta.persistence.*;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
public class WordQuiz {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long quiz_id;

    @ManyToOne
    private Education education;

    @ManyToOne
    private Book book;

    private Theme theme;
    private String content;

    @OneToMany(mappedBy = "wordQuiz")
    private List<QuizAnswer> quizAnswerList = new ArrayList<>();

    public enum Theme {
        WORD,
        STORY
    }
}
