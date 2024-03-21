package com.ssafy.backend.domain.book.service;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.dto.BookInfoDto;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.UserBookProcessDto;
import com.ssafy.backend.domain.book.dto.response.BookPurchasedResponseDto;

import java.util.List;

public interface BookService {

    // 책 정보 전체 조회
    List<BookPurchasedResponseDto> searchAllBook(Long loginUserId);
    // 책 정보 조회(구매창)
    BookDto searchBook(Long bookId, Long loginUserId);
    // 책 페이지 조회
    BookPageDto searchBookPage(Long bookId, int page);
    // 책 정보 조회(책 클릭시)
    BookInfoDto searchBookInfo(Long bookId, Long loginUserId);
    // 현재 진행중인 페이지 저장
    void saveProgressBookPage(Long loginUserId, Long bookId, int page);
    // 진행중인 책 조회
    List<UserBookProcessDto> searchProcessBook(Long loginUserId);
    // 구매한 책 조회
    List<BookPurchasedResponseDto> searchPurchasedBook(Long loginUserId);


}
