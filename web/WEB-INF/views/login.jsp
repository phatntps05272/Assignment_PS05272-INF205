<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="account-pages"></div>
<div class="clearfix"></div>
<div class="wrapper-page">
    <div class="account-bg">
        <div class="card-box m-b-0">
            <div class="text-xs-center m-t-20">
                <a href="index.html" class="logo">
                    <i class="zmdi zmdi-group-work icon-c-logo"></i>
                    <span>Uplon</span>
                </a>
            </div>
            <div class="m-t-30 m-b-20">
                <div class="col-xs-12 text-xs-center">
                    <h6 class="text-muted text-uppercase m-b-0 m-t-0">Sign In</h6>
                </div>
                <form class="form-horizontal m-t-20" action="login.html" method="POST" modelAttribute="account">

                    <div class="form-group ">
                        <div class="col-xs-12">
                            <input class="form-control" type="text" name="username" required="" placeholder="Username">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-12">
                            <input class="form-control" type="password" name="password" required="" placeholder="Password">
                        </div>
                    </div>

                    <div class="form-group ">
                        <div class="col-xs-12">
                            <div class="checkbox checkbox-custom">
                                <input id="checkbox-signup" name="remember" type="checkbox">
                                <label for="checkbox-signup">
                                    Remember me
                                </label>
                            </div>

                        </div>
                    </div>

                    <div class="form-group text-center m-t-30">
                        <div class="col-xs-12">
                            <button class="btn btn-success btn-block waves-effect waves-light" type="submit">Log In</button>
                        </div>
                    </div>

                    <div class="form-group m-t-30 m-b-0">
                        <div class="col-sm-12">
                            <a href="forgotPwd.html" class="text-muted"><i class="fa fa-lock m-r-5"></i> Forgot your password?</a>
                        </div>
                    </div>

                    <%--
                    <div class="form-group m-t-30 m-b-0">
                        <div class="col-sm-12 text-xs-center">
                            <h5 class="text-muted"><b>Sign in with</b></h5>
                        </div>
                    </div>
                    
                    <div class="form-group m-b-0 text-xs-center">
                        <div class="col-sm-12">
                            <button type="button" class="btn btn-facebook waves-effect waves-light m-t-20">
                                <i class="fa fa-facebook m-r-5"></i> Facebook
                            </button>

                            <button type="button" class="btn btn-twitter waves-effect waves-light m-t-20">
                                <i class="fa fa-twitter m-r-5"></i> Twitter
                            </button>

                            <button type="button" class="btn btn-googleplus waves-effect waves-light m-t-20">
                                <i class="fa fa-google-plus m-r-5"></i> Google+
                            </button>
                        </div>
                    </div>
                    --%>

                </form>

            </div>
        </div>
    </div>
    <!-- end card-box-->

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
            case "successForgotPwd":
                toastr.success("<spring:message code="forgotpwd.message.complete"/>");
                break;
            case "error":
                toastr.error("<spring:message code="login.message.valid"/>");
                break;
            case "permissions":
                toastr.error("<spring:message code="login.message.permissions"/>");
                break;
            case "logOut":
                toastr.error("<spring:message code="logout.message.complete"/>");
                break;
            case "changePwd":
                toastr.success("<spring:message code="changepwd.message.complete"/>");
                break;
            default:
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