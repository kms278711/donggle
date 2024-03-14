package com.ssafy.backend.domain.book.repository.bookpurchased;

import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.ssafy.backend.domain.book.dto.response.BookPurchasedResponseDto;
import com.ssafy.backend.domain.book.entity.QBook;
import com.ssafy.backend.domain.book.entity.QBookPurchasedLearning;

import java.util.List;

public class BookPurchasedCustomRepositoryImpl implements BookPurchasedCustomRepository{

    private final JPAQueryFactory jpaQueryFactory;

    QBook qBook = QBook.book;
    QBookPurchasedLearning qBookPurchasedLearning = QBookPurchasedLearning.bookPurchasedLearning;
    public BookPurchasedCustomRepositoryImpl(JPAQueryFactory jpaQueryFactory) {
        this.jpaQueryFactory = jpaQueryFactory;
    }

    //@Override
    public List<BookPurchasedResponseDto> findByUser_userId(Long loginUserId) {
        return jpaQueryFactory
                .select(Projections.constructor(
                        BookPurchasedResponseDto.class,
                        qBook.bookId,
                        qBook.title,
                        qBook.coverPath,
                        qBook.price,
                        ExpressionUtils.as(
                                JPAExpressions.select(qBookPurchasedLearning.isNotNull().coalesce(false))
                                        .from(qBookPurchasedLearning)
                                        .where(qBook.bookId.eq(qBookPurchasedLearning.book.bookId)
                                                .and(qBookPurchasedLearning.user.userId.eq(loginUserId))),
                                "isPay"))
                ).from(qBook)
                .fetch();
    }
}
