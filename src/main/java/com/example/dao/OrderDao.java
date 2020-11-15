package com.example.dao;

import com.example.domain.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@Repository
public class OrderDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Order> findAllOrder() {
        String sqlStr = "SELECT * FROM t_order";
        return jdbcTemplate.query(sqlStr, (resultSet, i) -> {
            Order order = new Order(
                    resultSet.getInt("product_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getInt("num"),
                    resultSet.getDouble("total_price"),
                    resultSet.getString("consignee"),
                    resultSet.getString("telephone_number"),
                    resultSet.getString("address"),
                    resultSet.getDate("create_time"));
            order.setOrderId(resultSet.getInt("order_id"));
            order.setPaid(resultSet.getBoolean("is_paid"));
            return order;
        });
    }

    public List<Order> findOrderByUserId(int userId) {
        String sqlStr = "SELECT * FROM t_order WHERE user_id=?";
        return jdbcTemplate.query(sqlStr, new Object[]{userId}, (resultSet, i) -> {
            Order order = new Order(
                    resultSet.getInt("product_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getInt("num"),
                    resultSet.getDouble("total_price"),
                    resultSet.getString("consignee"),
                    resultSet.getString("telephone_number"),
                    resultSet.getString("address"),
                    resultSet.getDate("create_time"));
            order.setOrderId(resultSet.getInt("order_id"));
            order.setPaid(resultSet.getBoolean("is_paid"));
            return order;
        });
    }

    public List<Order> findOrderByUserIdAndProductId(int userId, int productId) {
        String sqlStr = "SELECT * FROM t_order WHERE user_id=? AND product_id=?";
        return jdbcTemplate.query(sqlStr, new Object[]{userId, productId}, (resultSet, i) -> {
            Order order = new Order(
                    resultSet.getInt("product_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getInt("num"),
                    resultSet.getDouble("total_price"),
                    resultSet.getString("consignee"),
                    resultSet.getString("telephone_number"),
                    resultSet.getString("address"),
                    resultSet.getDate("create_time"));
            order.setOrderId(resultSet.getInt("order_id"));
            order.setPaid(resultSet.getBoolean("is_paid"));
            return order;
        });
    }

    public Order findOrderByUserIdAndTime(int userId, Date createTime) {
        String sqlStr = "SELECT * FROM t_order WHERE user_id=? AND create_time=?";

        try {
            return jdbcTemplate.queryForObject(sqlStr, new Object[]{userId, createTime}, (resultSet, i) -> {
                Order order = new Order(
                        resultSet.getInt("product_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("num"),
                        resultSet.getDouble("total_price"),
                        resultSet.getString("consignee"),
                        resultSet.getString("telephone_number"),
                        resultSet.getString("address"),
                        resultSet.getDate("create_time"));
                order.setOrderId(resultSet.getInt("order_id"));
                order.setPaid(resultSet.getBoolean("is_paid"));
                return order;
            });
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public List<Order> findAllCompletedOrder() {
        String sqlStr = "SELECT * FROM t_order WHERE is_paid=true";
        return jdbcTemplate.query(sqlStr, (resultSet, i) -> {
            Order order = new Order(
                    resultSet.getInt("product_id"),
                    resultSet.getInt("user_id"),
                    resultSet.getInt("num"),
                    resultSet.getDouble("total_price"),
                    resultSet.getString("consignee"),
                    resultSet.getString("telephone_number"),
                    resultSet.getString("address"),
                    resultSet.getTimestamp("create_time"));
            order.setOrderId(resultSet.getInt("order_id"));
            order.setPaid(resultSet.getBoolean("is_paid"));
            return order;
        });
    }

    public Order findOrderByOrderId(int orderId) {
        String sqlStr = "SELECT * FROM t_order WHERE order_id=?";
        try {
            return jdbcTemplate.queryForObject(sqlStr, new Object[]{orderId}, (resultSet, i) -> {
                Order order = new Order(
                        resultSet.getInt("product_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("num"),
                        resultSet.getDouble("total_price"),
                        resultSet.getString("consignee"),
                        resultSet.getString("telephone_number"),
                        resultSet.getString("address"),
                        resultSet.getTimestamp("create_time"));
                order.setOrderId(resultSet.getInt("order_id"));
                order.setPaid(resultSet.getBoolean("is_paid"));
                return order;
            });
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
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
