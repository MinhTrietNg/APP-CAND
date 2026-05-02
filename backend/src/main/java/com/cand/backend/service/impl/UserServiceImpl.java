package com.cand.backend.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.cand.backend.entity.User;
import com.cand.backend.repository.UserRepository;
import com.cand.backend.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    @Override
    public User getCurrentUser(UUID userId) {
        return userRepository.findById(userId).orElse(null);
    }

    @Override
    public User createUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public User updateUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public boolean deleteUser(UUID userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            user.setStatus("NGUNG_HOAT_DONG");
            userRepository.save(user);
            return true;
        }
        return false;
    }

    @Override
    public List<User> getUsersByUnit(Long unitId) {
        return userRepository.findByUnitId(unitId);
    }
}
