package com.example.web;

import com.example.domain.Order;
import com.example.domain.Product;
import com.example.domain.ProductInfo;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping(value = "/product")
public class ProductController {

    ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String show_Product_List(HttpServletRequest request, Model model) {
        List<Pair<Product, Boolean>> all_Product = productService.getAllProducts();
        model.addAttribute("allProduct", all_Product);
        model.addAttribute(new ProductInfo());
        model.addAttribute("managerId", request.getParameter("managerId"));
        model.addAttribute("managerName", request.getParameter("managerName"));

        return "productManage";
    }

    @RequestMapping(value = "/list/add", method = RequestMethod.POST)
    public String add_Product(ProductInfo productInfo, HttpServletRequest request, RedirectAttributes redirect) {

//        System.out.println("Name: "+productInfo.getProductName());
//        System.out.println("Photo: "+productInfo.getPhoto());
//        System.out.println("Description: "+productInfo.getDescription());
//        System.out.println("Price: "+productInfo.getPrice());
//        System.out.println("PriceSpike: "+productInfo.getPriceSpike());
//        System.out.println("Stock: "+productInfo.getStock());
//        System.out.println("StartTime: "+productInfo.getStartTime().toString());
//        System.out.println("EndTime: "+productInfo.getEndTime().toString());

        LocalDateTime StartTime_local = productInfo.getStartTime();
        LocalDateTime EndTime_local = productInfo.getEndTime();


        Date StartTime_Date = Date.from( StartTime_local.atZone( ZoneId.systemDefault()).toInstant());
        Date EndTime_Date = Date.from( EndTime_local.atZone( ZoneId.systemDefault()).toInstant());

        productService.insertProduct(productInfo.getProductName(), productInfo.getPhoto(), productInfo.getDescription(),
                        productInfo.getPrice(), productInfo.getStock(), productInfo.getPriceSpike(),
                StartTime_Date, EndTime_Date);

        redirect.addAttribute("managerId",request.getParameter("managerId"));
        redirect.addAttribute("managerName",request.getParameter("managerName"));
        return "redirect:/product/list.html";
    }


    @RequestMapping(value = "/list/delete", method = RequestMethod.POST)
    public String delete_Product(@RequestParam(value ="productId") int product_id, HttpServletRequest request, RedirectAttributes redirect) {
        productService.deleteProduct(product_id);

        redirect.addAttribute("managerId",request.getParameter("managerId"));
        redirect.addAttribute("managerName",request.getParameter("managerName"));
        return "redirect:/product/list.html";
    }

    @RequestMapping(value = "/list/fix", method = RequestMethod.POST)
    public String fix_Product(ProductInfo productInfo, HttpServletRequest request, RedirectAttributes redirect) {

        LocalDateTime StartTime_local = productInfo.getStartTime();
        LocalDateTime EndTime_local = productInfo.getEndTime();


        Date StartTime_Date = Date.from( StartTime_local.atZone( ZoneId.systemDefault()).toInstant());
        Date EndTime_Date = Date.from( EndTime_local.atZone( ZoneId.systemDefault()).toInstant());

        productService.updateProduct(productInfo.getProductId(),productInfo.getProductName(), productInfo.getPhoto(), productInfo.getDescription(),
                productInfo.getPrice(), productInfo.getStock(), productInfo.getPriceSpike(),
                StartTime_Date, EndTime_Date);

        redirect.addAttribute("managerId",request.getParameter("managerId"));
        redirect.addAttribute("managerName",request.getParameter("managerName"));
        return "redirect:/product/list.html";
    }






}