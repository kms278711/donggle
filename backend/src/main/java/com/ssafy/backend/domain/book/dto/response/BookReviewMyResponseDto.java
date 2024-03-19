package com.ssafy.backend.domain.book.dto.response;

import lombok.Builder;

@Builder
public record BookReviewMyResponseDto(
        Long bookId,
        Long userId,
        String title,
        String coverPath,
        double score,
        String content
) {
}
