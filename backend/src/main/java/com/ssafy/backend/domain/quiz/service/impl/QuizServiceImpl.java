package com.ssafy.backend.domain.quiz.service.impl;

import com.ssafy.backend.domain.quiz.dto.request.QuizRequestDto;
import com.ssafy.backend.domain.quiz.dto.response.QuizResponseDto;
import com.ssafy.backend.domain.quiz.entity.WordQuiz;
import com.ssafy.backend.domain.quiz.mapper.WordQuizMapper;
import com.ssafy.backend.domain.quiz.repository.WordQuizRepository;
import com.ssafy.backend.domain.quiz.service.QuizService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class QuizServiceImpl implements QuizService {

    private final WordQuizRepository wordQuizRepository;
    private final WordQuizMapper wordQuizMapper;
    @Override
    public QuizResponseDto getQuiz(QuizRequestDto quizRequestDto)
    {
        WordQuiz wordQuiz = wordQuizRepository.findAllByThemeAndBook_bookId(quizRequestDto.theme(), quizRequestDto.bookId());
        return wordQuizMapper.toQuizResponseDto(wordQuiz);
    }
}
