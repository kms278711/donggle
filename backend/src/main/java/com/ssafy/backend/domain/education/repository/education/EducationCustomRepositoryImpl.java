package com.ssafy.backend.domain.education.repository.education;

import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.ssafy.backend.domain.book.entity.QBook;
import com.ssafy.backend.domain.book.entity.QBookPage;
import com.ssafy.backend.domain.book.entity.QBookPageSentence;
import com.ssafy.backend.domain.education.dto.UserEducationDto;
import com.ssafy.backend.domain.education.dto.response.EducationResponseDto;
import com.ssafy.backend.domain.education.entity.Education;
import com.ssafy.backend.domain.education.entity.QActionLearning;
import com.ssafy.backend.domain.education.entity.QEducation;

import java.util.List;


public class EducationCustomRepositoryImpl implements EducationCustomRepository {
	private final JPAQueryFactory jpaQueryFactory;
	QEducation qEducation = QEducation.education;
	QActionLearning qActionLearning = QActionLearning.actionLearning;
	QBookPageSentence qBookPageSentence = QBookPageSentence.bookPageSentence;

	QBook qBook = QBook.book;
	QBookPage qBookPage = QBookPage.bookPage;

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

	@Override
	public EducationResponseDto getEducationDetails(Long educationId) {
		return jpaQueryFactory
				.select(
						Projections.constructor(EducationResponseDto.class,
								qEducation.wordName,
								qEducation.imagePath,
								qBook.title,
								qBookPageSentence.sentence
						)
				)
				.from(qEducation)
				.innerJoin(qBookPageSentence)
				.on(qBookPageSentence.bookPageSentenceId.eq(qEducation.bookPageSentence.bookPageSentenceId))
				.innerJoin(qBookPage)
				.on(qBookPage.bookPageId.eq(qBookPageSentence.bookPage.bookPageId))
				.innerJoin(qBook)
				.on(qBook.bookId.eq(qBookPage.book.bookId))
				.where(qEducation.educationId.eq(educationId))
				.fetchOne();
	}
}
