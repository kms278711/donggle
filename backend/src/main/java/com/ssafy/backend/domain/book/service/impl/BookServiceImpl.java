package com.ssafy.backend.domain.book.service.impl;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.mapper.BookMapper;
import com.ssafy.backend.domain.book.repository.BookRepository;
import com.ssafy.backend.domain.book.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

    private final BookRepository bookRepository;
    private final BookMapper bookMapper;

    @Transactional
    public List<BookDto> searchAllbook() {
        List<Book> books = bookRepository.findAll();
        List<BookDto> bookDtoList = books.stream()
                .map(bookMapper::toBookDto)
                .toList();

        return bookDtoList;
    }

}
