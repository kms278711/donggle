package com.ssafy.backend.domain.book.controller;

import com.ssafy.backend.domain.book.dto.*;
import com.ssafy.backend.domain.book.dto.request.BookReviewRequestDto;
import com.ssafy.backend.domain.book.dto.response.BookPurchasedResponseDto;
import com.ssafy.backend.domain.book.dto.response.BookReviewResponseDto;
import com.ssafy.backend.domain.book.service.BookService;
import com.ssafy.backend.domain.user.dto.LoginUserDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/books")
@RequiredArgsConstructor
public class BookController {

    private final BookService bookService;

    // 책 목록 전체 조회
    @GetMapping
    public ResponseEntity<List<BookPurchasedResponseDto>> searchAllBook(Authentication authentication) {
        LoginUserDto loginUser = (LoginUserDto) authentication.getPrincipal();
        Long loginUserId = loginUser.userId();
        List<BookPurchasedResponseDto> books = bookService.searchAllBook(loginUserId);

        return ResponseEntity.ok(books);
    }

    // 책 정보 조회(책 클릭시)
    @GetMapping("/{bookId}")
    public ResponseEntity<BookInfoDto> searchBookInfo(@PathVariable("bookId") Long bookId, Authentication authentication) {
        LoginUserDto loginUser = (LoginUserDto) authentication.getPrincipal();
        Long loginUserId = loginUser.userId();
        BookInfoDto bookInfo = bookService.searchBookInfo(bookId, loginUserId);

        return ResponseEntity.ok(bookInfo);
    }

    // 책 단일 조회(구매창)
    @GetMapping("/{bookId}/purchase")
    public ResponseEntity<BookDto> searchBook(@PathVariable("bookId") Long bookId) {
        BookDto bookDto = bookService.searchBook(bookId);

        return ResponseEntity.ok(bookDto);
    }

    // 책 페이지 조회
    @GetMapping("/{bookId}/pages/{page}")
    public  ResponseEntity<BookPageDto> searchBookPage(@PathVariable("bookId") Long bookId, @PathVariable("page") int page) {
        BookPageDto bookPageDto = bookService.searchBookPage(bookId, page);

        return ResponseEntity.ok(bookPageDto);
    }


    // 다음 페이지로 넘어가기 전 현재 페이지 정보 저장
    @PostMapping("/{bookId}/pages/{page}")
    public ResponseEntity<String> saveProgressBookPage(@PathVariable("bookId") Long bookId, @PathVariable("page") int page, Authentication authentication) {
        LoginUserDto loginUser = (LoginUserDto) authentication.getPrincipal();
        Long loginUserId = loginUser.userId();
        bookService.saveProgressBookPage(loginUserId, bookId, page);

        return ResponseEntity.ok("진행중인 페이지가 저장되었습니다.");
    }

    // 진행중인 책 조회
    @GetMapping("/mybooks")
    public ResponseEntity<List<UserBookProcessDto>> searchProcessBook(Authentication authentication) {
        LoginUserDto loginUser = (LoginUserDto) authentication.getPrincipal();
        Long loginUserId = loginUser.userId();
        List<UserBookProcessDto> processBooks = bookService.searchProcessBook(loginUserId);

        return ResponseEntity.ok(processBooks);
    }

    // 구매한 책 조회
    @GetMapping("/purchase")
    public ResponseEntity<List<BookPurchasedResponseDto>> searchPurchasedBook(Authentication authentication) {
        LoginUserDto loginUser = (LoginUserDto) authentication.getPrincipal();
        Long loginUserId = loginUser.userId();
        List<BookPurchasedResponseDto> purchasedBooks = bookService.searchPurchasedBook(loginUserId);

        return ResponseEntity.ok(purchasedBooks);
    }

    // 리뷰 등록
    @PostMapping("{bookId}/review")
    public ResponseEntity<String> createReview(@PathVariable("bookId") Long bookId,
                                               @RequestBody BookReviewRequestDto bookReviewRequestDto,
                                               Authentication authentication) {
        LoginUserDto loginUser = (LoginUserDto) authentication.getPrincipal();
        Long loginUserId = loginUser.userId();
        bookService.createReview(loginUserId, bookId, bookReviewRequestDto);

        return ResponseEntity.ok("리뷰가 등록되었습니다.");
    }

    // 책에 남겨진 리뷰 조회
    @GetMapping("{bookId}/review")
    public ResponseEntity<List<BookReviewResponseDto>> searchReviews(@PathVariable("bookId") Long bookId) {
        List<BookReviewResponseDto> bookReviews = bookService.searchReviews(bookId);

        return ResponseEntity.ok(bookReviews);
    }

}
