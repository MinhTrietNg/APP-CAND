package com.cand.backend.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cand.backend.model.Notification_User;

@Repository
public interface Notification_UserRepository extends JpaRepository<Notification_User, Long> {
    List<Notification_User> findByUserIdAndReadFalseOrderByCreatedAtDesc(UUID userId);

    Notification_User findByUserIdAndNotificationId(UUID userId, Long notificationId);
}
