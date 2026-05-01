package com.cand.backend.repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cand.backend.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    Optional<User> findByUsername(String username);

    Optional<User> findByEmail(String email);

    // Kiểm tra xem email đã tồn tại hay chưa (dùng cho lúc đăng ký)
    boolean existsByEmail(String email);

    // @Query("SELECT n.id FROM Nguoi_Dung n WHERE n.don_vi_id = :donViId AND
    // n.trangThai = 'ACTIVE'")
    // List<UUID> findIdByDonViId(@Param("donViId") Long donViId);
}