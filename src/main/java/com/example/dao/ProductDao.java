package com.example.dao;

import com.example.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Product findProduct(int productId) {
        String sqlStr = "SELECT * FROM t_product WHERE product_id=?";
        return jdbcTemplate.queryForObject(sqlStr, new Object[]{productId}, (resultSet, i) -> {
            Product product = new Product(resultSet.getString("product_name"),
                    resultSet.getString("photo"),
                    resultSet.getString("description"),
                    resultSet.getDouble("price"),
                    resultSet.getInt("stock"),
                    resultSet.getDouble("price_spike"),
                    resultSet.getTimestamp("start_time"),
                    resultSet.getTimestamp("end_time"));
            product.setProductId(resultSet.getInt("product_id"));
            return product;
        });
    }

    public List<Product> getAllProduct() {
        String sqlStr = "SELECT * FROM t_product";
        return jdbcTemplate.query(sqlStr, (resultSet, i) -> {
            Product product = new Product(resultSet.getString("product_name"),
                    resultSet.getString("photo"),
                    resultSet.getString("description"),
                    resultSet.getDouble("price"),
                    resultSet.getInt("stock"),
                    resultSet.getDouble("price_spike"),
                    resultSet.getTimestamp("start_time"),
                    resultSet.getTimestamp("end_time"));
            product.setProductId(resultSet.getInt("product_id"));
            return product;
        });
    }

    public void insertProduct(Product product) {
        String sqlStr = "INSERT INTO t_product(product_name,photo,description,price,stock," +
                "price_spike,start_time,end_time) " +
                "VALUES(?,?,?,?,?,?,?,?)";
        Object[] args = {product.getProductName(), product.getPhoto(), product.getDescription(),
                product.getPrice(), product.getStock(), product.getPriceSpike(),
                product.getStartTime(), product.getEndTime()};
        jdbcTemplate.update(sqlStr, args);
    }

    public void updateProduct(Product product) {
        String sqlStr = "UPDATE t_product " +
                "SET product_name=?," +
                "photo=?," +
                "description=?," +
                "price=?," +
                "stock=?," +
                "price_spike=?," +
                "start_time=?," +
                "end_time=? " +
                "WHERE product_id=?";
        Object[] args = {product.getProductName(), product.getPhoto(), product.getDescription(),
                product.getPrice(), product.getStock(), product.getPriceSpike(),
                product.getStartTime(), product.getEndTime(), product.getProductId()};
        jdbcTemplate.update(sqlStr, args);
    }

    public void deleteProduct(int productId) {
        String sqlStr = "DELETE FROM t_product WHERE product_id=?";
        Object[] args = {productId};
        jdbcTemplate.update(sqlStr, args);
    }

}
