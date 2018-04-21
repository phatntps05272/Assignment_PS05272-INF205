/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.sof302.controller;

import com.assignment.sof302.entities.Depart;
import com.assignment.sof302.entities.Staff;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletContext;
import org.apache.commons.io.FilenameUtils;
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
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author PhatNT
 */
@Transactional
@Controller
@RequestMapping("/dashboard/staff")
public class StaffController {

    @Autowired
    SessionFactory sessionFactory;
    @Autowired
    ServletContext context;

    @RequestMapping()
    public String staffPage(ModelMap model) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Staff";
        Query query = session.createQuery(hql);
        List<Staff> list = query.list();
        model.addAttribute("staff", new Staff());
        model.addAttribute("staffs", list);
        return "staff";
    }

    @RequestMapping(params = "insert", method = RequestMethod.POST)
    public String insert(ModelMap model, @ModelAttribute("staff") Staff staff, @RequestParam("dob") String dateInput,
            @RequestParam("avatar") MultipartFile avatar) throws Exception {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        String photo;
        try {
            if (avatar.isEmpty() || avatar.getOriginalFilename().equalsIgnoreCase("no-avatar.jpg")) {
                photo = "assets/images/users/no-avatar.jpg";
            } else {
                //Rename and upload images
                String photoName = String.valueOf(getLastId() + 1);
                String photoPath = context.getRealPath("/assets/images/users/");
                File file = new File(photoPath + avatar.getOriginalFilename());
                File renameFile = new File(photoPath + photoName + "." + FilenameUtils.getExtension(file.getName()));
                avatar.transferTo(renameFile);
                if (renameFile.exists()) {
                    renameFile.delete();
                }
                photo = "assets/images/users/" + renameFile.getName();
            }

            //Add photo and birthday to object           
            staff.setPhoto(photo);
            Date birthday = new SimpleDateFormat("dd/MM/yyyy").parse(dateInput);
            staff.setBirthday(birthday);

            //Insert object to database
            session.save(staff);
            t.commit();
            model.addAttribute("success", "insertStaff");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return staffPage(model);
    }

    @RequestMapping(params = "update", method = RequestMethod.POST)
    public String update(ModelMap model, @ModelAttribute("staff") Staff staff, @RequestParam("dob") String dateInput,
            @RequestParam("avatarTemp") String avatarTemp,
            @RequestParam("avatar") MultipartFile avatar) throws Exception {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        String photo;
        try {
            if (avatar.isEmpty() || avatar.getOriginalFilename().equalsIgnoreCase("no-avatar.jpg")) {
                photo = avatarTemp;
            } else {
                //Rename and upload images
                String photoName = String.valueOf(staff.getId());
                String photoPath = context.getRealPath("/assets/images/users/");
                File file = new File(photoPath + avatar.getOriginalFilename());
                File renameFile = new File(photoPath + photoName + "." + FilenameUtils.getExtension(file.getName()));
                if (renameFile.exists()) {
                    renameFile.delete();
                }
                avatar.transferTo(renameFile);
                photo = "assets/images/users/" + renameFile.getName();
            }

            //Add photo and birthday to object
            staff.setPhoto(photo);
            Date birthday = new SimpleDateFormat("dd/MM/yyyy").parse(dateInput);
            staff.setBirthday(birthday);

            //Insert object to database
            session.update(staff);
            t.commit();
            model.addAttribute("success", "updateStaff");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return staffPage(model);
    }

    @RequestMapping(params = "edit", method = RequestMethod.GET)
    public String edit(ModelMap model, @RequestParam("id") int staffId) {
        SimpleDateFormat dt1 = new SimpleDateFormat("dd/MM/yyyy");
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Staff";
        Query query = session.createQuery(hql);
        List<Staff> list = query.list();
        Staff staff = (Staff) session.get(Staff.class, staffId);
        model.addAttribute("staff", staff);
        model.addAttribute("dob", dt1.format(staff.getBirthday()));
        model.addAttribute("avatar", staff.getPhoto());
        model.addAttribute("staffs", list);
        return "staff";
    }

    @RequestMapping(params = "del", method = RequestMethod.GET)
    public String delete(ModelMap model, @RequestParam("id") int staffId) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try {
            Staff staff = (Staff) session.get(Staff.class, staffId);
            session.delete(staff);
            t.commit();
            model.addAttribute("success", "deleteStaff");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return staffPage(model);
    }

    @ModelAttribute("departs")
    public List<Depart> getDeparts() {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Depart";
        Query query = session.createQuery(hql);
        List<Depart> list = query.list();
        return list;
    }

    private int getLastId() {
        Session session = sessionFactory.getCurrentSession();
        try {
            Query query = session.createSQLQuery("SELECT Max(Id) FROM Staff");
            return (int) query.uniqueResult();
        } catch (Exception ex) {
        }
        return 0;
    }

}
