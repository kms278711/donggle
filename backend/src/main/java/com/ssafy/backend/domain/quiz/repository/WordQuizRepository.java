package com.ssafy.backend.domain.quiz.repository;

import com.ssafy.backend.domain.quiz.entity.WordQuiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WordQuizRepository extends JpaRepository<WordQuiz, Long>, QuizCustomRepository {
    WordQuiz findAllByThemeAndBook_bookId(WordQuiz.Theme theme, Long bookId);
}
