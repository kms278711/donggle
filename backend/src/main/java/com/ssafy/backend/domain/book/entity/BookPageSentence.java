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
public class BookPageSentence extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookPageSentenceId;

    private int sequence;

    private String sentence;

    private String sentenceSoundPath;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "book_page_id")
    private BookPage bookPage;

}
