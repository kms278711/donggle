package com.ssafy.backend.domain.book.service;

import com.ssafy.backend.domain.book.dto.*;

import java.util.List;

public interface BookService {

    List<BookDto> searchAllBook();
    BookDto searchBook(Long bookId);
    BookPageDto searchBookPage(Long bookId, int page);
    BookInfoDto searchBookInfo(Long bookId, Long loginUserId);
    void saveProgressBookPage(Long loginUserId, Long bookId, int page);

    void createReview(Long loginUserId, Long bookId, BookReviewRequestDto bookReviewRequestDto);
}
