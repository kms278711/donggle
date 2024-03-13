package com.ssafy.backend.domain.book.mapper;

import com.ssafy.backend.domain.book.dto.*;
import com.ssafy.backend.domain.book.entity.*;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BookMapper {

    BookDto toBookDto(Book book);
    BookInfoDto toBookInfoDto(Book book);
    BookPageDto toBookPageDto(BookPage bookPage);
    BookPageSentenceDto toBookPageSentenceDto(BookPageSentence bookPageSentence);
    BookReview toBookReview(BookReviewRequestDto bookReviewRequestDto);
    BookReviewResponseDto toBookResponseDto(BookReview bookReview);
    UserBookProcessDto toUserBookProcessDto(UserBookProcess userBookProcess);
    BookPurchasedLearningDto toBookPurchasedLearningDto(BookPurchasedLearning bookPurchasedLearning);
}
