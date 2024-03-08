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
public class Book extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookId;

    @Column(nullable = false)
    private String title;

    private String summary;

    @Column(nullable = false)
    private String path;

    @Column(nullable = false)
    private int price;

}
