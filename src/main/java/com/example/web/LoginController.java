package com.example.web;

import com.example.domain.User;
import com.example.service.ProductService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {

    private UserService userService;

    @Autowired
    public LoginController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String show_Login() {

        return "logIn";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String check_Login(HttpServletRequest request, RedirectAttributes redirect) {
        String id = request.getParameter("userName");
        String password = request.getParameter("password");

        if(userService.hasMatchUser(id, password)){
            User user = userService.findUserByUserName(id);

            if(user.getPrivilege() == 1){
                redirect.addAttribute("manager", user);
                return "redirect:/main/list/manager";

            }else if(user.getPrivilege() == 0){
                redirect.addAttribute("user", user);
                return "redirect:/main/list/user";
            }
        }else{
            return "redirect:/login";
        }

        return null;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(HttpServletRequest request, RedirectAttributes redirect) {
        String id = request.getParameter("userName");
        String password = request.getParameter("password");
        // register user (No Error)
        userService.register(id, password);

        User user = userService.findUserByUserName(id);

        // redirect immediately to main/list
        redirect.addAttribute("user", user);
        return "redirect:/main/list/user";
    }


}