package com.example.service;

import com.example.dao.ProductDao;
import com.example.domain.Product;
import javafx.util.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductDao productDao;

    /**
     * 新建商品
     */
    public void insertProduct(String productName, String photo, String description,
                              double price, int stock, double priceSpike, Date startTime,
                              Date endTime) {
        Product product = new Product(productName, photo, description, price,
                stock, priceSpike, startTime, endTime);
        productDao.insertProduct(product);
    }

    /**
     * 根据product_id查找商品
     */
    public Pair<Product, Boolean> findProductByProductId(int productId) {
        Product product = productDao.findProduct(productId);
        Date now = new Date();
        Date startTime = product.getStartTime();
        Date endTime = product.getEndTime();
        Pair<Product, Boolean> res;
        if (now.compareTo(startTime) >= 0 && now.compareTo(endTime) <= 0)
            res = new Pair<>(product, true);
        else
            res = new Pair<>(product, false);
        return res;
    }

    /**
     * 获取全部商品列表
     */
    public List<Pair<Product, Boolean>> getAllProducts() {
        List<Product> products = productDao.getAllProduct();
        ArrayList<Pair<Product, Boolean>> res = new ArrayList<>();
        Date now = new Date();
        for(Product product : products) {
            Date startTime = product.getStartTime();
            Date endTime = product.getEndTime();
            if (now.compareTo(startTime) >= 0 && now.compareTo(endTime) <= 0)
                res.add(new Pair<>(product, true));
            else
                res.add(new Pair<>(product, false));
        }
        return res;
    }

    /**
     * 更新产品信息
     */
    public void updateProduct(int productId, String productName, String photo, String description,
                              double price, int stock, double priceSpike, Date startTime,
                              Date endTime) {
        Product product = new Product(productName, photo, description, price,
                stock, priceSpike, startTime, endTime);
        product.setProductId(productId);
        productDao.updateProduct(product);
    }

    /**
     * 删除产品
     */
    public void deleteProduct(int productId) {
        productDao.deleteProduct(productId);
    }
}
