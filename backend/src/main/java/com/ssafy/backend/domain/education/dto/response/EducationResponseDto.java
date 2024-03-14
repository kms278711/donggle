package com.ssafy.backend.domain.education.dto.response;

import lombok.Builder;

import java.util.ArrayList;
import java.util.List;

@Builder
public record EducationResponseDto(
        String wordName,
        String imagePath,
        String bookTitle,
        String bookSentence,
        List<String> userImages
) {
    public EducationResponseDto(String wordName, String imagePath, String bookTitle, String bookSentence) {
        this(wordName, imagePath, bookTitle, bookSentence, new ArrayList<>());
    }

    public static EducationResponseDto from(EducationResponseDto educationResponseDto, List<String> userImageList) {
        return EducationResponseDto.builder()
                .wordName(educationResponseDto.wordName())
                .imagePath(educationResponseDto.imagePath())
                .bookTitle(educationResponseDto.bookTitle())
                .bookSentence(educationResponseDto.bookSentence())
                .userImages(userImageList)
                .build();
    }
}
