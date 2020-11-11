DROP DATABASE IF EXISTS exampledb;
CREATE DATABASE exampledb DEFAULT CHARACTER SET utf8;
USE exampledb;

##创建用户表
CREATE TABLE t_user (
   user_id   INT AUTO_INCREMENT PRIMARY KEY,
   user_name VARCHAR(30),
   password  VARCHAR(32),
   privilege INT,
   balance DOUBLE
)ENGINE=InnoDB;

##创建商品表
CREATE TABLE t_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(64),
    photo VARCHAR(255),
    description VARCHAR(255),
    price DOUBLE,
    stock INT,
    price_spike DOUBLE,
    start_time DATETIME,
    end_time DATETIME
)ENGINE=InnoDB;

##创建订单表
CREATE TABLE t_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    num INT,
    total_price DOUBLE,
    consignee VARCHAR(64),
    telephone_number VARCHAR(32),
    address VARCHAR(64),
    create_time DATETIME,
    is_paid BOOLEAN
)ENGINE=InnoDB;

##插入初始化数据
INSERT INTO t_user (user_name,password, privilege)
             VALUES('admin','123456', 1);
COMMIT;