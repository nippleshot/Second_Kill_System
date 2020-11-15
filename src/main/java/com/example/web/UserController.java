package com.example.web;

import com.example.domain.Order;
import com.example.domain.User;
import com.example.service.OrderService;
import com.example.service.ProductService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@Controller
@RequestMapping(value = "/user")
public class UserController {

    private UserService userService;
    private OrderService orderService;

    private static final String USER_NAME_EXIST_MSG = "Register input is already exist";
    private static final String LOGIN_FAIL_MSG = "Inappropriate Login input";
    private static final String CHARGE_ERROR_MSG = "You should charge more than 0";
    private static final String REGISTER_SUCCESS = "Register Succeed";
    private static final String CHARGE_SUCCESS = "Charge Succeed";
    private static final String USER_ACCUNT_ERROR = "Payment Failed : Your Account is not enough";
    private static final String NO_STOCK_ERROR = "Payment Failed : No inventory";
    private static final String PAYMENT_SUCCESS = "Paid Succeed";

    @Autowired
    public UserController(UserService userService, OrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String show_Login(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        if(request.getParameter("msg")!=null){
            model.addAttribute("msg",request.getParameter("msg"));
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('"+request.getParameter("msg")+"'); history.go(-1);</script>");
            out.flush();
        }
        model.addAttribute(new User("",""));
        return "logIn";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String check_Login(User user, RedirectAttributes redirect) {
        String userName = user.getUserName();
        String password = user.getPassword();

        if(userService.hasMatchUser(userName, password)){
            User find_user = userService.findUserByUserName(userName);

            if(find_user.getPrivilege() == 1){
                redirect.addAttribute("managerId", find_user.getUserId());
                redirect.addAttribute("managerName", find_user.getUserName());
                return "redirect:/main/list/manager.html";

            }else if(find_user.getPrivilege() == 0){
                redirect.addAttribute("userId", find_user.getUserId());
                redirect.addAttribute("userName", find_user.getUserName());
                redirect.addAttribute("userBalance", find_user.getBalance());
                return "redirect:/main/list/user.html";
            }
        }else{
            redirect.addAttribute("msg", LOGIN_FAIL_MSG);
            return "redirect:/user/login.html";
        }

        return null;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user, RedirectAttributes redirect) {
        String userName = user.getUserName();
        String password = user.getPassword();

        if(userService.hasMatchUser(userName)){
            redirect.addAttribute("msg", USER_NAME_EXIST_MSG);
            return "redirect:/user/login.html";
        }else{
            userService.register(userName, password);
        }

        User new_user = userService.findUserByUserName(userName);

        // redirect immediately to main/list
        redirect.addAttribute("userId", new_user.getUserId());
        redirect.addAttribute("userName", new_user.getUserName());
        redirect.addAttribute("userBalance", new_user.getBalance());
        redirect.addAttribute("msg", REGISTER_SUCCESS);
        return "redirect:/main/list/user.html";
    }

    @RequestMapping(value = "/charge", method = RequestMethod.GET)
    public String charge(@RequestParam(value ="userId") int user_id, HttpServletRequest request, HttpServletResponse response,Model model) throws IOException {
        if(request.getParameter("msg")!=null){
            model.addAttribute("msg",request.getParameter("msg"));
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('"+request.getParameter("msg")+"'); history.go(-1);</script>");
            out.flush();
        }

        User user = userService.findUserByUserId(user_id);

        model.addAttribute(new User());
        model.addAttribute("userId", user.getUserId());
        model.addAttribute("userName", user.getUserName());
        model.addAttribute("userBalance", user.getBalance());
        return "charge";
    }

    @RequestMapping(value = "/charge", method = RequestMethod.POST)
    public String charge(User user, RedirectAttributes redirect) {

        if(user.getBalance()<=0){
            redirect.addAttribute("msg", CHARGE_ERROR_MSG);
            return "redirect:/user/charge.html?userId="+user.getUserId();
        }else{
            userService.recharge((int)user.getBalance(),user.getUserId());
        }


        User after_charge = userService.findUserByUserId(user.getUserId());

        redirect.addAttribute("userId", after_charge.getUserId());
        redirect.addAttribute("userName", after_charge.getUserName());
        redirect.addAttribute("userBalance", after_charge.getBalance());
        redirect.addAttribute("msg", CHARGE_SUCCESS);
        return "redirect:/main/list/user.html";
    }

    @RequestMapping(value = "/myList", method = RequestMethod.GET)
    public String charge(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        if(request.getParameter("msg")!=null){
            model.addAttribute("msg",request.getParameter("msg"));
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('"+request.getParameter("msg")+"'); history.go(1);</script>");
            out.flush();
        }

        model.addAttribute("userId", request.getParameter("userId"));
        model.addAttribute("userName", request.getParameter("userName"));
        model.addAttribute("userBalance", request.getParameter("userBalance"));
        List<Order> orders = orderService.findOrderByUserId(Integer.parseInt(request.getParameter("userId")));
        model.addAttribute("orders", orders);


        return "orderListUser";
    }

    @RequestMapping(value = "/myList", method = RequestMethod.POST)
    public String charge(HttpServletRequest request, Model model, RedirectAttributes redirect){

        int user_id = Integer.parseInt(request.getParameter("userId"));
        int order_Id = Integer.parseInt(request.getParameter("orderId"));
        int pay_result = orderService.payForOrder(user_id, order_Id);

        if(pay_result==OrderService.BALANCE_NOT_ADEQUATE){
            redirect.addAttribute("msg", USER_ACCUNT_ERROR);
        }else if(pay_result==OrderService.STOCK_NOT_ADEQUATE){
            redirect.addAttribute("msg", NO_STOCK_ERROR);
        }else{
            redirect.addAttribute("msg", PAYMENT_SUCCESS);
        }

        User user = userService.findUserByUserId(user_id);
        redirect.addAttribute("userId", user_id);
        redirect.addAttribute("userName", user.getUserName());
        redirect.addAttribute("userBalance", user.getBalance());

        return "redirect:/user/myList.html";
    }


}