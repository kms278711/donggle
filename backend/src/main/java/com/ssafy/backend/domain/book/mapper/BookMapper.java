package com.ssafy.backend.domain.book.mapper;

import com.ssafy.backend.domain.book.dto.*;
import com.ssafy.backend.domain.book.dto.request.BookReviewRequestDto;
import com.ssafy.backend.domain.book.dto.response.BookProcessDto;
import com.ssafy.backend.domain.book.dto.response.BookPurchasedResponseDto;
import com.ssafy.backend.domain.book.dto.response.BookReviewResponseDto;
import com.ssafy.backend.domain.book.entity.*;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BookMapper {

    BookDto toBookDto(Book book);
    BookInfoDto toBookInfoDto(Book book);
    BookPageDto toBookPageDto(BookPage bookPage);
    BookPageSentenceDto toBookPageSentenceDto(BookPageSentence bookPageSentence);
    BookReview toBookReview(BookReviewRequestDto bookReviewRequestDto);
    BookReviewResponseDto toBookResponseDto(BookReview bookReview);
    @Mapping(source = "userBookProcess.book.bookId", target = "bookId")
    @Mapping(source = "userBookProcess.book.title", target = "title")
    @Mapping(source = "userBookProcess.book.coverPath", target = "coverPath")
    UserBookProcessDto toUserBookProcessDto(UserBookProcess userBookProcess);
    BookProcessDto toBookPurchasedgDto(BookPurchasedLearning bookPurchasedLearning);
}
