<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="account-pages"></div>
<div class="clearfix"></div>
<div class="wrapper-page">

    <div class="account-bg">
        <div class="card-box m-b-0">
            <div class="text-xs-center m-t-20">
                <a href="#" class="logo">
                    <i class="zmdi zmdi-group-work icon-c-logo"></i>
                    <span>Uplon</span>
                </a>
            </div>
            <div class="m-t-30 m-b-20">
                <div class="col-xs-12 text-xs-center">
                    <h6 class="text-muted text-uppercase m-b-0 m-t-0">Reset Password</h6>
                    <p class="text-muted m-b-0 font-13 m-t-20">Enter your email address and we'll send you an email with instructions to reset your password.  </p>
                </div>

                <form class="form-horizontal m-t-30" action="forgotPwd.html" method="POST">
                    <div class="form-group">
                        <div class="col-xs-12">
                            <input class="form-control" type="email" name="email" required="" placeholder="Enter email">
                        </div>
                    </div>

                    <div class="form-group text-center m-t-20 m-b-0">
                        <div class="col-xs-12">
                            <button class="btn btn-success btn-block waves-effect waves-light">Send Email</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <!-- end card-box-->

    <div class="m-t-20">
        <div class="text-xs-center">
            <p class="text-white">Return to<a href="login.html" class="text-white m-l-5"><b>Sign In</b></a></p>
        </div>
    </div>

</div>
<!-- end wrapper page -->
<c:if test="${not empty message}">
    <div id="result">${message}</div>
</c:if>

<script type="text/javascript">
    $(document).ready(function () {
        toasterOptions();
        var result = $('#result').html();
        $('#result').remove();
        switch (result) {
            case "success":
                toastr.success("<spring:message code="forgotpwd.message.complete"/>");
                break;
            case "error":
                toastr.error("<spring:message code="forgotpwd.message.error"/>");
                break;
        }
    });

    function toasterOptions() {
        toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-center",
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