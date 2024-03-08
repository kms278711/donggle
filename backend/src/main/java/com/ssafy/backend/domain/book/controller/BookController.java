package com.ssafy.backend.domain.book.controller;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/books")
@RequiredArgsConstructor
public class BookController {

    private final BookService bookService;

    // 책 목록 전체 조회
    @GetMapping
    public ResponseEntity<List<BookDto>> searchAllBook() {
        List<BookDto> bookList = bookService.searchAllBook();

        return ResponseEntity.ok(bookList);
    }

    // 책 단일 조회
    @GetMapping("/{bookId}")
    public ResponseEntity<BookDto> searchBook(@PathVariable("bookId") Long bookId) {
        BookDto bookDto = bookService.searchBook(bookId);

        return ResponseEntity.ok(bookDto);
    }
}
