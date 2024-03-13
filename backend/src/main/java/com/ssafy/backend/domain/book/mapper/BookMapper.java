package com.ssafy.backend.domain.book.mapper;

import com.ssafy.backend.domain.book.dto.*;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.entity.BookPage;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import com.ssafy.backend.domain.book.entity.BookReview;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BookMapper {

    BookDto toBookDto(Book book);
    BookInfoDto toBookInfoDto(Book book);
    BookPageDto toBookPageDto(BookPage bookPage);
    BookPageSentenceDto toBookPageSentenceDto(BookPageSentence bookPageSentence);
    BookReview toBookReview(BookReviewRequestDto bookReviewRequestDto);
    BookReviewResponseDto toBookResponseDto(BookReview bookReview);
}
