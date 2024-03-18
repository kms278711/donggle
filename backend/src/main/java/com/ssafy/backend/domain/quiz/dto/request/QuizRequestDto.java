package com.ssafy.backend.domain.quiz.dto.request;

import com.ssafy.backend.domain.quiz.entity.WordQuiz;

public record QuizRequestDto(
        WordQuiz.Theme theme,
        Long bookId
) {
}
