package com.ssafy.backend.domain.education.entity;

import com.ssafy.backend.domain.education.entity.idClass.ActionLearningId;
import com.ssafy.backend.domain.user.entity.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@ToString
@NoArgsConstructor
@IdClass(ActionLearningId.class)
public class ActionLearning {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long actionId;

    @Id
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Id
    @ManyToOne
    @JoinColumn(name="education_id")
    private Education education;

    private String userPath;

    private boolean isSkipped;

    @Builder
    public ActionLearning(Long actionId, User user, Education education) {
        this.actionId = actionId;
        this.user = user;
        this.education = education;
    }
}
