package com.example.web;

import com.example.domain.Order;
import com.example.domain.Product;
import com.example.domain.User;
import com.example.service.OrderService;
import com.example.service.ProductService;
import com.example.service.UserService;
import javafx.util.Pair;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/order")
public class OrderController {

    OrderService orderService;
    ProductService productService;
    UserService userService;

    private static final String SUCCESS_MSG = "购买成功";
    private static final String PAYMENT_ERROR = "您的余额不够的";
    private static final String PRODUCT_STOCK_ERROR = "该产品数量不够的";

    @Autowired
    public OrderController(OrderService orderService, ProductService productService, UserService userService) {
        this.orderService = orderService;
        this.productService = productService;
        this.userService = userService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String show_Order(@RequestParam(value ="userId") int user_id, @RequestParam(value ="productId") int product_id, Model model) {

        Pair<Product, Boolean> product_Info = productService.findProductByProductId(product_id);
        boolean is_Seckill_Start = product_Info.getValue();
        int productId = product_Info.getKey().getProductId();
        String productName = product_Info.getKey().getProductName();
        String photo = product_Info.getKey().getPhoto();
        String description = product_Info.getKey().getDescription();
        double price = product_Info.getKey().getPrice();
        int stock = product_Info.getKey().getStock();
        double priceSpike = product_Info.getKey().getPriceSpike();
        Date start_time = product_Info.getKey().getStartTime();
        Date end_time = product_Info.getKey().getEndTime();

        Date now = new Date();
        if(is_Seckill_Start){
            Date time_Left = new Date();

            model.addAttribute("timeLeft", time_Left);
        }

        model.addAttribute("userId",user_id);
        model.addAttribute(new Order());
        model.addAttribute("isStart",is_Seckill_Start);
        model.addAttribute("productId",productId);
        model.addAttribute("productName", productName);
        model.addAttribute("photo", photo);
        model.addAttribute("description", description);
        model.addAttribute("price", price);
        model.addAttribute("stock", stock);
        model.addAttribute("priceSpike", priceSpike);

        return "orderList";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String make_Order(@RequestParam(value ="userId") int user_id, Order order, RedirectAttributes redirect) {
        int product_id = order.getProductId();
        int num = order.getNum();
        double total_price = order.getTotalPrice();
        String consignee = order.getConsignee();
        String telephone = order.getTelephoneNumber();
        String address = order.getAddress();
        Date date = new Date();

        int is_Create_Succ = orderService.createNewOrder(user_id, product_id, num, total_price, consignee, telephone, address, date);

        if(is_Create_Succ == OrderService.SUCCESS_CREATE_ORDER){
            Order new_Order =  orderService.findOrderByUserIdAndCreateTime(user_id, date);
            int is_Payment_Succ = orderService.payForOrder(user_id, new_Order.getOrderId());
            if(is_Payment_Succ == OrderService.BALANCE_NOT_ADEQUATE){
                // PAYMENT_ERROR
                return "redirect:/order?userId="+user_id+"&productId="+product_id;
            }else{
                // SUCCESS_MSG
                User user = userService.findUserByUserId(user_id);
                redirect.addAttribute("user", user);
                return "redirect:/main/list/user";
            }
        }else{
            // PRODUCT_STOCK_ERROR
            return "redirect:/order?userId="+user_id+"&productId="+product_id;
        }
    }

    // Only Manager can use this function
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String show_Order_List(Model model) {
        List<Order> succ_Orders = orderService.findAllCompletedOrder();
        model.addAttribute("succOrders", succ_Orders);

        return "orderList";
    }



}