package com.ssafy.backend.domain.book.dto.request;

import lombok.Builder;

@Builder
public record BookReviewRequestDto(
        int score,
        String content
) {
}
