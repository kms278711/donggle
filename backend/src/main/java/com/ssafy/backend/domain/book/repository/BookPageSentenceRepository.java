package com.ssafy.backend.domain.book.repository;

import com.ssafy.backend.domain.book.entity.BookPage;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookPageSentenceRepository extends JpaRepository<BookPageSentence, Long> {

}
