package com.ssafy.backend.domain.book.repository.book;

import com.ssafy.backend.domain.book.dto.BookDto;

public interface BookCustomRepository {
    BookDto purchasedBookInfo(Long bookId, Long loginUSerId);
}
