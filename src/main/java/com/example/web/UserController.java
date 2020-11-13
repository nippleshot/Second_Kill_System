package com.example.web;

import com.example.domain.User;
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


@Controller
@RequestMapping(value = "/user")
public class UserController {

    private UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String show_Login(Model model) {
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
                redirect.addFlashAttribute("manager", find_user);
                return "redirect:/main/list/manager";

            }else if(find_user.getPrivilege() == 0){
                redirect.addFlashAttribute("user", find_user);
                return "redirect:/main/list/user";
            }
        }else{
            return "redirect:/login";
        }

        return null;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user, RedirectAttributes redirect) {
        String userName = user.getUserName();
        String password = user.getPassword();
        // register user (No Error)
        userService.register(userName, password);

        User new_user = userService.findUserByUserName(userName);


        // redirect immediately to main/list
        redirect.addAttribute("userId", new_user.getUserId());
        redirect.addAttribute("userName", new_user.getUserName());
        redirect.addAttribute("userBalance", new_user.getBalance());
        return "redirect:/main/list/user";
    }

    @RequestMapping(value = "/charge", method = RequestMethod.GET)
    public String charge(@RequestParam(value ="userId") int user_id, Model model) {
        User user = userService.findUserByUserId(user_id);
        model.addAttribute("user", user);
        return "charge";
    }

    @RequestMapping(value = "/charge", method = RequestMethod.POST)
    public String charge(User user, RedirectAttributes redirect) {
        userService.recharge((int)user.getBalance(),user.getUserId());

        User after_charge = userService.findUserByUserId(user.getUserId());
        redirect.addAttribute("user", after_charge);
        return "redirect:/main/list/user";
    }


}