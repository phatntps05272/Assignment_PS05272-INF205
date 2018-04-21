/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.sof302.controller;

import com.assignment.sof302.entities.User;
import java.util.Random;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author PhatNT
 */
@Transactional
@Controller
@RequestMapping("/dashboard/")
public class UserController {

    @Autowired
    SessionFactory sessionFactory;

    @Autowired
    JavaMailSenderImpl mailSender;

    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String login(ModelMap model,
            @CookieValue(value = "username", defaultValue = "") String username,
            @CookieValue(value = "password", defaultValue = "") String password,
            HttpSession httpSession) {
        if (!username.isEmpty() && !password.isEmpty()) {
            User login = loginRequest(new User(username, password));

            if (login != null) {
                httpSession.setAttribute("user", login);
                return "redirect:/dashboard/index.html";
            }
        }
        model.addAttribute("account", new User());
        return "login";
    }

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(ModelMap model,
            @ModelAttribute("account") User account,
            HttpSession httpSession,
            HttpServletRequest req,
            HttpServletResponse res) {
        User login = loginRequest(account);
        if (login != null) {
            httpSession.setAttribute("user", login);

            if (req.getParameter("remember") != null) {
                Cookie ckUser = new Cookie("username", account.getUsername());
                ckUser.setMaxAge(3600);
                res.addCookie(ckUser);
                Cookie ckPass = new Cookie("password", account.getPassword());
                ckPass.setMaxAge(3600);
                res.addCookie(ckPass);
            }
            return "redirect:/dashboard/index.html";
        }

        model.addAttribute("message", "error");
        return "login";
    }

    @RequestMapping(value = "changePwd")
    public String changPwd(HttpSession httpSession,
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("fullname") String fullname,
            @RequestParam("email") String email,
            HttpServletRequest request,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {

        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try {
            User user = new User(username, password, fullname, email);
            session.update(user);
            t.commit();
            httpSession.removeAttribute("user");
            redirectAttributes.addFlashAttribute("message", "changePwd");
            return "redirect:/dashboard/login.html";
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return "redirect:" + request.getHeader("Referer");
    }

    @RequestMapping("logout")
    public String logout(HttpSession httpSession,
            HttpServletRequest req,
            HttpServletResponse res,
            RedirectAttributes redirectAttributes) {

        httpSession.removeAttribute("user");
        for (Cookie cookie : req.getCookies()) {
            if (cookie.getName().equalsIgnoreCase("username")) {
                cookie.setMaxAge(0);
                res.addCookie(cookie);
            }
            if (cookie.getName().equalsIgnoreCase("password")) {
                cookie.setMaxAge(0);
                res.addCookie(cookie);
            }
        }
        redirectAttributes.addFlashAttribute("message", "logOut");
        return "redirect:/dashboard/login.html";
    }

    @RequestMapping(value = "forgotPwd", method = RequestMethod.GET)
    public String forgotPwd() {
        return "forgotPwd";
    }

    @RequestMapping(value = "forgotPwd", method = RequestMethod.POST)
    public String forgotPwd(ModelMap model, @RequestParam("email") String email) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        String newPwd = randomPwd();
        try {
            Query query = session.createQuery("from User where email=:email");
            query.setParameter("email", email);
            User user = (User) query.uniqueResult();
            user.setPassword(newPwd);
            session.update(user);
            t.commit();
            mailSender.send(new MimeMessagePreparator() {
                @Override
                public void prepare(MimeMessage mimeMessage) throws Exception {
                    MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
                    messageHelper.setTo(email);
                    messageHelper.setSubject("Reset your password");
                    messageHelper.setText("Dear " + user.getFullname() + ", <br/><br/>"
                            + "Your new account details are:<br/>Username: <b>" + user.getUsername() + "</b><br/>"
                            + "Password: <b>" + newPwd + "</b><br/><br/>"
                            + "If you have any questions or trouble logging on please contact a site administrator.<br/><br/>"
                            + "Thank you!", true);
                }
            });
            model.addAttribute("message", "success");

        } catch (Exception ex) {
            t.rollback();
            model.addAttribute("message", "error");
        } finally {
            session.close();
        }
        return "forgotPwd";
    }

    private String randomPwd() {
        String aToZ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        Random rand = new Random();
        StringBuilder res = new StringBuilder();
        for (int i = 0; i < 7; i++) {
            int randIndex = rand.nextInt(aToZ.length());
            res.append(aToZ.charAt(randIndex));
        }
        return res.toString();
    }

    private User loginRequest(User account) {
        Session session = sessionFactory.getCurrentSession();
        try {
            User user = (User) session.get(User.class, account.getUsername());
            if (user.getPassword().equals(account.getPassword())) {
                return user;
            } else {
                return null;
            }
        } catch (Exception ex) {
            return null;
        }
    }

}
