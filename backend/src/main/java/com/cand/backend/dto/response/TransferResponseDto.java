package com.cand.backend.dto.response;

import com.cand.backend.entity.TransferStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Data Transfer Object trả về kết quả yêu cầu chuyển sinh hoạt.
 * Chỉ chứa các thông tin cần thiết cho Frontend, không bao gồm thông tin nhạy cảm.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TransferResponseDto {
    
    private Long id;
    
    private UUID userId;
    
    /** Tên đầy đủ của đoàn viên (Họ + Tên) */
    private String userName;
    
    /** Tên đơn vị hiện tại/đơn vị đi */
    private String fromUnitName;
    
    /** Tên đơn vị muốn đến */
    private String toUnitName;
    
    /** Trạng thái hiện tại của đơn (PENDING, APPROVED, REJECTED...) */
    private TransferStatus status;
    
    private String reason;
    
    private String rejectionReason;
    
    private LocalDateTime requestTime;
    
    private LocalDateTime completionTime;
    
    private String documentUrl;
}
