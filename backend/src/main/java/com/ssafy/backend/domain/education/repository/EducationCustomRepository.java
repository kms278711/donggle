package com.ssafy.backend.domain.education.repository;

import com.ssafy.backend.domain.education.dto.UserEducationDto;
import com.ssafy.backend.domain.education.dto.response.EducationResponseDto;

import java.util.List;

public interface EducationCustomRepository {
    List<UserEducationDto> findEducationByUser(Long userId);

    EducationResponseDto getEducationDetails(Long educationId);
}
