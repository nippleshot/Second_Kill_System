package com.example.web;

import com.example.domain.Order;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
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
    public String show_Product_List(Model model) {
        List<Pair<Product, Boolean>> all_Product = productService.getAllProducts();
        model.addAttribute("allProduct", all_Product);
        return "productManage";
    }

    @RequestMapping(value = "/list/add", method = RequestMethod.POST)
    public String add_Product(Product product) {
        productService.insertProduct(product.getProductName(), product.getPhoto(), product.getDescription(),
                product.getPrice(), product.getStock(), product.getPriceSpike(),
                product.getStartTime(), product.getEndTime());

        return "redirect:/product/list";
    }

    @RequestMapping(value = "/list/delete", method = RequestMethod.POST)
    public String delete_Product(@RequestParam(value ="productId") int product_id) {
        productService.deleteProduct(product_id);

        return "redirect:/product/list";
    }

    @RequestMapping(value = "/list/fix", method = RequestMethod.POST)
    public String fix_Product(Product product) {
        productService.updateProduct(product.getProductId(), product.getProductName(), product.getPhoto(), product.getDescription(),
                product.getPrice(), product.getStock(), product.getPriceSpike(),
                product.getStartTime(), product.getEndTime());
        return "redirect:/product/list";
    }






}