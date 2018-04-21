/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.sof302.controller;

import java.util.List;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author PhatNT
 */
@Transactional
@Controller
@RequestMapping("/dashboard/")
public class DashboardController {

    @Autowired
    SessionFactory sessionFactory;
    @Autowired
    JavaMailSenderImpl mailSender;

    @RequestMapping("index")
    public String dashboardPage(ModelMap model) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT r.staff.name, r.staff.photo, r.staff.depart.name"
                + " FROM Record r"
                + " GROUP BY r.staff.name, r.staff.photo, r.staff.depart.name"
                + " HAVING SUM(case when r.type=1 then 1 else 0 end) - SUM(case when r.type=0 then 1 else 0 end) >= 0"
                + " ORDER BY SUM(case when r.type=1 then 1 else 0 end) - SUM(case when r.type=0 then 1 else 0 end) DESC, SUM(case when r.type=0 then 1 else 0 end) ASC";
        Query query = session.createQuery(hql);
        query.setMaxResults(10);
        List<Object[]> list = query.list();
        model.addAttribute("bestStaffs", list);
        model.addAttribute("totalDisciplines", getTotalDisciplines());
        model.addAttribute("totalRewards", getTotalRewards());
        model.addAttribute("totalStaffs", getTotalStaffs());
        model.addAttribute("totalDeparts", getTotalDeparts());
        return "index";
    }

    @RequestMapping(value = "index", params = "dateFilter")
    public String dashboardPage(ModelMap model,
            @RequestParam(value = "dateStart") String dateStart,
            @RequestParam(value = "dateEnd") String dateEnd) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT r.staff.name, r.staff.photo, r.staff.depart.name"
                + " FROM Record r WHERE r.date BETWEEN :dateStart AND :dateEnd"
                + " GROUP BY r.staff.name, r.staff.photo, r.staff.depart.name"
                + " HAVING SUM(case when r.type=1 then 1 else 0 end) - SUM(case when r.type=0 then 1 else 0 end) >= 0"
                + " ORDER BY SUM(case when r.type=1 then 1 else 0 end) - SUM(case when r.type=0 then 1 else 0 end) DESC, SUM(case when r.type=0 then 1 else 0 end) ASC";
        Query query = session.createQuery(hql);
        query.setString("dateStart", dateStart);
        query.setString("dateEnd", dateEnd);
        query.setMaxResults(10);
        List<Object[]> list = query.list();
        model.addAttribute("bestStaffs", list);
        return "index";
    }

    @ModelAttribute("departSummary")
    public List<Object[]> getDepartSummary() {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT s.depart.id, s.depart.name, COUNT(s.id) FROM Staff s"
                + " GROUP BY s.depart.id, s.depart.name";
        Query query = session.createQuery(hql);
        List<Object[]> list = query.list();
        return list;
    }

    @RequestMapping(value = "personal-achievement")
    public String personalPage(ModelMap model) {
        Session session = sessionFactory.getCurrentSession();

        String hql = "SELECT r.staff.id, r.staff.name,"
                + "SUM(case when r.type=1 then 1 else 0 end),"
                + "SUM(case when r.type=0 then 1 else 0 end)"
                + " FROM Record r"
                + " GROUP BY r.staff.id, r.staff.name";
        Query query = session.createQuery(hql);
        List<Object[]> list = query.list();
        model.addAttribute("arrays", list);
        return "privateAchievement";
    }

    @RequestMapping(value = "personal-achievement", params = "personal-details")
    public String personalDetails(ModelMap model,
            @RequestParam("staffId") int staffId) {
        Session session = sessionFactory.getCurrentSession();

        String hql = " FROM Record r WHERE r.staff.id = " + staffId;
        Query query = session.createQuery(hql);
        List<Object[]> list = query.list();
        model.addAttribute("details", list);
        return "privateAchievement";
    }

    @RequestMapping(value = "department-achievement")
    public String departmentPage(ModelMap model) {
        Session session = sessionFactory.getCurrentSession();

        String hql = "SELECT r.staff.depart.id, r.staff.depart.name,"
                + "SUM(case when r.type=1 then 1 else 0 end),"
                + "SUM(case when r.type=0 then 1 else 0 end)"
                + " FROM Record r"
                + " GROUP BY r.staff.depart.id, r.staff.depart.name";
        Query query = session.createQuery(hql);
        List<Object[]> list = query.list();
        model.addAttribute("arrays", list);
        return "publicAchievement";
    }

    @RequestMapping(value = "contact")
    public String contact(ModelMap model, @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("subject") String subject,
            @RequestParam("content") String content,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        mailSender.send(new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
                messageHelper.setFrom(email);
                messageHelper.setTo(mailSender.getUsername());
                messageHelper.setSubject(subject);
                messageHelper.setText(content);
            }
        });
        redirectAttributes.addFlashAttribute("success", "contact");
        return "redirect:" + request.getHeader("Referer"); //return to previous page
    }

    public int getTotalDisciplines() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Record r WHERE r.type = 0").list().size();
    }

    public int getTotalRewards() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Record r WHERE r.type = 1").list().size();
    }

    public int getTotalStaffs() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Staff").list().size();
    }

    public int getTotalDeparts() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Depart").list().size();
    }

}
