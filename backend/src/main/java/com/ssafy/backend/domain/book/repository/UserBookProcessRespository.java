package com.ssafy.backend.domain.book.repository;

import com.ssafy.backend.domain.book.dto.BookInfoDto;
import com.ssafy.backend.domain.book.entity.BookPage;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import com.ssafy.backend.domain.book.entity.UserBookProcess;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserBookProcessRespository extends JpaRepository<UserBookProcess, Long>, UserBookProcessCustomRepository{
    UserBookProcess findByUser_UserIdAndBook_BookId(Long userId, Long bookId);


}
