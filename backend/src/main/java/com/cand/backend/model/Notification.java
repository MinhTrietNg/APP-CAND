package com.cand.backend.model;

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
@Table(name = "Thong_bao")
@Getter
@Setter
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "tieu_de", nullable = false)
    private String title;

    @Column(name = "noi_dung", columnDefinition = "TEXT")
    private String content;

    @Column(name = "nguoi_gui_id", nullable = false)
    private UUID senderId;

    @Column(name = "don_vi_nhan_id")
    private Long recipientUnitId;

    @Column(name = "muc_do_uu_tien", length = 20)
    private String priority; // Khẩn cấp / Bình thường

    @Column(name = "tao_luc")
    private LocalDateTime createdAt;

    @Column(name = "cap_nhat_luc")
    private LocalDateTime updatedAt;

    @Column(name = "xoa_luc")
    private LocalDateTime deletedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
}
