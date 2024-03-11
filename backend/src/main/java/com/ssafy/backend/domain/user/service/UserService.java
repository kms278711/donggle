package com.ssafy.backend.domain.user.service;

import com.ssafy.backend.domain.user.dto.request.PasswordRequestDto;
import com.ssafy.backend.domain.user.dto.response.UserResponseDto;
import com.ssafy.backend.domain.user.entity.User;

public interface UserService {

    boolean checkPassword(Long userId, String password);
    void updatePassword(User user, String password);
    void changePassword(Long userId, PasswordRequestDto passwordRequestDto);
    String getRandomNickname();
    String nicknameGenerator();
    UserResponseDto getUserInfo(Long userId);
    void updateStatus(Long userId);
    void updateNickname(Long userId, String nickname);
    boolean duplicateCheckNickname(String nickname);
    void updateProfileImage(Long userId, String profileImage);

}
