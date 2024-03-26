package com.ssafy.backend.domain.book.repository.bookprocess;

import com.ssafy.backend.domain.book.entity.UserBookProcess;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserBookProcessRespository extends JpaRepository<UserBookProcess, Long>, UserBookProcessCustomRepository{
    List<UserBookProcess> findByUser_userId(Long userId);
    UserBookProcess findByUser_userIdAndBook_bookId(Long userId, Long bookId);
}
