package com.cand.backend.repository;

<<<<<<< HEAD
import com.cand.backend.entity.Unit;
=======
import com.cand.backend.model.Unit;
>>>>>>> 3a423e4 (feat: apply MVC architecture with DTO and service implementation for transfer request)
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UnitRepository extends JpaRepository<Unit, Long> {
}
