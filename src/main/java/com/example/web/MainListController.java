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
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/main")
public class MainListController {

    private ProductService productService;

    @Autowired
    public MainListController(ProductService productService) {
        this.productService = productService;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String mainList_init(Model model) {
        model.addAttribute("allProduct",productService.getAllProducts());

        return "mainInit";
    }

    @RequestMapping(value = "/list/user", method = RequestMethod.GET)
    public String mainList_user(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        if(request.getParameter("msg")!=null){
            model.addAttribute("msg",request.getParameter("msg"));
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('"+request.getParameter("msg")+"');</script>");
            out.flush();
        }

        model.addAttribute("userId", request.getParameter("userId"));
        model.addAttribute("userName", request.getParameter("userName"));
        model.addAttribute("userBalance", request.getParameter("userBalance"));
        model.addAttribute("allProduct",productService.getAllProducts());
        return "mainUser";
    }

    @RequestMapping(value = "/list/manager", method = RequestMethod.GET)
    public String mainList_manager(HttpServletRequest request, Model model) {
        model.addAttribute("managerId", request.getParameter("managerId"));
        model.addAttribute("managerName", request.getParameter("managerName"));
        model.addAttribute("allProduct",productService.getAllProducts());
        return "mainManager";
    }

}