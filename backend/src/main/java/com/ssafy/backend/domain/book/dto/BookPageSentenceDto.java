package com.ssafy.backend.domain.book.dto;

public record BookPageSentenceDto(
        Long bookPageSentenceId,
        int sequence,
        String sentence,
        String sentenceSoundPath

) {
}
