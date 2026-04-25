package com.cand.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "Don_vi")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Unit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "ten_don_vi", nullable = false, length = 255)
    private String unitName;

    @Column(name = "ma_don_vi", unique = true, nullable = false, length = 100)
    private String unitCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "don_vi_cha_id")
    private Unit parentUnit;

    @Column(name = "cap_don_vi", nullable = false, length = 50)
    private String unitLevel;

    @Column(name = "trang_thai", nullable = false, length = 50)
    private String status;

    @CreationTimestamp
    @Column(name = "tao_luc", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "cap_nhat_luc", nullable = false)
    private LocalDateTime updatedAt;

    @Column(name = "xoa_luc")
    private LocalDateTime deletedAt;
}
