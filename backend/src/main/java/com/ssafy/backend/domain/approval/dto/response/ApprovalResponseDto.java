package com.ssafy.backend.domain.approval.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;

public record ApprovalResponseDto(
        Long approvalId,
        int price,
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
        LocalDateTime approvalDate,
        Long bookId,
        String bookTitle,
        String coverPath
) {
}
