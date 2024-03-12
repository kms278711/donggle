package com.ssafy.backend.domain.user.controller;

import com.ssafy.backend.domain.user.dto.LoginUserDto;
import com.ssafy.backend.domain.user.dto.request.PasswordRequestDto;
import com.ssafy.backend.domain.user.dto.response.UserResponseDto;
import com.ssafy.backend.domain.user.service.UserService;
import com.ssafy.backend.global.error.exception.UserException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@PreAuthorize("(hasAuthority('ROLE_USER') or hasAuthority('ROLE_ADMIN')) and (#userId == authentication.principal.userId)")
public class UserController {

    private final UserService userService;

    /**
     * 유저 정보 가져오기
     */
    @GetMapping()
    public ResponseEntity<UserResponseDto> getUserInfo(Authentication authentication) {
        Long userId = getCurrentUserId(authentication);
        return ResponseEntity.ok(userService.getUserInfo(userId));
    }

    /**
     * 비밀번호 변경
     */
    @PatchMapping("/password")
    public ResponseEntity<String> changePassword(Authentication authentication, @RequestBody PasswordRequestDto passwordRequestDto) {
        try {
            Long userId = getCurrentUserId(authentication);
            userService.changePassword(userId, passwordRequestDto);
        } catch (UserException e) {
            return ResponseEntity.ok("비밀번호를 확인해주세요.");
        }
        return ResponseEntity.ok("비밀번호 변경이 완료되었습니다.");
    }

    /**
     * 닉네임 변경
     */
    @PatchMapping("/nickname")
    public ResponseEntity<String> changeNickname(Authentication authentication, @RequestParam String nickname) {
        try {
            Long userId = getCurrentUserId(authentication);
            userService.changeNickname(userId, nickname);
        } catch (UserException e) {
            return ResponseEntity.ok("잘못된 요청입니다.");
        }
        return ResponseEntity.ok("닉네임 변경이 완료되었습니다.");
    }

    /**
     * 회원탈퇴
     */
    @DeleteMapping()
    public ResponseEntity<String> withdraw(Authentication authentication) {
        Long userId = getCurrentUserId(authentication);
        userService.updateStatus(userId);
        return ResponseEntity.ok("회원탈퇴에 성공했습니다.");
    }

    /**
     * 프로필 이미지 변경
     */
    @PatchMapping("/profile-image")
    public ResponseEntity<String> updateProfileImage(Authentication authentication,@RequestParam MultipartFile profileImage) {
        Long userId = getCurrentUserId(authentication);
        userService.updateProfileImage(userId, profileImage);
        return ResponseEntity.ok("프로필 이미지 수정에 성공했습니다.");
    }

    private static Long getCurrentUserId(Authentication authentication) {
        LoginUserDto user = (LoginUserDto)(authentication.getPrincipal());
        return user.userId();
    }

}

