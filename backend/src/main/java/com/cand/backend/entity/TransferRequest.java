package com.cand.backend.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "Yeu_cau_chuyen_sinh_hoat")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TransferRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tu_don_vi_id", nullable = false)
    private Unit fromUnit;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "den_don_vi_id", nullable = false)
    private Unit toUnit;

    @Enumerated(EnumType.STRING)
    @Column(name = "trang_thai", length = 50, nullable = false)
    @Builder.Default
    private TransferStatus status = TransferStatus.PENDING;

    @Column(name = "ly_do", columnDefinition = "TEXT")
    private String reason;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nguoi_duyet_don_vi_id")
    private User approverSource;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nguoi_duyet_den_don_vi_id")
    private User approverDestination;

    @Column(name = "ly_do_tu_choi", columnDefinition = "TEXT")
    private String rejectionReason;

    @Column(name = "gui_yeu_cau_luc")
    private LocalDateTime requestTime;

    @Column(name = "hoan_tat_luc")
    private LocalDateTime completionTime;

    @CreationTimestamp
    @Column(name = "tao_luc", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "cap_nhat_luc")
    private LocalDateTime updatedAt;

    @Column(name = "xoa_luc")
    private LocalDateTime deletedAt;

    @Column(name = "file_minh_chung")
    private String documentUrl;
}
