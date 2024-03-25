package com.ssafy.backend.domain.education.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ssafy.backend.domain.book.entity.BookPageSentence;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@ToString
@NoArgsConstructor
public class Education {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long educationId;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private Gubun gubun;

	@Enumerated(EnumType.STRING)
	@Column(nullable = true)
	private Category category;

	private String wordName;

	private String imagePath;

	@JsonIgnore
	@OneToOne
	@JoinColumn(name = "book_page_sentence_id")
	private BookPageSentence bookPageSentence;


	public enum Gubun {
		WORD,
		NOWORD
	}

	public enum Category {
		PICTURE,
		ACTION,
		EXPRESSION
	}
}
