package com.example.dao;

import com.example.domain.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public class OrderDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Order> findOrderByUserId(int userId) {
        String sqlStr = "SELECT * FROM t_order WHERE user_id=?";
        return jdbcTemplate.queryForList(sqlStr, new Object[]{userId}, Order.class);
    }

    public List<Order> findOrderByUserIdAndProductId(int userId, int productId) {
        String sqlStr = "SELECT * FROM t_order WHERE user_id=? AND product_id=?";
        return jdbcTemplate.queryForList(sqlStr, new Object[]{userId, productId}, Order.class);
    }

    public Order findOrderByUserIdAndTime(int userId, Date time) {
        String sqlStr = "SELECT * FROM t_order WHERE user_id=? AND time=?";
        return jdbcTemplate.queryForObject(sqlStr, new Object[]{userId, time}, Order.class);
    }

    public Order findOrderByOrderId(int orderId) {
        String sqlStr = "SELECT * FROM t_order WHERE order_id=?";
        return jdbcTemplate.queryForObject(sqlStr, new Object[]{orderId}, Order.class);
    }

    public void insertOrder(Order order) {
        String sqlStr = "INSERT INTO t_order(user_id,product_id,num,total_price,consignee," +
                "telephone_number,address,create_time,is_paid) "
                + "VALUES(?,?,?,?,?,?,?,?,?)";
        Object[] args = {order.getUserId(), order.getProductId(), order.getNum(),
                order.getTotalPrice(), order.getConsignee(), order.getTelephoneNumber(),
                order.getAddress(), order.getCreateTime(), order.isPaid()};
        jdbcTemplate.update(sqlStr, args);
    }

    public void payForOrder(int orderId) {
        String sqlStr = "UPDATE SET is_paid=? WHERE order_id=?";
        Object[] args = {true, orderId};
        jdbcTemplate.update(sqlStr, args);
    }
}
