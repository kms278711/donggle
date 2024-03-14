package com.ssafy.backend.domain.education.repository;

import java.util.List;

public interface ActionLearningCustomRepository {
    List<String> getActionImageListByUserAndEducation(Long userId, Long educationId);
}
