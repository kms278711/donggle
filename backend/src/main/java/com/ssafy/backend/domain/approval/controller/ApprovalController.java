package com.ssafy.backend.domain.approval.controller;

import com.ssafy.backend.domain.approval.dto.response.ApprovalResponseDto;
import com.ssafy.backend.domain.approval.service.ApprovalService;
import com.ssafy.backend.global.util.AuthenticationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/approvals")
public class ApprovalController {

    @Autowired
    private ApprovalService approvalService;

    @PostMapping("{bookId}")
    public ResponseEntity<String> saveApproval(@PathVariable("bookId") Long bookId,
                                               Authentication authentication,
                                               @RequestParam int price) {
        Long loginuserId = AuthenticationUtil.getCurrentUserId(authentication);
        approvalService.saveApproval(loginuserId, bookId, price);

        return ResponseEntity.ok("결제 내역이 저장되었습니다.");
    }

    @GetMapping
    public ResponseEntity<List<ApprovalResponseDto>> searchApprovals(Authentication authentication) {
        Long loginuserId = AuthenticationUtil.getCurrentUserId(authentication);
        List<ApprovalResponseDto> approvals =  approvalService.searchApprovals(loginuserId);

        return ResponseEntity.ok(approvals);
    }
}
