package com.ssafy.backend.domain.book.service;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.dto.BookInfoDto;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.UserBookProcessDto;
import com.ssafy.backend.domain.book.dto.request.BookReviewRequestDto;
import com.ssafy.backend.domain.book.dto.response.BookPurchasedResponseDto;
import com.ssafy.backend.domain.book.dto.response.BookReviewMyResponseDto;
import com.ssafy.backend.domain.book.dto.response.BookReviewResponseDto;

import java.util.List;

public interface BookService {

    List<BookPurchasedResponseDto> searchAllBook(Long loginUserId);
    BookDto searchBook(Long bookId, Long loginUserId);
    BookPageDto searchBookPage(Long bookId, int page);
    BookInfoDto searchBookInfo(Long bookId, Long loginUserId);
    void saveProgressBookPage(Long loginUserId, Long bookId, int page);
    void createReview(Long loginUserId, Long bookId, BookReviewRequestDto bookReviewRequestDto);
    List<UserBookProcessDto> searchProcessBook(Long loginUserId);
    List<BookPurchasedResponseDto> searchPurchasedBook(Long loginUserId);
    List<BookReviewResponseDto> searchReviews(Long bookId);
    List<BookReviewMyResponseDto> searchMyReviews(Long loginUserId);
    void changeMyReview(Long bookId, Long loginUserId, BookReviewRequestDto bookReviewRequestDto);

    void deleteMyReview(Long bookId, Long loginUserId);
}