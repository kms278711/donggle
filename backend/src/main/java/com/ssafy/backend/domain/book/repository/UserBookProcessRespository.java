package com.ssafy.backend.domain.book.repository;

import com.ssafy.backend.domain.book.entity.UserBookProcess;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserBookProcessRespository extends JpaRepository<UserBookProcess, Long>, UserBookProcessCustomRepository{
    Optional<UserBookProcess> findByUser_userIdAndBook_bookId(Long userId, Long bookId);
    List<UserBookProcess> findByUser_userId(Long userId);

}
