package com.ssafy.backend.domain.quiz.service;

import com.ssafy.backend.domain.quiz.dto.request.QuizRequestDto;
import com.ssafy.backend.domain.quiz.dto.response.QuizResponseDto;
import com.ssafy.backend.domain.quiz.entity.WordQuiz;

public interface QuizService {

    QuizResponseDto getQuiz(QuizRequestDto quizRequestDto);
}
