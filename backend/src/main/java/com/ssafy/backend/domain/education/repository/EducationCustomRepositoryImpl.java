package com.ssafy.backend.domain.education.repository;

import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.ssafy.backend.domain.education.dto.UserEducationDto;
import com.ssafy.backend.domain.education.entity.Education;
import com.ssafy.backend.domain.education.entity.QActionLearning;
import com.ssafy.backend.domain.education.entity.QEducation;

import java.util.List;


public class EducationCustomRepositoryImpl implements EducationCustomRepository{
    private final JPAQueryFactory jpaQueryFactory;
    QEducation qEducation = QEducation.education;
    QActionLearning qActionLearning = QActionLearning.actionLearning;
    public EducationCustomRepositoryImpl(JPAQueryFactory jpaQueryFactory) {
        this.jpaQueryFactory = jpaQueryFactory;
    }

    @Override
    public List<UserEducationDto> findEducationByUser(Long userId) {
        return jpaQueryFactory
                .select(
                        Projections.constructor(UserEducationDto.class,
                                qEducation.educationId, qEducation.wordName, qEducation.imagePath,
                                ExpressionUtils.as(
                                        JPAExpressions.select(qActionLearning.isNotNull())
                                                        .from(qActionLearning)
                                                        .where(qActionLearning.education.educationId.eq(qEducation.educationId)
                                                                .and(qActionLearning.user.userId.eq(userId))),
                                        "isEducated")
                        )
                )
                .from(qEducation)
                .where(qEducation.gubun.eq(Education.Gubun.WORD))
                .fetch();
    }
}
