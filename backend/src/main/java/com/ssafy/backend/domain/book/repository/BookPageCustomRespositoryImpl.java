package com.ssafy.backend.domain.book.repository;

import com.querydsl.core.QueryFactory;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.BookPageSentenceDto;
import com.ssafy.backend.domain.book.entity.*;
import com.ssafy.backend.domain.education.entity.Education;
import com.ssafy.backend.domain.education.entity.QEducation;

import java.util.List;

public class BookPageCustomRespositoryImpl implements BookPageCustomRespository{

    private final JPAQueryFactory jpaQueryFactory;
    QBookPage qBookPage = QBookPage.bookPage;
    QBook qBook = QBook.book;
    QBookPageSentence qBookPageSentence = QBookPageSentence.bookPageSentence;
    QEducation qEducation = QEducation.education;
    public BookPageCustomRespositoryImpl(JPAQueryFactory jpaQueryFactory) {
        this.jpaQueryFactory = jpaQueryFactory;
    }

    @Override
    public BookPage findByBookPage(Long bookId, int bookPage) {
        BookPage page = jpaQueryFactory
                .select(qBookPage)
                .from(qBook)
                .innerJoin(qBookPage)
                .on(qBook.bookId.eq(qBookPage.book.bookId))
                .where(qBook.bookId.eq(bookId).and(qBookPage.page.eq(bookPage)))
                .fetchOne();

        return page;
    }

    @Override
    public List<BookPageSentence> findByBookPageId(Long bookPageId) {
        List<BookPageSentence> sentences = jpaQueryFactory
                .select(qBookPageSentence)
                .from(qBookPage)
                .innerJoin(qBookPageSentence)
                .on(qBookPage.bookPageId.eq(qBookPageSentence.bookPage.bookPageId))
                .where(qBookPage.bookPageId.eq(bookPageId))
                .fetch();

        return sentences;
    }

    @Override
    public Education findByBookSentenceId(List<Long> bookPageSentenceId) {
        Education education = jpaQueryFactory
                .select(qEducation)
                .from(qBookPageSentence)
                .innerJoin(qEducation)
                .on(qBookPageSentence.bookPageSentenceId.eq(qEducation.bookPageSentence.bookPageSentenceId))
                .where(qBookPageSentence.bookPageSentenceId.in(bookPageSentenceId))
                .fetchOne();
        return education;
    }
}
