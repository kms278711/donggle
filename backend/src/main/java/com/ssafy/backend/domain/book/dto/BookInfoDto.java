package com.ssafy.backend.domain.book.dto;

import com.ssafy.backend.domain.education.dto.EducationDto;
import lombok.Builder;

import java.util.List;

@Builder
public record BookInfoDto(
        Long bookId,
        String title,
        String coverImagePath,
        int processPage,
        List<EducationDto> educations
) {
}
