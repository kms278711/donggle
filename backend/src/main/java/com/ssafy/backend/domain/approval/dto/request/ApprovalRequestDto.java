package com.ssafy.backend.domain.approval.dto.request;

public record ApprovalRequestDto(
        BootpayRequestDto bootpayRequestDto,
        Long bookId
) {
}
