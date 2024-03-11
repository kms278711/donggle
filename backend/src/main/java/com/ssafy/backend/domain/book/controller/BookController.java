package com.ssafy.backend.domain.book.controller;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.BookPageSentenceDto;
import com.ssafy.backend.domain.book.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<List<BookDto>> searchAllBook(@RequestParam(required = false) Long userId) {
        List<BookDto> bookList = bookService.searchAllBook();

        return ResponseEntity.ok(bookList);
    }

    // 구매한 책 목록 전체 조회

    // 책 단일 조회
    @GetMapping("/{bookId}")
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

}
