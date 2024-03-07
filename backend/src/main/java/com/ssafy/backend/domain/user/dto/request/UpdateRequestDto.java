package com.ssafy.backend.domain.user.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.backend.domain.user.entity.User;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class UpdateRequestDto {

    private String name;
    private String nickname;

    @JsonProperty("profile_image")
    private String profileImage;

}
