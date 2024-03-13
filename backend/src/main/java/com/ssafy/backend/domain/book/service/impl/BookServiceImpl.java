package com.ssafy.backend.domain.book.service.impl;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.dto.BookInfoDto;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.BookPageSentenceDto;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.entity.BookPage;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import com.ssafy.backend.domain.book.entity.UserBookProcess;
import com.ssafy.backend.domain.book.mapper.BookMapper;
import com.ssafy.backend.domain.book.repository.BookPageRepository;
import com.ssafy.backend.domain.book.repository.BookPageSentenceRepository;
import com.ssafy.backend.domain.book.repository.BookRepository;
import com.ssafy.backend.domain.book.repository.UserBookProcessRespository;
import com.ssafy.backend.domain.book.service.BookService;
import com.ssafy.backend.domain.education.dto.EducationDto;
import com.ssafy.backend.domain.education.entity.Education;
import com.ssafy.backend.domain.education.mapper.EducationMapper;
import com.ssafy.backend.domain.user.entity.User;
import com.ssafy.backend.domain.user.repository.UserRepository;
import com.ssafy.backend.global.error.exception.UserException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

import static com.ssafy.backend.global.error.exception.ExceptionType.INVALID_USER;
import static com.ssafy.backend.global.error.exception.ExceptionType.NOT_FOUND_BOOK;



@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

    private final BookRepository bookRepository;
    private final BookPageRepository bookPageRepository;
    private final BookPageSentenceRepository bookPageSentenceRepository;
    private final BookMapper bookMapper;
    private final EducationMapper educationMapper;
    private final UserBookProcessRespository userBookProcessRespository;
    private final UserRepository userRepository;

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

    @Override
    @Transactional
    public BookPageDto searchBookPage(Long bookId, int page) {
        BookPage bookPage = bookPageRepository.findByBookPage(bookId, page);
        List<BookPageSentence> sentences = bookPageRepository.findByBookPageId(bookPage.getBookPageId());
        List<BookPageSentenceDto> sentenceDtos = sentences.stream()
                .map(bookMapper::toBookPageSentenceDto)
                .toList();
        List<Long> bookPageSentenceIds = sentences.stream()
                .map(BookPageSentence::getBookPageSentenceId)
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

    @Override
    public BookInfoDto searchBookInfo(Long bookId, Long loginUserId) {
        UserBookProcess bookProcess = userBookProcessRespository.findByUser_userIdAndBook_bookId(loginUserId, bookId)
                .orElseThrow(() -> new UserException(NOT_FOUND_BOOK));
        System.out.println("bookProcess : " + bookProcess);
        System.out.println("bookId : " + bookId + ", loginUserId : " + loginUserId);
        List<BookPage> pages = userBookProcessRespository.findByBookId(bookId);
        List<Long> pageIds = pages.stream().map(BookPage::getBookPageId)
                .collect(Collectors.toList());

        List<BookPageSentence> sentences = userBookProcessRespository.findByBookPageId(pageIds);
        List<Long> sentenceIds = sentences.stream().map(BookPageSentence::getBookPageSentenceId)
                .collect(Collectors.toList());

        List<Education> educations = userBookProcessRespository.findByBookSentenceId(sentenceIds);
        List<EducationDto> educationDtos = educations.stream()
                .map(educationMapper::toEducationDto)
                .toList();

        return BookInfoDto.builder()
                .bookId(bookProcess.getBook().getBookId())
                .title(bookProcess.getBook().getTitle())
                .coverImagePath(bookProcess.getBook().getCoverPath())
                .page(bookProcess.getPage())
                .educations(educationDtos)
                .build();
    }

    @Override
    @Transactional
    public void saveProgressBookPage(Long loginUserId, Long bookId, int page) {
        User userId = userRepository.findById(loginUserId)
                .orElseThrow(() -> new UserException(INVALID_USER));
        Book processbookId = bookRepository.findById(bookId).orElseThrow(() -> new UserException(NOT_FOUND_BOOK));
        UserBookProcess bookProcess = UserBookProcess.builder()
                .user(userId)
                .book(processbookId)
                .page(page)
                .build();

        userBookProcessRespository.save(bookProcess);
    }


}
