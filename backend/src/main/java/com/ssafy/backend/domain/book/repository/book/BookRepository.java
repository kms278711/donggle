package com.ssafy.backend.domain.book.repository.book;

import com.ssafy.backend.domain.book.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long>, BookCustomRepository{

}
