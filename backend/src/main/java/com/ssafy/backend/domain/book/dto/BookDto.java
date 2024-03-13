package com.ssafy.backend.domain.book.dto;
import lombok.Builder;

@Builder
public record BookDto(
        Long bookId,
        String title,
        String summary,
        String coverPath,
        String price,
        boolean isPay
)
{

}
