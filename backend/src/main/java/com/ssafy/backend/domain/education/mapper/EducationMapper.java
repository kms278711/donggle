package com.ssafy.backend.domain.education.mapper;

import com.ssafy.backend.domain.education.dto.EducationDto;
import com.ssafy.backend.domain.education.entity.Education;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface EducationMapper {
    EducationDto toEducationDto(Education education);
}
