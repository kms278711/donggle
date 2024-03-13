package com.ssafy.backend.domain.user.service;

import com.ssafy.backend.domain.user.dto.request.PasswordRequestDto;
import com.ssafy.backend.domain.user.dto.response.UserResponseDto;
import com.ssafy.backend.domain.user.entity.User;
import org.springframework.web.multipart.MultipartFile;

public interface UserService {

    void updatePassword(User user, String password);
    void changePassword(Long userId, PasswordRequestDto passwordRequestDto);
    UserResponseDto getUserInfo(Long userId);
    void updateStatus(Long userId);
    void updateProfileImage(Long userId, MultipartFile profileImage);
    void changeNickname(Long userId, String nickname);
    void saveEducationImage(Long userId, Long educationId, MultipartFile userActionImage, boolean isSkipped);
}