package com.ssafy.backend.domain.education.repository;

import com.ssafy.backend.domain.education.entity.Education;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EducationRepository extends JpaRepository<Education, Long>,  EducationCustomRepository {
}
