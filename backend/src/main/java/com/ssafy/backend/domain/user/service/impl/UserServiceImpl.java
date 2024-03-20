package com.ssafy.backend.domain.user.service.impl;

import com.ssafy.backend.domain.education.dto.UserEducationDto;
import com.ssafy.backend.domain.education.entity.ActionLearning;
import com.ssafy.backend.domain.education.entity.Education;
import com.ssafy.backend.domain.education.repository.actionLearning.ActionLearningRepository;
import com.ssafy.backend.domain.education.repository.education.EducationRepository;
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

import java.util.List;

import static com.ssafy.backend.global.error.exception.ExceptionType.INVALID_PASSWORD;
import static com.ssafy.backend.global.error.exception.ExceptionType.INVALID_USER;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final EducationRepository educationRepository;
    private final ActionLearningRepository actionLearningRepository;
    private final PasswordEncoder passwordEncoder;
    private final S3Utils s3Utils;

    @Override
    @Transactional
    public void updatePassword(User user, String password) {
        user.updatePassword(passwordEncoder.encode(password));
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
    public void saveEducationImage(Long userId, Long educationId, MultipartFile userActionImage, boolean isSkipped) {
        String folderName =  "word/" + educationId + "/" + userId;
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        Education education = educationRepository.findById(educationId).orElseThrow(() -> new UserException(INVALID_USER));
        String userPath = "";

        if(!userActionImage.isEmpty()) {
            String fileName = uploadToS3(userActionImage, folderName);
            userPath = folderName+"/"+fileName;
        }

        actionLearningRepository.save(ActionLearning.builder()
                        .education(education)
                        .user(user)
                        .userPath(userPath)
                        .isSkipped(isSkipped)
                        .build());
    }

    @Override
    public List<UserEducationDto> getEducationsByUser(Long userId) {
        return educationRepository.findEducationByUser(userId);
    }


    @Override
    public String updateProfileImage(Long userId, MultipartFile profileImage) {
        String folderName =  "userprofile/" + userId;
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));

        s3Utils.bucketDelete(folderName, user.getProfileImage().replace(folderName+"/", ""));
        String fileName = uploadToS3(profileImage, folderName);
        user.updateProfileImage(folderName +"/"+ fileName);
        userRepository.save(user);
        return folderName +"/"+ fileName;

    }

    private String uploadToS3(MultipartFile image, String folderName) {
        try {
            return s3Utils.fileUpload(folderName, image);
        } catch (Exception e) {
            throw new UserException(ExceptionType.AWS_UPLOAD_FAIL);
        }
    }

    @Override
    public UserResponseDto getUserInfo(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        return UserResponseDto.from(user);
    }

    @Override
    public UserResponseDto getUserInfo(String email) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new UserException(INVALID_USER));
        return UserResponseDto.from(user);
    }

    @Override
    @Transactional
    public void updateStatus(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new UserException(INVALID_USER));
        user.updateStatus(User.Status.WITHDRAWAL);
        userRepository.save(user);
    }

}
