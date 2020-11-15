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
import java.util.Date;
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
        List<Pair<Product, Integer>> all_Product = detailed_AllProduct(productService.getAllProducts());
        model.addAttribute("allProduct",all_Product);

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
        List<Pair<Product, Integer>> all_Product = detailed_AllProduct(productService.getAllProducts());
        model.addAttribute("allProduct",all_Product);
        return "mainUser";
    }

    @RequestMapping(value = "/list/manager", method = RequestMethod.GET)
    public String mainList_manager(HttpServletRequest request, Model model) {
        model.addAttribute("managerId", request.getParameter("managerId"));
        model.addAttribute("managerName", request.getParameter("managerName"));
        List<Pair<Product, Integer>> all_Product = detailed_AllProduct(productService.getAllProducts());
        model.addAttribute("allProduct",all_Product);
        return "mainManager";
    }

    public List<Pair<Product, Integer>> detailed_AllProduct(List<Pair<Product, Boolean>> vanilla_AllProduct){
        ArrayList<Pair<Product, Integer>> detailed = new ArrayList<>();
        Date now = new Date();

        for(Pair<Product, Boolean> vanilla : vanilla_AllProduct){
            if(vanilla.getValue()){
                detailed.add(new Pair<>(vanilla.getKey(), 1));
            }else{
                Date startTime = vanilla.getKey().getStartTime();
                Date endTime = vanilla.getKey().getEndTime();

                if(now.getTime() >= startTime.getTime() && now.getTime() <= endTime.getTime() && vanilla.getKey().getStock() <= 0){
                    // empty stock
                    detailed.add(new Pair<>(vanilla.getKey(), 2));
                }else if(now.getTime() > endTime.getTime()){
                    // seckill is over
                    detailed.add(new Pair<>(vanilla.getKey(), 3));
                }else{
                    // seckill not started yet
                    detailed.add(new Pair<>(vanilla.getKey(), 4));
                }
            }
        }

        return detailed;
    }

}