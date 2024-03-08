package com.ssafy.backend.domain.book.service.impl;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.mapper.BookMapper;
import com.ssafy.backend.domain.book.repository.BookRepository;
import com.ssafy.backend.domain.book.service.BookService;
import com.ssafy.backend.global.error.exception.UserException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.ssafy.backend.global.error.exception.ExceptionType.NOT_FOUND_BOOK;


@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

    private final BookRepository bookRepository;
    private final BookMapper bookMapper;

    // 책 정보 전체 조회
    @Override
    @Transactional
    public List<BookDto> searchAllBook() {
        List<Book> books = bookRepository.findAll();
        List<BookDto> bookDtoList = books.stream()
                .map(bookMapper::toBookDto)
                .toList();

        return bookDtoList;
    }

    @Override
    @Transactional
    public BookDto searchBook(Long bookId) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new UserException(NOT_FOUND_BOOK));
        BookDto bookDto = bookMapper.toBookDto(book);

        return bookDto;
    }
}
