package com.mine.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mine.service.User;

@Repository
public interface UserRepo extends JpaRepository<User, Integer>{

}
