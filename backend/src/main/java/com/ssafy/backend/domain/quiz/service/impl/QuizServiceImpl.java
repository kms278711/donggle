package com.ssafy.backend.domain.quiz.service.impl;

import com.ssafy.backend.domain.quiz.dto.request.QuizRequestDto;
import com.ssafy.backend.domain.quiz.dto.response.QuizResponseDto;
import com.ssafy.backend.domain.quiz.entity.WordQuiz;
import com.ssafy.backend.domain.quiz.mapper.WordQuizMapper;
import com.ssafy.backend.domain.quiz.repository.WordQuizRepository;
import com.ssafy.backend.domain.quiz.service.QuizService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QuizServiceImpl implements QuizService {

    private final WordQuizRepository wordQuizRepository;
    private final WordQuizMapper wordQuizMapper;
    @Override
    public List<QuizResponseDto> getQuiz(QuizRequestDto quizRequestDto, Long userId)
    {
        List<QuizResponseDto> quizResponseDto = null;
        List<WordQuiz> wordQuizzes = null;

        if(quizRequestDto.theme().equals(WordQuiz.Theme.WORD)) {
            wordQuizzes = wordQuizRepository.getWordQuiz(quizRequestDto.theme(), userId);
        } else {
            wordQuizzes = wordQuizRepository.findAllByThemeAndBook_bookId(quizRequestDto.theme(), quizRequestDto.bookId());
        }
        quizResponseDto = wordQuizzes.stream()
                .map(wordQuizMapper::toQuizResponseDto)
                .toList();
        return quizResponseDto;
    }
}
