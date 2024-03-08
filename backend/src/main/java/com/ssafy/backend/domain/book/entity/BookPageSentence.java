package com.ssafy.backend.domain.book.entity;

import com.ssafy.backend.global.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BookPageSentence extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookPageSentenceId;

    private int sequence;

    private String sentence;

    private String sentenceSoundPath;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "book_page_id")
    private BookPage bookPage;

}
