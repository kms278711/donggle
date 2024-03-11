package com.ssafy.backend.domain.book.service;

import com.ssafy.backend.domain.book.dto.BookDto;

import java.util.List;

public interface BookService {

    List<BookDto> searchAllBook();
    BookDto searchBook(Long bookId);
}
