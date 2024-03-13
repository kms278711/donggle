package com.ssafy.backend.domain.book.repository;

import com.ssafy.backend.domain.book.entity.BookReview;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookReviewRepository extends JpaRepository<BookReview, Long> {
}
