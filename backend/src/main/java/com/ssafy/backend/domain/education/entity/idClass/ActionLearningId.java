package com.ssafy.backend.domain.education.entity.idClass;

import com.ssafy.backend.domain.education.entity.Education;
import com.ssafy.backend.domain.user.entity.User;

import java.io.Serializable;

public class ActionLearningId implements Serializable {
    private Long actionId;
    private User user;
    private Education education;
}
