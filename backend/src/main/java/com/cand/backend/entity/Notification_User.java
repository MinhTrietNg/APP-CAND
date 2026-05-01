package com.cand.backend.entity;

import java.time.LocalDateTime;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "thong_bao_nguoi_dung")
@Getter
@Setter
public class Notification_User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nguoi_dung_id", nullable = false)
    private UUID userId;

    @Column(name = "thong_bao_id", nullable = false)
    private Long notificationId;

    @Column(name = "da_doc", nullable = false)
    private Boolean isRead = false;

    @Column(name = "doc_luc")
    private LocalDateTime readAt;

    @Column(name = "tao_luc")
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
