package com.cand.backend.service;

import java.util.List;
import java.util.UUID;

import com.cand.backend.entity.User;

public interface UserService {

    List<User> getAllUsers();

    User getUserByEmail(String email);

    User getCurrentUser(UUID userId);

    User createUser(User user);

    User updateUser(User user);

    boolean deleteUser(UUID userId);

    List<User> getUsersByUnit(Long unitId);
}
