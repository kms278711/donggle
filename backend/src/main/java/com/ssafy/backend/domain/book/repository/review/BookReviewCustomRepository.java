package com.ssafy.backend.domain.book.repository.review;

import com.ssafy.backend.domain.book.dto.response.BookReviewMyResponseDto;

import java.util.List;

public interface BookReviewCustomRepository {
    List<BookReviewMyResponseDto> findByUser_userId(Long userId);

}
