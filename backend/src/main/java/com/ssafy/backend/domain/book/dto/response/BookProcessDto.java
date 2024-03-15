package com.ssafy.backend.domain.book.dto.response;

import lombok.Builder;

@Builder
public record BookProcessDto(
        Long bookId,
        String title,
        String coverPath
) {
}
