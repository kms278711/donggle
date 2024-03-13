package com.ssafy.backend.domain.user.service.impl;

import com.ssafy.backend.domain.user.dto.request.PasswordRequestDto;
import com.ssafy.backend.domain.user.dto.response.UserResponseDto;
import com.ssafy.backend.domain.user.entity.User;
import com.ssafy.backend.domain.user.repository.UserRepository;
import com.ssafy.backend.domain.user.service.UserService;
import com.ssafy.backend.global.error.exception.ExceptionType;
import com.ssafy.backend.global.error.exception.UserException;
import com.ssafy.backend.global.util.S3Utils;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import static com.ssafy.backend.global.error.exception.ExceptionType.INVALID_PASSWORD;
import static com.ssafy.backend.global.error.exception.ExceptionType.INVALID_USER;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final S3Utils s3Utils;

    @Override
    @Transactional
    public void updatePassword(User user, String password) {
        user.updatePassword(passwordEncoder.encode(password));
        System.out.println("확인");
        userRepository.save(user);
    }

    @Override
    @Transactional
    public void changePassword(Long userId, PasswordRequestDto passwordRequestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        if (!passwordEncoder.matches(passwordRequestDto.currentPassword(), user.getPassword())) {
            throw new UserException(INVALID_PASSWORD);
        }
        updatePassword(user, passwordRequestDto.newPassword());
    }

    @Override
    public void changeNickname(Long userId, String nickname) {
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        user.updateNickname(nickname);
        userRepository.save(user);
    }

    @Override
    public UserResponseDto getUserInfo(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        return UserResponseDto.from(user);
    }

    @Override
    @Transactional
    public void updateStatus(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        user.updateStatus(User.Status.WITHDRAWAL);
        userRepository.save(user);
    }

    @Override
    public void updateProfileImage(Long userId, MultipartFile profileImage) {
        String folderName =  "userprofile/" + userId;
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        try {
            s3Utils.bucketDelete(folderName, user.getProfileImage().replace(folderName+"/", ""));
            s3Utils.fileUpload(folderName, profileImage);
            user.updateProfileImage(folderName+"/"+profileImage.getOriginalFilename());
            userRepository.save(user);
        } catch (Exception e) {
            throw new UserException(ExceptionType.AWS_UPLOAD_FAIL);
        }
    }

}
