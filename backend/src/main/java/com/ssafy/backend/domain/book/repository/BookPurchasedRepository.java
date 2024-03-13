package com.ssafy.backend.domain.book.repository;

import com.ssafy.backend.domain.book.entity.BookPurchasedLearning;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookPurchasedRepository extends JpaRepository<BookPurchasedLearning, Long> {
    List<BookPurchasedLearning> findByUser_userId(Long userId);
}
