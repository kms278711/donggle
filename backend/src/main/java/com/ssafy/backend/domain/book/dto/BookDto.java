package com.ssafy.backend.domain.book.dto;

import com.ssafy.backend.domain.book.dto.response.BookReviewResponseDto;
import lombok.Builder;

import java.util.List;

@Builder
public record BookDto(
        Long bookId,
        String title,
        String summary,
        String coverPath,
        int price,
        boolean isPay,
        List<BookReviewResponseDto> bookReviews
)
{

}
