package com.ssafy.backend.domain.approval.service;

import com.ssafy.backend.domain.approval.dto.response.ApprovalResponseDto;

import java.util.List;

public interface ApprovalService {
    void saveApproval(Long loginuserId, Long bookId, int price);

    List<ApprovalResponseDto> searchApprovals(Long loginuserId);
}
