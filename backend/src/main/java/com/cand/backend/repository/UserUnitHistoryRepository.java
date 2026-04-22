package com.cand.backend.repository;

import com.cand.backend.entity.UserUnitHistory;
import com.cand.backend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserUnitHistoryRepository extends JpaRepository<UserUnitHistory, Long> {
    List<UserUnitHistory> findByUser(User user);
}
