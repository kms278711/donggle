package com.ssafy.backend.domain.book.entity;

import com.ssafy.backend.domain.user.entity.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@IdClass(ProgressBookId.class)
public class BookReview {

    @Id
    @JoinColumn(name = "user_id")
    @ManyToOne
    private User user;

    @Id
    @JoinColumn(name = "book_id")
    @ManyToOne
    private Book book;

    private int score;

    private String content;

    @Builder
    public BookReview(User user, Book book, int score, String content) {
        this.user = user;
        this.book = book;
        this.score = score;
        this.content = content;
    }
}
