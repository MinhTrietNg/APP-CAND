package com.cand.backend.service;

import com.cand.backend.dto.TransferRequestDto;
import com.cand.backend.entity.TransferRequest;
import com.cand.backend.entity.User;
import java.util.List;
import java.util.UUID;

public interface TransferRequestService {
    
    // Gửi yêu cầu mới
    TransferRequest submitRequest(TransferRequestDto requestDto);
    
    // Đơn vị đi phê duyệt
    TransferRequest approveBySource(Long requestId, UUID approverId);
    
    // Đơn vị đến phê duyệt (Hoàn tất)
    TransferRequest approveByDestination(Long requestId, UUID approverId);
    
    // Từ chối yêu cầu
    TransferRequest rejectRequest(Long requestId, String reason);
    
    // Lấy danh sách yêu cầu
    List<TransferRequest> getAllRequests();
}
