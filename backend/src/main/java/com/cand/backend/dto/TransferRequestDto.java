package com.cand.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TransferRequestDto {
    private UUID userId;        // ID đoàn viên (UUID chuẩn DBML)
    private Long toUnitId;      // ID đơn vị đích
    private String reason;      // Lý do chuyển
    private String documentUrl; // File đính kèm (theo Figma)
}
