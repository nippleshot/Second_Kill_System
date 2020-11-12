package com.example.web;

import com.example.domain.Order;
import com.example.service.OrderService;
import com.example.service.ProductService;
import com.example.service.UserService;
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

@Controller
@RequestMapping(value = "/order")
public class OrderController {

    OrderService orderService;
    ProductService productService;

    private static final String SUCCESS_MSG = "购买成功";
    private static final String PAYMENT_ERROR = "您的余额不够的";
    private static final String PRODUCT_STOCK_ERROR = "该产品数量不够的";

    @Autowired
    public OrderController(OrderService orderService, ProductService productService) {
        this.orderService = orderService;
        this.productService = productService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String show_Order(@RequestParam(value ="userId") int user_id, @RequestParam(value ="productId") int product_id, Model model) {
        model.addAttribute("product",productService.findProductByProductId(product_id));
        model.addAttribute("user",user_id);

        return "order";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String make_Order(@RequestParam(value ="userId") int user_id, @RequestParam(value ="productId") int product_id, HttpServletRequest request, RedirectAttributes redirect) {

        int num = Integer.parseInt(request.getParameter("number"));
        double total_price = Double.parseDouble(request.getParameter("total"));
        String consignee = request.getParameter("consignee");
        String telephone = request.getParameter("telephone");
        String address = request.getParameter("address");
        Date date = new Date();

        int is_Create_Succ = orderService.createNewOrder(user_id, product_id, num, total_price, consignee, telephone, address, date);
        if(is_Create_Succ == OrderService.SUCCESS_CREATE_ORDER){
            // int is_Payment_Succ = orderService.payForOrder(user_id, )
        }else{

        }
        return "mainInit";
    }


    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String show_Order_List(Model model) {



        return "order";
    }



}