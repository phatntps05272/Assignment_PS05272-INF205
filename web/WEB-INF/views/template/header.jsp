<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Header -->
<header id="topnav">
    <div class="topbar-main">
        <div class="container">

            <!-- LOGO -->
            <div class="topbar-left">
                <a href="index.html" class="logo">
                    <i class="zmdi zmdi-group-work icon-c-logo"></i>
                    <span>Uplon</span>
                </a>
            </div>
            <!-- End Logo container-->


            <div class="menu-extras">

                <ul class="nav navbar-nav pull-right">

                    <li class="nav-item">
                        <!-- Mobile menu toggle-->
                        <a class="navbar-toggle">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </a>
                        <!-- End mobile menu toggle-->
                    </li>

                    <li class="nav-item dropdown notification-list">
                        <a href="#contactModal" class="nav-link waves-effect waves-light right-bar-toggle" data-toggle="modal" title="<spring:message code="header.contact"/>">
                            <i class="zmdi zmdi-email noti-icon"></i>
                        </a>
                    </li>
                    <li class="nav-item dropdown notification-list">
                        <a class="nav-link dropdown-toggle arrow-none waves-light waves-effect" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false" title="<spring:message code="header.language"/>">
                            <i class="zmdi zmdi-globe noti-icon"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-arrow profile-dropdown " aria-labelledby="Preview">
                            <!-- item-->
                            <div class="dropdown-item noti-title bg-success">
                                <h5><small><spring:message code="header.language"/></small></h5>
                            </div>

                            <!-- item-->
                            <a href="?lang=vi" class="dropdown-item notify-item">
                                <span>
                                    <img src="../assets/images/flags/vn.jpg" style="width: 30px; margin-right: 5px">
                                </span>
                                <span>
                                    <b><spring:message code="header.language.vi"/></b>                                    
                                </span>
                            </a>

                            <!-- item-->
                            <a href="?lang=en" class="dropdown-item notify-item">
                                <span>
                                    <img src="../assets/images/flags/us.jpg" style="width: 30px; margin-right: 5px">
                                </span>
                                <span>
                                    <b><spring:message code="header.language.en"/></b>
                                </span>
                            </a>
                        </div>
                    </li>

                    <li class="nav-item dropdown notification-list">
                        <a class="nav-link dropdown-toggle arrow-none waves-effect waves-light nav-user" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false" title="<spring:message  code="header.account"/>">
                            <span style="color: white;"><spring:message code="header.account.welcome"/> <b>${user.fullname}</b></span>

                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-arrow profile-dropdown " aria-labelledby="Preview">
                            <!-- item-->
                            <div class="dropdown-item noti-title">
                                <h5 class="text-overflow"><small><b>${user.fullname}</b></small> </h5>
                            </div>
                            <!-- item-->
                            <a href="#changePwdModal" data-toggle="modal" class="dropdown-item notify-item">
                                <i class="zmdi zmdi-account-circle"></i> <span><spring:message code="header.account.profile"/></span>
                            </a>

                            <!-- item-->
                            <a href="logout.html" class="dropdown-item notify-item">
                                <i class="zmdi zmdi-power"></i> <span><spring:message code="header.account.logout"/></span>
                            </a>

                        </div>
                    </li>

                </ul>

            </div> <!-- end menu-extras -->
            <div class="clearfix"></div>

        </div> <!-- end container -->
    </div>
    <!-- end topbar-main -->


    <div class="navbar-custom active">
        <div class="container">
            <div id="navigation" class="active">
                <!-- Navigation Menu-->
                <ul class="navigation-menu">
                    <li class="has-submenu ${current eq 'index' ? 'active':''}">
                        <a href="index.html"><i class="zmdi zmdi-view-dashboard"></i> <span> <spring:message code="header.menu.dashboard"/> </span> </a>
                    </li>

                    <li class="has-submenu ${current eq 'staff' ? 'active':''}">
                        <a href="staff.html"><i class="ion-ios7-people"></i> <span> <spring:message code="header.menu.managestaff"/>  </span> </a>
                    </li>
                    <li class="has-submenu ${current eq 'depart' ? 'active':''}">
                        <a href="depart.html"><i class="zmdi zmdi-city-alt"></i> <span> <spring:message code="header.menu.managedepart"/>  </span> </a>
                    </li>
                    <li class="has-submenu ${current eq 'record' ? 'active':''}">
                        <a href="record.html"><i class="zmdi zmdi-assignment"></i> <span> <spring:message code="header.menu.recordstaff"/>  </span> </a>
                    </li>
                    <li class="has-submenu ${current eq 'achievement' ? 'active':''}">
                        <a href="#"><i class="ion-pie-graph"></i> <span> <spring:message code="header.menu.achievement"/> </span> </a>
                        <ul class="submenu">
                            <li><a href="personal-achievement.html"><spring:message code="header.menu.achievement.personal"/></a></li>
                            <li><a href="department-achievement.html"><spring:message code="header.menu.achievement.depart"/></a></li>
                        </ul>
                    </li>
                </ul>
                <!-- End navigation menu  -->
            </div>
        </div>
    </div>
</header>
<!-- End header -->

