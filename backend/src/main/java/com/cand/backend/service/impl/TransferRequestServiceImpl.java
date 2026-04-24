package com.cand.backend.service.impl;

import com.cand.backend.dto.TransferRequestDto;
import com.cand.backend.entity.TransferRequest;
import com.cand.backend.entity.TransferStatus;
import com.cand.backend.entity.Unit;
import com.cand.backend.entity.User;
import com.cand.backend.entity.UserUnitHistory;
import com.cand.backend.repository.TransferRequestRepository;
import com.cand.backend.repository.UserRepository;
import com.cand.backend.repository.UnitRepository;
import com.cand.backend.repository.UserUnitHistoryRepository;
import com.cand.backend.service.TransferRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TransferRequestServiceImpl implements TransferRequestService {

        private final TransferRequestRepository transferRepository;
        private final UserRepository userRepository;
        private final UnitRepository unitRepository;
        private final UserUnitHistoryRepository historyRepository;

        @Override
        @Transactional
        public TransferRequest submitRequest(TransferRequestDto requestDto) {
                User user = userRepository.findById(requestDto.getUserId())
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy đoàn viên"));

                Unit toUnit = unitRepository.findById(requestDto.getToUnitId())
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn vị đích"));

                TransferRequest request = TransferRequest.builder()
                                .user(user)
                                .fromUnit(user.getUnit())
                                .toUnit(toUnit)
                                .reason(requestDto.getReason())
                                .documentUrl(requestDto.getDocumentUrl())
                                .status(TransferStatus.PENDING)
                                .requestTime(LocalDateTime.now())
                                .build();

                return transferRepository.save(request);
        }

        @Override
        @Transactional
        public TransferRequest approveBySource(Long requestId, UUID approverId) {
                TransferRequest request = transferRepository.findById(requestId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu"));

                User approver = userRepository.findById(approverId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy người duyệt"));

                if (request.getStatus() != TransferStatus.PENDING) {
                        throw new RuntimeException("Trạng thái không hợp lệ để duyệt");
                }

                request.setStatus(TransferStatus.SOURCE_APPROVED);
                request.setApproverSource(approver);
                return transferRepository.save(request);
        }

        @Override
        @Transactional
        public TransferRequest approveByDestination(Long requestId, UUID approverId) {
                TransferRequest request = transferRepository.findById(requestId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu"));

                User approver = userRepository.findById(approverId)
                                .orElseThrow(() -> new RuntimeException("Không tìm thấy người duyệt"));

                if (request.getStatus() != TransferStatus.SOURCE_APPROVED) {
                        throw new RuntimeException("Cần đơn vị đi duyệt trước");
                }

                // Cập nhật trạng thái yêu cầu
                request.setStatus(TransferStatus.DESTINATION_APPROVED);
                request.setApproverDestination(approver);
                request.setCompletionTime(LocalDateTime.now());

                // Cập nhật đơn vị mới cho đoàn viên (User)
                User user = request.getUser();
                Unit oldUnit = user.getUnit();
                user.setUnit(request.getToUnit());
                userRepository.save(user);

                // Lưu vết vào Lịch sử đơn vị (UserUnitHistory) theo đúng DBML
                UserUnitHistory history = UserUnitHistory.builder()
                                .user(user)
                                .unit(request.getToUnit())
                                .transferRequest(request)
                                .assignmentType("CHUYEN_SINH_HOAT")
                                .startDate(LocalDateTime.now())
                                .build();
                historyRepository.save(history);

                return transferRepository.save(request);
        }

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
