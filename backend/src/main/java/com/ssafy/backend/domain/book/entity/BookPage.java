package com.ssafy.backend.domain.book.entity;

import com.ssafy.backend.global.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BookPage extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookPageId;

    @Column(nullable = false)
    private String bookImagePath;

    @Column(nullable = false)
    private int page;

    private String content;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "book_id")
    private Book book;

    @OneToMany(mappedBy = "bookPage", cascade = CascadeType.ALL)
    private List<BookPageSentence> bookPageSentences = new ArrayList<>();
}
