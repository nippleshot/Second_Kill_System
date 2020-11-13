package com.example.dao;

import com.example.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int getMatchCount(String userName, String password) {
        String sqlStr = " SELECT count(*) FROM t_user "
                + " WHERE user_name =? and password=?";
        return jdbcTemplate.queryForObject(sqlStr, new Object[]{userName, password}, Integer.class);
    }

    public int getMatchCount(String userName) {
        String sqlStr = " SELECT count(*) FROM t_user "
                + " WHERE user_name =?";
        return jdbcTemplate.queryForObject(sqlStr, new Object[]{userName}, Integer.class);
    }

    public User findUserByUserName(String userName) {
        String sqlStr = " SELECT * "
                + " FROM t_user WHERE user_name=?";

        return jdbcTemplate.queryForObject(sqlStr, new Object[]{userName}, (resultSet, i) -> {
            User user=new User(resultSet.getString("user_name"), resultSet.getString("password"));
            user.setUserId(resultSet.getInt("user_id"));
            return user;
        });
    }

    public User findUserById(int userId) {
        String sqlStr = "SELECT * FROM t_user WHERE user_id=?";
        return jdbcTemplate.queryForObject(sqlStr, new Object[]{userId}, (resultSet, i) -> {
            User user=new User(resultSet.getString("user_name"), resultSet.getString("password"));
            user.setUserId(resultSet.getInt("user_id"));
            return user;
        });
    }

    public void insertUser(User user) {
        String sqlStr = "INSERT INTO t_user(user_name,password,privilege,balance)" +
                " VALUES(?,?,?,?)";
        Object[] args = {user.getUserName(), user.getPassword(), user.getPrivilege(), user.getBalance()};
        jdbcTemplate.update(sqlStr, args);
    }

    public void updateBalance(double balance, int userId) {
        String sqlStr = "UPDATE t_user SET balance=?"
                + " WHERE user_id=?";
        Object[] args = {balance, userId};
        jdbcTemplate.update(sqlStr, args);
    }

}
