package com.ssafy.backend.domain.book.repository.bookpage;

import com.ssafy.backend.domain.book.dto.BookPageDto;
import com.ssafy.backend.domain.book.dto.BookPageSentenceDto;
import com.ssafy.backend.domain.book.entity.BookPage;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import com.ssafy.backend.domain.education.entity.Education;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookPageCustomRespository {

    BookPage findByBookPage(Long bookId, int bookPage);

    List<BookPageSentence> findByBookPageId(Long bookPageId);

    Education findByBookSentenceId(List<Long> bookPageSentenceId);


}
