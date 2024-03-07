package com.ssafy.backend.domain.user.entity;

import com.ssafy.backend.global.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.boot.context.properties.bind.DefaultValue;

@Entity
@Getter
@ToString
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class User extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Column(unique = true, updatable = false, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    private String name;

    private String nickname;

    private String profileImage;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)

    private Status status;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    public enum Status {
        MEMBER,
        WITHDRAWAL
    }

    public enum Role {
        USER,
        ADMIN
    }

    public void updatePassword(String password) {
        this.password = password;
    }

    public void updateNickname(String nickname) {
        this.nickname = nickname;
    }

    public void updateStatus(Status status) { this.status = status; }

    public void updateName(String name) {
        this.name = name;
    }

    public void updateProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

}

