package com.ssafy.backend.domain.quiz.controller;

import com.ssafy.backend.domain.quiz.dto.response.QuizResponseDto;
import com.ssafy.backend.domain.quiz.entity.WordQuiz;
import com.ssafy.backend.domain.quiz.service.QuizService;
import com.ssafy.backend.domain.user.dto.LoginUserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/quizzes")
public class QuizController {

    @Autowired
    private QuizService quizService;
    @GetMapping()
    public ResponseEntity<List<QuizResponseDto>> getQuiz(@RequestParam WordQuiz.Theme theme,  @RequestParam(required = false) Long bookId, Authentication authentication) {
        Long userId = getCurrentUserId(authentication);
        return ResponseEntity.ok(quizService.getQuiz(theme, bookId, userId));
    }

    private static Long getCurrentUserId(Authentication authentication) {
        LoginUserDto user = (LoginUserDto)(authentication.getPrincipal());
        return user.userId();
    }
}
