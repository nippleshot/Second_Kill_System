package com.example.web;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.domain.User;
import com.example.service.UserService;

import java.util.Date;

@Controller
@RequestMapping(value = "/admin")
public class UserController {

    private UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/login.html")
    public String loginPage() {

        return "login";
    }

    @RequestMapping(value = "/loginCheck.html")
    public ModelAndView loginCheck(HttpServletRequest request, LoginInfo loginInfo) {
        boolean isValidUser =
                userService.hasMatchUser(loginInfo.getUserName(),
                        loginInfo.getPassword());
        if (!isValidUser) {
            return new ModelAndView("login", "error", "用户名或密码错误。");
        } else {
            User user = userService.findUserByUserName(loginInfo
                    .getUserName());
            request.getSession().setAttribute("user", user);
            return new ModelAndView("main");
        }
    }

    @RequestMapping(value = "/register.html")
    public String registerPage() {

        return "register";
    }

    @RequestMapping(value = "/registerInfo.html")
    public ModelAndView register(HttpServletRequest request, RegisterInfo registerInfo) {
        boolean userNameHaveBeenUsed =
                userService.hasMatchUser(registerInfo.getUserName());
        if (userNameHaveBeenUsed)
            return new ModelAndView("register", "error", "用户名已注册。");
        userService.register(registerInfo.getUserName(), registerInfo.getPassword());
        return new ModelAndView("login");
    }


}
