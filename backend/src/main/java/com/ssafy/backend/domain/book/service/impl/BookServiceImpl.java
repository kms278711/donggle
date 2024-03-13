package com.ssafy.backend.domain.book.service.impl;

import com.ssafy.backend.domain.book.dto.*;
import com.ssafy.backend.domain.book.entity.*;
import com.ssafy.backend.domain.book.mapper.BookMapper;
import com.ssafy.backend.domain.book.repository.*;
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
    private final BookReviewRepository bookReviewRepository;


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
        // bookId와 page를 통해 bookPage 조회
        BookPage bookPage = bookPageRepository.findByBookPage(bookId, page);

        // bookPageId를 통해 sentence 조회, Dto 변환 후 sentenceId 리스트로 저장
        List<BookPageSentence> sentences = bookPageRepository.findByBookPageId(bookPage.getBookPageId());
        List<BookPageSentenceDto> sentenceDtos = sentences.stream()
                .map(bookMapper::toBookPageSentenceDto)
                .toList();
        List<Long> bookPageSentenceIds = sentences.stream()
                .map(BookPageSentence::getBookPageSentenceId)
                .collect(Collectors.toList());

        // sentenceId를 이용해 education 조회 후 Dto로 변환
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
        // bookId를 이용해 책 검색
        UserBookProcess bookProcess = userBookProcessRespository.findByUser_userIdAndBook_bookId(loginUserId, bookId)
                .orElseThrow(() -> new UserException(NOT_FOUND_BOOK));

        // bookId를 이용해 page 조회 후 pageId 리스트로 저장
        List<BookPage> pages = userBookProcessRespository.findByBookId(bookId);
        List<Long> pageIds = pages.stream().map(BookPage::getBookPageId)
                .collect(Collectors.toList());

        // pageId를 이용해 sentences 조회 후 sentenceId 리스트로 저장
        List<BookPageSentence> sentences = userBookProcessRespository.findByBookPageId(pageIds);
        List<Long> sentenceIds = sentences.stream().map(BookPageSentence::getBookPageSentenceId)
                .collect(Collectors.toList());

        // sentenceId를 이용해 education 조회 후 Dto로 변환
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
        // userId 와 bookId를 이용해 로그인한 유저와 읽고 있는 책 조회
        User userId = userRepository.findById(loginUserId)
                .orElseThrow(() -> new UserException(INVALID_USER));
        Book processbookId = bookRepository.findById(bookId)
                .orElseThrow(() -> new UserException(NOT_FOUND_BOOK));

        UserBookProcess bookProcess = UserBookProcess.builder()
                .user(userId)
                .book(processbookId)
                .page(page)
                .build();

        // 읽은 페이지 저장
        userBookProcessRespository.save(bookProcess);
    }

    @Override
    @Transactional
    public void createReview(Long loginUserId, Long bookId, BookReviewRequestDto bookReviewRequestDto) {
        System.out.println("loginUserId : " + loginUserId + ", bookId : " + bookId);
        System.out.println("bookReviewDto : " + bookReviewRequestDto);

        User userId = userRepository.findById(loginUserId)
                .orElseThrow(() -> new UserException(INVALID_USER));
        System.out.println("userId : " + userId);
        
        try {
            Book reviewBookId = bookRepository.findById(bookId)
                    .orElseThrow(() -> new UserException(NOT_FOUND_BOOK));
            System.out.println("reviewBookId : " + reviewBookId);



            BookReview bookReview = BookReview.builder()
                    .user(userId)
                    .book(reviewBookId)
                    .score(bookReviewRequestDto.score())
                    .content(bookReviewRequestDto.content())
                    .build();

            bookReviewRepository.save(bookReview);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
