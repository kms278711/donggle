package com.ssafy.backend.domain.approval.dto.request;

public record BootpayRequestDto(
        String orderId,
        int status
) {
}
