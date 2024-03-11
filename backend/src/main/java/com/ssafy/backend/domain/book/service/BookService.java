package com.ssafy.backend.domain.book.service;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.BookPageSentenceDto;

import java.util.List;

public interface BookService {

    List<BookDto> searchAllBook();
    BookDto searchBook(Long bookId);
    BookPageDto searchBookPage(Long bookId, int page);

}
