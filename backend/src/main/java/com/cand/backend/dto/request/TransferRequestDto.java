package com.cand.backend.dto.request;

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
    
    // ID của đoàn viên 
    private UUID userId;

    // ID đơn vị đích muốn chuyển 
    private Long toUnitId;

    // Lý do chuyển sinh hoạt 
    private String reason;

    // URL minh chứng 
    private String documentUrl;
}