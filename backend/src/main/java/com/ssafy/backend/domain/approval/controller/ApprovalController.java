package com.ssafy.backend.domain.approval.controller;

import com.ssafy.backend.domain.approval.dto.request.ApprovalRequestDto;
import com.ssafy.backend.domain.approval.dto.request.BootpayRequestDto;
import com.ssafy.backend.domain.approval.dto.response.ApprovalResponseDto;
import com.ssafy.backend.domain.approval.service.ApprovalService;
import com.ssafy.backend.global.util.AuthenticationUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/approvals")
@RequiredArgsConstructor
public class ApprovalController {


    private final ApprovalService approvalService;

    // 결제내역 저장
    @PostMapping
    public ResponseEntity<String> saveApproval(Authentication authentication,
                                               @RequestBody ApprovalRequestDto approvalRequestDto) {
        Long loginUserId = AuthenticationUtil.getCurrentUserId(authentication);
        approvalService.saveApproval(loginUserId, approvalRequestDto);

        return ResponseEntity.ok("결제 내역이 저장되었습니다.");
    }

    // 부트페이
    @PostMapping("/bootpay")
    public ResponseEntity<String> bootpay(@RequestBody BootpayRequestDto bootpayRequestDto) {
        approvalService.bootpay(bootpayRequestDto);

        return ResponseEntity.ok("결제 내역이 저장되었습니다.");
    }


    // 결제 내역 조회
    @GetMapping
    public ResponseEntity<List<ApprovalResponseDto>> searchApprovals(Authentication authentication) {
        Long loginUserId = AuthenticationUtil.getCurrentUserId(authentication);
        List<ApprovalResponseDto> approvals =  approvalService.searchApprovals(loginUserId);

        return ResponseEntity.ok(approvals);
    }
}
