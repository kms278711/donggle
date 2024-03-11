package com.ssafy.backend.domain.book.service.impl;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.BookPageSentenceDto;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.entity.BookPage;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import com.ssafy.backend.domain.book.mapper.BookMapper;
import com.ssafy.backend.domain.book.repository.BookPageCustomRespository;
import com.ssafy.backend.domain.book.repository.BookPageRepository;
import com.ssafy.backend.domain.book.repository.BookPageSentenceRepository;
import com.ssafy.backend.domain.book.repository.BookRepository;
import com.ssafy.backend.domain.book.service.BookService;
import com.ssafy.backend.domain.education.dto.EducationDto;
import com.ssafy.backend.domain.education.entity.Education;
import com.ssafy.backend.domain.education.mapper.EducationMapper;
import com.ssafy.backend.global.error.exception.UserException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

import static com.ssafy.backend.global.error.exception.ExceptionType.NOT_FOUND_BOOK;
import static com.ssafy.backend.global.error.exception.ExceptionType.NOT_FOUND_BOOKPAGE;


@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

    private final BookRepository bookRepository;
    private final BookPageRepository bookPageRepository;
    private final BookPageSentenceRepository bookPageSentenceRepository;
//    private final BookPageCustomRespository bookPageCustomRespository;
    private final BookMapper bookMapper;
    private final EducationMapper educationMapper;

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


    public BookPageDto searchBookPage(Long bookId, int page) {
        BookPage bookPage = bookPageRepository.findByBookPage(bookId, page);
        List<BookPageSentence> sentences = bookPageRepository.findByBookPageId(bookPage.getBookPageId());
        List<BookPageSentenceDto> sentenceDtos = sentences.stream()
                .map(bookMapper::toBookPageSentenceDto)
                .toList();
        List<Long> bookPageSentenceIds = sentences.stream().map(BookPageSentence::getBookPageSentenceId)
                .collect(Collectors.toList());
        Education education = bookPageRepository.findByBookSentenceId(bookPageSentenceIds);
        EducationDto educationDto = educationMapper.toEducationDto(education);
        return BookPageDto.builder()
                .bookPageId(bookPage.getBookPageId())
                .bookImagePath(bookPage.getBookImagePath())
                .page(bookPage.getPage())
                .content(bookPage.getContent())
                .bookPageSentences(sentenceDtos)
                .education(educationDto)
                .build();
    }

}
