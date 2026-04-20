package com.cand.backend.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cand.backend.model.Notification;
import com.cand.backend.service.NotificationService;

@RestController
@RequestMapping("/api/v1/notifications")
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    // API dành cho Cán bộ / Đoàn viên để phát hành thông báo
    @PostMapping("/publish")
    public ResponseEntity<?> publishNotification(@RequestBody Notification notification) {
        // Trong thực tế, nguoiGuiId nên được trích xuất từ JWT Security Context
        // UUID currentUser = SecurityUtils.getCurrentUserId();
        // request.setNguoiGuiId(currentUser);
        Notification newNotification = notificationService.publishNotification(notification);
        return ResponseEntity.ok(newNotification);
    }

    // API dành cho Đoàn viên để lấy hòm thư thông báo của mình
    @PostMapping("/inbox")
    public ResponseEntity<?> getInbox(@RequestAttribute("userId") UUID userId) {
        // Trong thực tế, userId nên được trích xuất từ JWT Security Context
        // UUID userId = SecurityUtils.getCurrentUserId();
        return ResponseEntity.ok(notificationService.getInbox(userId));
    }

    // API để đánh dấu thông báo đã đọc
    @PostMapping("/{notificationId}/mark-as-read")
    public ResponseEntity<?> markAsRead(@PathVariable Long notificationId, @RequestAttribute("userId") UUID userId) {
        // Trong thực tế, userId nên được trích xuất từ JWT Security Context
        // UUID userId = SecurityUtils.getCurrentUserId();
        notificationService.markAsRead(userId, notificationId);
        return ResponseEntity.ok("Thông báo đã được đánh dấu là đã đọc");
    }
}
