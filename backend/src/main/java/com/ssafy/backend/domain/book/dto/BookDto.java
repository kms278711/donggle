package com.ssafy.backend.domain.book.dto;
import lombok.Builder;
import lombok.Setter;

@Builder
public record BookDto(
        Long bookId,
        String title,
        String summary,
        String coverPath,
        int price,
        boolean isPay
)
{

}
