package com.ssafy.backend.domain.book.dto.response;

import lombok.Builder;

import java.util.List;

@Builder
public record BookCoverResponseDto(
        List<String> coverImagePath
) {
}
