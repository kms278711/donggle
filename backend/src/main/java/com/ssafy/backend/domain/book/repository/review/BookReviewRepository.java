package com.ssafy.backend.domain.book.repository.review;

import com.ssafy.backend.domain.book.dto.response.BookReviewResponseDto;
import com.ssafy.backend.domain.book.entity.BookReview;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookReviewRepository extends JpaRepository<BookReview, Long>, BookReviewCustomRepository{
    List<BookReviewResponseDto> findByBook_bookId(Long bookId);
}
