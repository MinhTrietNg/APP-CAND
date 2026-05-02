package com.cand.backend.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cand.backend.entity.User;
import com.cand.backend.security.CustomUserDetails;
import com.cand.backend.service.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/api/users")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/all")
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/all-by-unit")
    public List<User> getUsersByUnit() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String email = ((CustomUserDetails) principal).getUsername();
        User currentUser = userService.getUserByEmail(email);
        // Check roles if needed, e.g. only allow if currentUser has role "ROLE_CAN_BO"
        Long unitId = currentUser.getUnit().getId();
        return userService.getUsersByUnit(unitId);
    }

    @GetMapping("/me")
    public User getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UUID userId = ((CustomUserDetails) principal).getUser().getId();
        return userService.getCurrentUser(userId);
    }

    @PostMapping("/create")
    public User createUser(@RequestBody User user) {
        return userService.createUser(user);
    }

    @PostMapping("/update")
    public User updateUser(@RequestBody User user) {
        return userService.updateUser(user);
    }

    @PostMapping("/delete")
    public boolean deleteUser(@RequestBody UUID userId) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UUID leader_id = ((CustomUserDetails) principal).getUser().getId();
        return userService.deleteUser(userId);
    }
}
