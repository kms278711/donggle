package com.ssafy.backend.domain.book.mapper;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.dto.BookInfoDto;
import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.BookPageSentenceDto;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.entity.BookPage;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BookMapper {

    BookDto toBookDto(Book book);
    BookInfoDto toBookInfoDto(Book book);
    BookPageDto toBookPageDto(BookPage bookPage);
    BookPageSentenceDto toBookPageSentenceDto(BookPageSentence bookPageSentence);
}
