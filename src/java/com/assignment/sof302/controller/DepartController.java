/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.sof302.controller;

import com.assignment.sof302.entities.Depart;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author PhatNT
 */
@Transactional
@Controller
@RequestMapping("/dashboard/depart")
public class DepartController {
    
    @Autowired
    SessionFactory sessionFactory;
    
    @RequestMapping()
    public String departPage(ModelMap model) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Depart";
        Query query = session.createQuery(hql);
        List<Depart> list = query.list();
        model.addAttribute("depart", new Depart());
        model.addAttribute("departs", list);
        return "depart";
    }
    
    @RequestMapping(params = "insert", method = RequestMethod.POST)
    public String insert(ModelMap model, @ModelAttribute("depart") Depart depart) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try {
            session.save(depart);
            t.commit();
            model.addAttribute("success", "insertDepart");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return departPage(model);
    }
    
    @RequestMapping(params = "update", method = RequestMethod.POST)
    public String update(ModelMap model, @ModelAttribute("depart") Depart depart) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try {
            session.update(depart);
            t.commit();
            model.addAttribute("success", "updateDepart");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return departPage(model);
    }
    
    @RequestMapping(params = "edit", method = RequestMethod.GET)
    public String edit(ModelMap model, @RequestParam("id") int departId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Depart";
        Query query = session.createQuery(hql);
        List<Depart> list = query.list();
        Depart depart = (Depart) session.get(Depart.class, departId);
        model.addAttribute("depart", depart);
        model.addAttribute("departs", list);
        return "depart";
    }
    
    @RequestMapping(params = "del", method = RequestMethod.GET)
    public String delete(ModelMap model, @RequestParam("id") int departId) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try {
            Depart depart = (Depart) session.get(Depart.class, departId);
            session.delete(depart);
            t.commit();
            model.addAttribute("success", "deleteDepart");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return departPage(model);
    }
    
}
