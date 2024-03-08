package com.ssafy.backend.domain.user.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record UpdateRequestDto (
    String name,
    String nickname,
    @JsonProperty("profile_image")
    String profileImage
) {
}
