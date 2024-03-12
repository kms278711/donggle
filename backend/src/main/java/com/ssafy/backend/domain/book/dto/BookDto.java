package com.ssafy.backend.domain.book.dto;
import lombok.Builder;

@Builder
public record BookDto(
        Long bookId,
        String title,
        String summary,
        String path,
        String price,
        boolean isPay
)
{

}
