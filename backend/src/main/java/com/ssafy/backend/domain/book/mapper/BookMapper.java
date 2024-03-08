package com.ssafy.backend.domain.book.mapper;

import com.ssafy.backend.domain.book.dto.BookDto;
import com.ssafy.backend.domain.book.entity.Book;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BookMapper {

    BookDto toBookDto(Book book);

}
