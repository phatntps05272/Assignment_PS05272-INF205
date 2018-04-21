<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- footer -->
<footer class="footer text-right">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                2016 © Uplon.
            </div>
        </div>
    </div>
</footer>
<!-- end footer -->

<!-- Contact modal -->
<div id="contactModal" class="modal fade">
    <div class="modal-dialog contact-modal">
        <div class="modal-content">
            <div class="modal-header">				
                <h4 class="modal-title"><spring:message code="header.contact.title"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <form action="contact.html" method="POST">
                <div class="modal-body">                
                    <div class="form-group">
                        <label for="inputName"><spring:message code="header.contact.name"/></label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail"><spring:message code="header.contact.email"/></label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="inputSubject"><spring:message code="header.contact.subject"/></label>
                        <input type="text" class="form-control" name="subject" required>
                    </div>
                    <div class="form-group">
                        <label for="inputMessage"><spring:message code="header.contact.content"/></label>
                        <textarea class="form-control" name="content" rows="4" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" value="${pageContext.request.requestURI}">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal"><spring:message code="content.button.cancel"/></button>
                    <input name="send" type="submit" class="btn btn-purple" value="<spring:message code="content.button.send"/>">
                </div>
            </form>

        </div>
    </div>
</div>

<!-- Change pass modal -->
<div id="changePwdModal" class="modal fade">
    <div class="modal-dialog contact-modal" style="max-width: none">
        <div class="modal-content">
            <div class="modal-header">				
                <h4 class="modal-title"><spring:message code="header.account.profile.title"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <form action="changePwd.html" id="changePwd" method="POST">
                <div class="modal-body">                     
                    <div class="form-group row">
                        <label class="col-sm-3 form-control-label"><spring:message code="header.account.profile.username"/></label>
                        <div class="col-sm-9">
                            <span style="line-height: 31px; font-weight: 500">${user.username}</span>
                            <input type="hidden" class="form-control" name="username" value="${user.username}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 form-control-label"><spring:message code="header.account.profile.email"/></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="email"  name="email" value="${user.email}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 form-control-label"><spring:message code="header.account.profile.fullname"/></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="fullname" name="fullname" value="${user.fullname}">
                        </div>
                    </div>
                    <hr/>
                    <div class="form-group row">
                        <label class="col-sm-3 form-control-label"><spring:message code="header.account.profile.currentpassword"/></label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="currentPwd">
                            <input type="hidden" class="form-control" id="oldPwd" value="${user.password}">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 form-control-label"><spring:message code="header.account.profile.newpassword"/></label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="newPwd" value="">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 form-control-label"><spring:message code="header.account.profile.renewpassword"/></label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="renewPwd" value="">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" value="${pageContext.request.requestURI}">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal"><spring:message code="content.button.cancel"/></button>
                    <input name="save" type="submit" class="btn btn-info" value="<spring:message code="content.button.save"/>">
                </div>
            </form>

        </div>
    </div>
</div>


<c:if test="${not empty success}">
    <div id="result">${success}</div>
</c:if>

<script type="text/javascript">
    $(document).ready(function () {

        var oldPwd = $('#oldPwd').val();
        $('#oldPwd').remove();

        $('#changePwd').submit(function () {
            var email = $('#email').val();
            var fullname = $('#fullname').val();
            var currentPwd = $('#currentPwd').val();
            var newPwd = $('#newPwd').val();
            var renewPwd = $('#renewPwd').val();
            var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

            var flag = true;

            $('#email').parent().children("ul").remove();
            $('#fullname').parent().children("ul").remove();
            $('#currentPwd').parent().children("ul").remove();
            $('#renewPwd').parent().children("ul").remove();
            $('#newPwd').parent().children("ul").remove();
            $('#renewPwd').parent().children("ul").remove();

            if (email == '') {
                $('#email').addClass("parsley-error");
                $('#email').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="changepwd.email.message.empty"/></li></ul>')
                flag = false;
            } else if (!emailReg.test(email)) {
                $('#email').addClass("parsley-error");
                $('#email').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="changepwd.email.message.valid"/></li></ul>')
                flag = false;
            } else {
                $('#email').removeClass("parsley-error");
            }

            if (fullname == '') {
                $('#fullname').addClass("parsley-error");
                $('#fullname').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="changepwd.fullname.message.empty"/></li></ul>')
                flag = false;
            } else {
                $('#fullname').removeClass("parsley-error");
            }

            if (oldPwd != currentPwd) {
                $('#currentPwd').addClass("parsley-error");
                $('#currentPwd').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="changepwd.password.message.match"/></li></ul>')
                flag = false;
            } else {
                $('#currentPwd').removeClass("parsley-error");
            }

            if (newPwd != '' && newPwd == currentPwd) {
                $('#newPwd').addClass("parsley-error");
                $('#newPwd').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="changepwd.newpassword.message.match"/></li></ul>')
                return false;
            } else {
                $('#newPwd').removeClass("parsley-error");
            }

            if ((newPwd != '' && renewPwd != '') || (newPwd != '' && renewPwd == '')) {
                if (newPwd != renewPwd) {
                    $('#newPwd').addClass("parsley-error");
                    $('#renewPwd').addClass("parsley-error");
                    $('#renewPwd').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="changepwd.renewpassword.message.match"/></li></ul>')
                    flag = false;
                } else {
                    $('#renewPwd').removeClass("parsley-error");
                    $('#newPwd').removeClass("parsley-error");
                }
            } else {
                $('#renewPwd').removeClass("parsley-error");
            }
            if (flag == false) {
                return false;
            }
            if (newPwd == '') {
                $('#currentPwd').after('<input type="hidden" name="password" value="' + currentPwd + '">');
            } else {
                $('#currentPwd').after('<input type="hidden" name="password" value="' + newPwd + '">');
            }
        });

        toasterOptions();
        var result = $('#result').html();
        $('#result').remove();

        switch (result) {
            case "contact":
                toastr.success("<spring:message code="header.contact.message.complete"/>");
                break;
            case "insertStaff":
                toastr.success("<spring:message code="content.managestaff.addnew.message.complete"/>");
                break;
            case "updateStaff":
                toastr.success("<spring:message code="content.managestaff.edit.message.complete"/>");
                break;
            case "deleteStaff":
                toastr.success("<spring:message code="content.managestaff.del.message.complete"/>");
                break;
            case "insertDepart":
                toastr.success("<spring:message code="content.managedepart.addnew.message.complete"/>");
                break;
            case "updateDepart":
                toastr.success("<spring:message code="content.managedepart.edit.message.complete"/>");
                break;
            case "deleteDepart":
                toastr.success("<spring:message code="content.managedepart.del.message.complete"/>");
                break;
            case "insertRecord":
                toastr.success("<spring:message code="content.recordstaff.addnew.message.complete"/>");
                break;
            case "deleteRecord":
                toastr.success("<spring:message code="content.recordstaff.del.message.complete"/>");
                break;
        }

    });

    function toasterOptions() {
        toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }
    }

</script>
