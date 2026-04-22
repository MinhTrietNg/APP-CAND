package com.cand.backend.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "Lich_su_don_vi_nguoi_dung")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserUnitHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "don_vi_id", nullable = false)
    private Unit unit;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "yeu_cau_chuyen_id")
    private TransferRequest transferRequest;

    @Column(name = "loai_phan_cong", length = 50)
    private String assignmentType;

    @Column(name = "ghi_chu", columnDefinition = "TEXT")
    private String note;

    @Column(name = "bat_dau_luc")
    private LocalDateTime startDate;

    @Column(name = "ket_thuc_luc")
    private LocalDateTime endDate;

    @CreationTimestamp
    @Column(name = "tao_luc", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "cap_nhat_luc")
    private LocalDateTime updatedAt;
}
