package com.ssafy.backend.domain.book.repository.bookpage;

import com.ssafy.backend.domain.book.entity.BookPage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookPageRepository extends JpaRepository<BookPage, Long>, BookPageCustomRepository {

}
