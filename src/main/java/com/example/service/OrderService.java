package com.example.service;

import com.example.dao.OrderDao;
import com.example.dao.ProductDao;
import com.example.dao.UserDao;
import com.example.domain.Order;
import com.example.domain.Product;
import com.example.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ProductDao productDao;

    @Autowired
    private UserDao userDao;

    /* 订单创建结果 */
    public static final int SUCCESS_CREATE_ORDER = 100;
    public static final int STOCK_NOT_ADEQUATE = 101;

    /* 支付结果 */
    public static final int SUCCESS_PAID = 200;
    public static final int BALANCE_NOT_ADEQUATE = 201;

    /**
     * 创建新订单
     */
    public int createNewOrder(int userId, int productId, int num, double totalPrice,
                              String consignee, String telephoneNumber, String address,
                              Date createTime) {
        Product product = productDao.findProduct(productId);
        if (product.getStock() < num)
            return STOCK_NOT_ADEQUATE;
        Order order = new Order(productId, userId, num, totalPrice, consignee, telephoneNumber, address, createTime);
        orderDao.insertOrder(order);
        return SUCCESS_CREATE_ORDER;
    }

    /**
     * 为订单付款，完成订单
     */
    public int payForOrder(int userId, int orderId) {
        User user = userDao.findUserById(userId);
        Order order = orderDao.findOrderByOrderId(orderId);
        if (user.getBalance() < order.getTotalPrice())
            return BALANCE_NOT_ADEQUATE;
        double balance = user.getBalance() - order.getTotalPrice();
        userDao.updateBalance(balance, userId);
        orderDao.payForOrder(orderId);
        return SUCCESS_PAID;
    }

    /**
     * 查找全部订单
     */
    public List<Order> findAllOrder() {
        return orderDao.findAllOrder();
    }

    /**
     * 查找全部已完成订单
     */
    public List<Order> findAllCompletedOrder() {
        return orderDao.findAllCompletedOrder();
    }

    /**
     * 根据用户id和订单创建时间获取订单
     */
    public Order findOrderByUserIdAndCreateTime(int userId, Date createTime) {
        return orderDao.findOrderByUserIdAndTime(userId, createTime);
    }

    /**
     * 获取全部订单
     */
    public List<Order> getAllOrder() {
        return orderDao.findAllOrder();
    }

    /**
     * 根据用户和id和商品id获取订单
     */
    public List<Order> findOrderByUserIdAndProductId(int userId, int productId) {
        return orderDao.findOrderByUserIdAndProductId(userId, productId);
    }

}
