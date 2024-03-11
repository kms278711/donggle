package com.ssafy.backend.domain.book.dto;

import com.querydsl.core.annotations.QueryProjection;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import com.ssafy.backend.domain.education.dto.EducationDto;
import com.ssafy.backend.domain.education.entity.Education;
import jakarta.persistence.Column;
import lombok.Builder;

import java.util.List;
@Builder
public record BookPageDto(
        Long bookPageId,
        String bookImagePath,
        int page,
        String content,
        @Column(name = "sentence")
        List<BookPageSentenceDto> bookPageSentences,
        EducationDto education
) {

}
