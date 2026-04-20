package com.cand.backend.repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cand.backend.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
    // Tìm kiếm người dùng bằng email để kiểm tra đăng nhập
    Optional<User> findByEmail(String email);

    // Kiểm tra xem email đã tồn tại hay chưa (dùng cho lúc đăng ký)
    Boolean existsByEmail(String email);

    @Query("SELECT n.id FROM NguoiDung n WHERE n.donViId = :donViId AND n.trangThai = 'ACTIVE'")
    List<UUID> findIdByDonViId(@Param("donViId") Long donViId);
}
