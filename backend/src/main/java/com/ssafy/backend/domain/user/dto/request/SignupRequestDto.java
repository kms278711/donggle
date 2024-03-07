package com.ssafy.backend.domain.user.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.backend.domain.user.entity.User;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Builder
public record SignupRequestDto (
    String email,
    String password,
    String name,

    User.Role role)
{

}
