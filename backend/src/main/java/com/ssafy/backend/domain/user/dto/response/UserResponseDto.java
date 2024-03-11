package com.ssafy.backend.domain.user.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.backend.domain.user.entity.User;
import lombok.*;

@Builder
public record UserResponseDto (
    Long userId,
    String email,
    String nickname,
    String role,

    @JsonProperty("profile_image")
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
