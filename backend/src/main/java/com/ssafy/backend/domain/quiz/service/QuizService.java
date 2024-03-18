package com.ssafy.backend.domain.quiz.service;

import com.ssafy.backend.domain.quiz.dto.request.QuizRequestDto;
import com.ssafy.backend.domain.quiz.dto.response.QuizResponseDto;

import java.util.List;

public interface QuizService {

    List<QuizResponseDto> getQuiz(QuizRequestDto quizRequestDto, Long userId);
}
