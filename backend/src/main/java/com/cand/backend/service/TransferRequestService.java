package com.cand.backend.service;

import com.cand.backend.dto.TransferRequestDto;
import com.cand.backend.model.TransferRequest;
import com.cand.backend.model.User;
import java.util.List;

public interface TransferRequestService {
    
    // Đăng ký các phương thức nghiệp vụ theo chuẩn TSK-008
    TransferRequest submitRequest(TransferRequestDto requestDto);
    
    TransferRequest approveBySource(Long requestId, User approver);
    
    TransferRequest approveByDestination(Long requestId, User approver);
    
    TransferRequest rejectRequest(Long requestId, String reason);
    
    List<TransferRequest> getAllRequests();
}
