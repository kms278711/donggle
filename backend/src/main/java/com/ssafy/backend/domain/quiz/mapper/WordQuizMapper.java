package com.ssafy.backend.domain.quiz.mapper;

import com.ssafy.backend.domain.quiz.dto.response.QuizResponseDto;
import com.ssafy.backend.domain.quiz.entity.WordQuiz;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface WordQuizMapper {
    QuizResponseDto toQuizResponseDto(WordQuiz wordQuiz);
}
