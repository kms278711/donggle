package com.ssafy.backend.domain.user.controller;

import com.ssafy.backend.domain.user.dto.request.PasswordRequestDto;
import com.ssafy.backend.domain.user.dto.request.UpdateRequestDto;
import com.ssafy.backend.domain.user.service.UserService;
import com.ssafy.backend.global.dto.Response;
import com.ssafy.backend.global.error.exception.UserException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@PreAuthorize("(hasAuthority('ROLE_USER') or hasAuthority('ROLE_ADMIN')) and (#userId == authentication.principal.userId)")
public class UserController {

    private final UserService userService;

    @GetMapping("/{user_id}")
    public ResponseEntity getUserInfo(@PathVariable("user_id") Long userId) {
        return ResponseEntity.ok(Response.success(userService.getUserInfo(userId)));
    }

    @PatchMapping("/{user_id}")
    public ResponseEntity updateUser(@PathVariable("user_id") Long userId, @RequestBody UpdateRequestDto updateRequestDto) {
        return ResponseEntity.ok(Response.success());
    }

    @PostMapping("/{user_id}/password/check")
    public ResponseEntity checkPassword(@PathVariable("user_id") Long userId, @RequestBody PasswordRequestDto passwordRequestDto) {
        if (!userService.checkPassword(userId, passwordRequestDto.currentPassword())) {
            return ResponseEntity.ok(Response.fail(HttpStatus.BAD_REQUEST.name(), "비밀번호가 맞지 않습니다."));
        }
        return ResponseEntity.ok(Response.success());
    }

    @PatchMapping("/{user_id}/password")
    public ResponseEntity changePassword(@PathVariable("user_id") Long userId, @RequestBody PasswordRequestDto passwordRequestDto) {
        try {
            userService.changePassword(userId, passwordRequestDto);
        } catch (UserException e) {
            return ResponseEntity.ok(Response.fail(HttpStatus.BAD_REQUEST.name(), "현재 비밀번호가 일치하지 않습니다."));
        }
        return ResponseEntity.ok(Response.success());
    }

    @DeleteMapping("/{user_id}")
    public ResponseEntity withdraw(@PathVariable("user_id") Long userId) {
        userService.updateStatus(userId);
        return ResponseEntity.ok(Response.success());
    }

    @GetMapping("/{user_id}/nickname")
    public ResponseEntity duplicateCheckNickname(@PathVariable("user_id") Long userId, @RequestParam String nickname) {
        if (userService.duplicateCheckNickname(nickname)) {
            return ResponseEntity.ok(Response.fail(HttpStatus.BAD_REQUEST.name(), "중복된 닉네임이 존재합니다."));
        }
        return ResponseEntity.ok(Response.success());
    }

    @PatchMapping("/{user_id}/name")
    public ResponseEntity updateName(@PathVariable("user_id") Long userId, @RequestBody UpdateRequestDto updateRequestDto) {
        userService.updateName(userId, updateRequestDto.name());
        return ResponseEntity.ok(Response.success());
    }

    @PatchMapping("/{user_id}/nickname")
    public ResponseEntity updateNickname(@PathVariable("user_id") Long userId, @RequestBody UpdateRequestDto updateRequestDto) {
        userService.updateNickname(userId, updateRequestDto.nickname());
        return ResponseEntity.ok(Response.success());
    }

    @PatchMapping("/{user_id}/profile-image")
    public ResponseEntity updateProfileImage(@PathVariable("user_id") Long userId, @RequestBody UpdateRequestDto updateRequestDto) {
        userService.updateProfileImage(userId, updateRequestDto.profileImage());
        return ResponseEntity.ok(Response.success());
    }

}

