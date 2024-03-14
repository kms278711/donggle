package com.ssafy.backend.domain.book.repository.bookpage;

import com.ssafy.backend.domain.book.entity.BookPage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookPageRepository extends JpaRepository<BookPage, Long>, BookPageCustomRespository{

}
