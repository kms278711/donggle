package com.ssafy.backend.domain.approval.dto.response;

import java.time.LocalDateTime;

public record ApprovalResponseDto(
        Long approvalId,
        int price,
        LocalDateTime approvalDate,
        Long bookId,
        String bookTitle
) {
}
