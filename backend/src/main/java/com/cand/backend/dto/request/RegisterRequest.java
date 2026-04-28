package com.cand.backend.dto.request;

import com.cand.backend.entity.Role;
import lombok.Data;

@Data
public class RegisterRequest {
    private String name;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private Role role;
}
