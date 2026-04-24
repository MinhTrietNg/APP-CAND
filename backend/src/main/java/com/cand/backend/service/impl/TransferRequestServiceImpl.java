package com.cand.backend.service.impl;

import com.cand.backend.dto.TransferRequestDto;
import com.cand.backend.model.TransferRequest;
import com.cand.backend.model.TransferStatus;
import com.cand.backend.model.Unit;
import com.cand.backend.model.User;
import com.cand.backend.repository.TransferRequestRepository;
import com.cand.backend.repository.UserRepository;
import com.cand.backend.repository.UnitRepository;
import com.cand.backend.service.TransferRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TransferRequestServiceImpl implements TransferRequestService {

    private final TransferRequestRepository transferRepository;
    private final UserRepository userRepository;
    private final UnitRepository unitRepository;

    @Override
    @Transactional
    public TransferRequest submitRequest(TransferRequestDto requestDto) {
        // Mapping từ DTO sang Entity
        User user = userRepository.findById(requestDto.getUserId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đoàn viên"));

        Unit toUnit = unitRepository.findById(requestDto.getToUnitId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn vị đích"));
        // Tạo yêu cầu chuyển sinh hoạt
        TransferRequest request = TransferRequest.builder()
                .user(user)
                .fromUnit(user.getUnit())
                .toUnit(toUnit)
                .reason(requestDto.getReason())
                .status(TransferStatus.PENDING)
                .requestTime(LocalDateTime.now())
                .build();

        return transferRepository.save(request);
    }

    @Override
    @Transactional
    // Đơn vị đi phê duyệt (Cấp 1)
    public TransferRequest approveBySource(Long requestId, User approver) {
        TransferRequest request = transferRepository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu"));

        if (request.getStatus() != TransferStatus.PENDING) {
            throw new RuntimeException("Trạng thái không hợp lệ để duyệt");
        }
        // Đơn vị đi phê duyệt
        request.setStatus(TransferStatus.SOURCE_APPROVED);
        request.setApproverSource(approver);
        return transferRepository.save(request);
    }

    @Override
    @Transactional
    // Đơn vị đến phê duyệt (Cấp 2 -> Hoàn tất)
    public TransferRequest approveByDestination(Long requestId, User approver) {
        TransferRequest request = transferRepository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu"));

        if (request.getStatus() != TransferStatus.SOURCE_APPROVED) {
            throw new RuntimeException("Cần đơn vị đi duyệt trước");
        }

        request.setStatus(TransferStatus.DESTINATION_APPROVED);
        request.setApproverDestination(approver);
        request.setCompletionTime(LocalDateTime.now());

        User user = request.getUser();
        user.setUnit(request.getToUnit());
        userRepository.save(user);

        return transferRepository.save(request);
    }

    // Từ chối yêu cầu
    @Override
    @Transactional
    public TransferRequest rejectRequest(Long requestId, String reason) {
        TransferRequest request = transferRepository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu"));

        request.setStatus(TransferStatus.REJECTED);
        request.setRejectionReason(reason);
        return transferRepository.save(request);
    }

    @Override
    public List<TransferRequest> getAllRequests() {
        return transferRepository.findAll();
    }
}
