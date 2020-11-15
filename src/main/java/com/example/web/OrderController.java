package com.example.web;

import com.example.domain.Order;
import com.example.domain.Product;
import com.example.domain.User;
import com.example.service.OrderService;
import com.example.service.ProductService;
import com.example.service.UserService;
import javafx.util.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/order")
public class OrderController{

    OrderService orderService;
    ProductService productService;
    UserService userService;

    private static final String SUCCESS_MSG = "Order succeed";
    private static final String INVALID_KEY_ERROR = "Invalid Order";
    private static final String PAYMENT_ERROR = "Order failed : Not enough account";
    private static final String PRODUCT_STOCK_ERROR = "Order failed : Not have enough stock";

    @Autowired
    public OrderController(OrderService orderService, ProductService productService, UserService userService) {
        this.orderService = orderService;
        this.productService = productService;
        this.userService = userService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String show_Order(@RequestParam(value ="userId") int user_id, @RequestParam(value ="productId") int product_id, Model model, HttpServletResponse response, HttpServletRequest request, RedirectAttributes redirect) throws IOException {
        if(request.getParameter("msg")!=null){
            model.addAttribute("msg",request.getParameter("msg"));
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('"+request.getParameter("msg")+"');</script>");
            out.flush();
        }

        Pair<Product, Boolean> product_Info = productService.findProductByProductId(product_id);

        if(Integer.parseInt(request.getParameter("randomKey")) != product_Info.getKey().getRandomKey()){
            User user = userService.findUserByUserId(user_id);
            redirect.addAttribute("userId", user.getUserId());
            redirect.addAttribute("userName", user.getUserName());
            redirect.addAttribute("userBalance", user.getBalance());
            redirect.addAttribute("msg", INVALID_KEY_ERROR);
            return "redirect:/main/list/user.html";
        }

        boolean is_Seckill_Start = product_Info.getValue();
        int productId = product_Info.getKey().getProductId();
        String productName = product_Info.getKey().getProductName();
        String photo = product_Info.getKey().getPhoto();
        String description = product_Info.getKey().getDescription();
        double price = product_Info.getKey().getPrice();
        int stock = product_Info.getKey().getStock();
        double priceSpike = product_Info.getKey().getPriceSpike();

        LocalDate end_Date = convertToLocalDateViaInstant(product_Info.getKey().getEndTime());
        LocalDate now = LocalDate.now();

        if(is_Seckill_Start){
            if(now.isBefore(end_Date)){
                long date_period = now.until(end_Date, ChronoUnit.DAYS);
                model.addAttribute("isDay", true);
                model.addAttribute("dayLeft", date_period+"天");
            }else if(now.isEqual(end_Date)){
                long time_period = (product_Info.getKey().getEndTime().getTime()-new Date().getTime())/1000;
                System.out.println("time_period " +time_period);
                model.addAttribute("timeLeft", time_period);
            }
        }


        model.addAttribute("userId",user_id);
        model.addAttribute("userName",userService.findUserByUserId(user_id).getUserName());
        model.addAttribute("userBalance",userService.findUserByUserId(user_id).getBalance());
        model.addAttribute(new Order());
        model.addAttribute("isStart",is_Seckill_Start);
        model.addAttribute("productId",productId);
        model.addAttribute("productName", productName);
        model.addAttribute("photo", photo);
        model.addAttribute("description", description);
        model.addAttribute("price", price);
        model.addAttribute("stock", stock);
        model.addAttribute("priceSpike", priceSpike);
        return "order";
    }

    public LocalDate convertToLocalDateViaInstant(Date dateToConvert) {
        return dateToConvert.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();
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

        System.out.println("product_id : " +product_id);
        System.out.println("num : " +num);
        System.out.println("total_price : " +total_price);
        System.out.println("consignee : " +consignee);
        System.out.println("telephone : " +telephone);
        System.out.println("address : " +address);
        System.out.println("date : " +date.toString());

        int is_Create_Succ = orderService.createNewOrder(user_id, product_id, num, total_price, consignee, telephone, address, date);

        if(is_Create_Succ == OrderService.SUCCESS_CREATE_ORDER){
            Order new_Order =  orderService.findOrderByUserIdAndCreateTime(user_id, date);
            int is_Payment_Succ = orderService.payForOrder(user_id, new_Order.getOrderId());
            if(is_Payment_Succ == OrderService.BALANCE_NOT_ADEQUATE){
                // PAYMENT_ERROR
                redirect.addAttribute("msg", PAYMENT_ERROR);
                return "redirect:/order.html?userId="+user_id+"&productId="+product_id;
            }else if(is_Payment_Succ == OrderService.STOCK_NOT_ADEQUATE){
                // PRODUCT_STOCK_ERROR
                redirect.addAttribute("msg",  PRODUCT_STOCK_ERROR);
                return "redirect:/order.html?userId="+user_id+"&productId="+product_id;
            }else{
                // SUCCESS_MSG
                User user = userService.findUserByUserId(user_id);
                redirect.addAttribute("userId", user.getUserId());
                redirect.addAttribute("userName", user.getUserName());
                redirect.addAttribute("userBalance", user.getBalance());
                redirect.addAttribute("msg", SUCCESS_MSG);
                return "redirect:/main/list/user.html";
            }
        }else{
            // PRODUCT_STOCK_ERROR
            redirect.addAttribute("msg",  PRODUCT_STOCK_ERROR);
            return "redirect:/order.html?userId="+user_id+"&productId="+product_id;
        }
    }

    // Only Manager can use this function
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String show_Order_List(HttpServletRequest request, Model model) {
        List<Order> orders = orderService.findAllOrder();
        model.addAttribute("orders", orders);
        model.addAttribute("managerId", request.getParameter("managerId"));
        model.addAttribute("managerName", request.getParameter("managerName"));

        return "orderList";
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    public String getOrderListByUserIdAndProductId(Model model, HttpServletRequest request) {
        List<Order> orders = orderService.findOrderByUserIdAndProductId(Integer.parseInt(request.getParameter("userId")),
                Integer.parseInt(request.getParameter("productId")));
        model.addAttribute("orders", orders);

        model.addAttribute("managerId", request.getParameter("managerId"));
        model.addAttribute("managerName", request.getParameter("managerName"));
        return "orderList";
    }


}