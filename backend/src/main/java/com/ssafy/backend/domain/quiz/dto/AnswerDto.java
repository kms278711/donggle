package com.ssafy.backend.domain.quiz.dto;

public record AnswerDto(
        String choice,
        Boolean isAnswer,
        String choiceImagePath
) {
}
