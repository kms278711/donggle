package com.ssafy.backend.domain.user.dto.response;

import com.ssafy.backend.domain.user.entity.User;
import lombok.Builder;

@Builder
public record UserResponseDto (
    Long userId,
    String email,
    String nickname,
    String role,
    String profileImage
)
{
    public static UserResponseDto from(User user) {
        return UserResponseDto.builder()
                .userId(user.getUserId())
                .email(user.getEmail())
                .nickname(user.getNickname())
                .role(user.getRole().name())
                .profileImage(user.getProfileImage())
                .build();
    }
}
