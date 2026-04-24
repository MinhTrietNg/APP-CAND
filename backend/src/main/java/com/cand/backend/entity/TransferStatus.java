package com.cand.backend.model;

public enum TransferStatus {
    PENDING, // Đang chờ phê duyệt
    SOURCE_APPROVED, // Đơn vị đi đã duyệt
    DESTINATION_APPROVED, // Đơn vị đến đã duyệt (Hoàn tất)
    REJECTED // Đã từ chối
}
