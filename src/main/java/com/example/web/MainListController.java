package com.example.web;

import com.example.domain.Product;
import com.example.domain.User;
import com.example.service.ProductService;

import com.example.service.UserService;
import javafx.util.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/main")
public class MainListController {

    private ProductService productService;
    private UserService userService;

    @Autowired
    public MainListController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String mainList_init(Model model) {
        model.addAttribute("allProduct",productService.getAllProducts());

        return "mainInit";
    }

    @RequestMapping(value = "/list/user", method = RequestMethod.GET)
    public String mainList_user(HttpServletRequest request, Model model) {
        model.addAttribute("allProduct",productService.getAllProducts());
        model.addAttribute("user", request.getParameter("user"));

        return "mainUser";
    }

    @RequestMapping(value = "/list/manager", method = RequestMethod.GET)
    public String mainList_manager(HttpServletRequest request,Model model) {
        model.addAttribute("allProduct",productService.getAllProducts());
        model.addAttribute("manager", request.getParameter("manager"));

        return "mainManager";
    }

}