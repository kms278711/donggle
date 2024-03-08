package com.ssafy.backend.domain.book.controller;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/books")
@RequiredArgsConstructor
public class BookController {

    private final BookService bookService;

    @GetMapping
    public ResponseEntity<List<BookDto>> searchAllBook() {
        List<BookDto> bookList = bookService.searchAllbook();

        return ResponseEntity.ok(bookList);
    }

}
