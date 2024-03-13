package com.ssafy.backend.domain.book.dto;

import lombok.Builder;

@Builder
public record BookReviewRequestDto(
        int score,
        String content
) {
}
