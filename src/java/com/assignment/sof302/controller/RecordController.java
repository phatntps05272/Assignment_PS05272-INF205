/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.assignment.sof302.controller;

import com.assignment.sof302.entities.Depart;
import com.assignment.sof302.entities.Record;
import com.assignment.sof302.entities.Staff;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.mail.internet.MimeMessage;
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
@RequestMapping("/dashboard/record")
public class RecordController {

    @Autowired
    SessionFactory sessionFactory;
    @Autowired
    JavaMailSenderImpl mailSender;

    @RequestMapping()
    public String recordPage(ModelMap model) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Record";
        Query query = session.createQuery(hql);
        List<Record> list = query.list();
        model.addAttribute("record", new Record());
        model.addAttribute("records", list);
        return "record";
    }

    @ModelAttribute("staffs")
    public List<Staff> getStaffs() {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Staff";
        Query query = session.createQuery(hql);
        List<Staff> list = query.list();
        return list;
    }

    @ModelAttribute("departs")
    public List<Depart> getDeparts() {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Depart";
        Query query = session.createQuery(hql);
        List<Depart> list = query.list();
        return list;
    }

    @RequestMapping(params = "depart", method = RequestMethod.GET)
    public String getStaffsByDepartId(ModelMap model,
            @ModelAttribute(value = "record") Record record,
            @RequestParam("id") int departId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Staff WHERE depart.id = " + departId;
        Query query = session.createQuery(hql);
        List<Staff> list = query.list();
        model.addAttribute("staffs", list);
        model.addAttribute("depId", departId);
        model.addAttribute("record", record);
        return recordPage(model);
    }

    @RequestMapping(params = "insert", method = RequestMethod.POST)
    public String insert(ModelMap model,
            @ModelAttribute("record") Record record,
            @RequestParam("dateInput") String dateInput) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try {
            Date date = new SimpleDateFormat("dd/MM/yyyy").parse(dateInput);
            record.setDate(date);
            session.save(record);
            t.commit();
            /* Get Staff from Record*/
            Staff staff = getStaff(record.getStaff().getId());
            /* Gửi mail đến nv */
            sendMail(staff, record);
            model.addAttribute("success", "insertRecord");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return recordPage(model);
    }

    @RequestMapping(params = "del", method = RequestMethod.GET)
    public String delete(ModelMap model, @RequestParam("id") int recordId) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try {
            Record record = (Record) session.get(Record.class, recordId);
            session.delete(record);
            t.commit();
            model.addAttribute("success", "deleteRecord");
        } catch (Exception ex) {
            t.rollback();
        } finally {
            session.close();
        }
        return recordPage(model);
    }

    private Staff getStaff(int id) {
        Session session = sessionFactory.getCurrentSession();
        return (Staff) session.get(Staff.class, id);
    }

    private void sendMail(Staff staff, Record record) {
        mailSender.send(new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
                messageHelper.setTo(staff.getEmail());
                messageHelper.setSubject("Record status notification");
                String type;
                if (record.isType() == true) {
                    type = "<b style='color:green'>Reward</b>";
                } else {
                    type = "<b style='color:red'>Discipline</b>";
                }
                String message = "<div style=\"width:800px\">\n"
                        + " <img width=\"300px\" src=\"http://fpt.edu.vn/Content/images/assets/Poly.png\" />\n"
                        + " <div style=\"background-color: #012d5a;color:#FFF;padding:10px 20px;font-size:20px\">Record Status Notification</div>\n"
                        + "     <div style=\"background-color: #FFF;color:#191919;padding:10px 30px;font-size:16px;border: 3px solid #012d5a;line-height:22px\">\n"
                        + "         Dear <b>" + staff.getName() + " - " + staff.getId() + "</b>,"
                        + "         <br/>&nbsp;&nbsp;&nbsp;This email confirms that you have added a record:"
                        + "         <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b style=\"text-decoration:underline\">Type</b>: " + type
                        + "         <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b style=\"text-decoration:underline\">Reason</b>: " + record.getReason()
                        + "         <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b style=\"text-decoration:underline\">Date added</b>: " + new SimpleDateFormat("dd-MM-yyyy").format(record.getDate())
                        + "         <br/><br/>"
                        + "         If you feel you have received this e-mail in error, please contact a site administrator."
                        + "  </div>\n"
                        + "</div>";
                messageHelper.setText(message, true);
            }
        });
    }

}
