package com.ssafy.backend.domain.book.entity;

import com.ssafy.backend.global.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

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

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "book_id")
    private Book book;

    
}
