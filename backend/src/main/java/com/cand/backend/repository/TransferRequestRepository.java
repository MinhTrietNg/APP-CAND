package com.cand.backend.repository;

<<<<<<< HEAD
import com.cand.backend.entity.TransferRequest;
import com.cand.backend.entity.User;
=======
import com.cand.backend.model.TransferRequest;
import com.cand.backend.model.User;
import com.cand.backend.model.TransferStatus;
>>>>>>> 3a423e4 (feat: apply MVC architecture with DTO and service implementation for transfer request)
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TransferRequestRepository extends JpaRepository<TransferRequest, Long> {
    List<TransferRequest> findByUser(User user);
<<<<<<< HEAD
=======

    List<TransferRequest> findByStatus(TransferStatus status);
>>>>>>> 3a423e4 (feat: apply MVC architecture with DTO and service implementation for transfer request)
}
