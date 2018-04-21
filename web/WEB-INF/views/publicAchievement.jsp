<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="wrapper">
    <div class="container">

        <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <div class="btn-group pull-right m-t-15">
                    <%--    
                       <a href="#addStaffModal" class="btn btn-primary" data-toggle="modal"><i class="zmdi zmdi-plus-circle"></i> <span>Add New</span></a>
                    --%>
                </div>
                <h4 class="page-title"><spring:message code="content.achievement.depart.title"/></h4>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-12">
                <div class="card-box table-responsive">                   

                    <table id="datatable" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th style="width: 120px;"><spring:message code="content.achievement.depart.code"/></th>
                                <th><spring:message code="content.achievement.depart.name"/></th>
                                <th><spring:message code="content.achievement.depart.reward"/></th>
                                <th><spring:message code="content.achievement.depart.discipline"/></th>
                                <th><spring:message code="content.achievement.depart.accumulate"/></th>
                                <th><spring:message code="content.achievement.depart.conclude"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${arrays}">
                                <tr>
                                    <td>${row[0]}</td>
                                    <th class="text-muted">${row[1]}</th>
                                    <td>${row[2]}</td>
                                    <td>${row[3]}</td>
                                    <c:set var="point" value="${row[2] - row[3]}"/>
                                    <td>${point}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${point > 0}">
                                                <i class="zmdi zmdi-thumb-up" style="color:#1bb99a"></i> <span style="color:#1bb99a"><spring:message code="content.achievement.depart.conclude.reward"/></span>
                                            </c:when>
                                            <c:when test="${point < 0}">
                                                <i class="zmdi zmdi-thumb-down" style="color:#ff5d48"></i> <span style="color:#ff5d48"><spring:message code="content.achievement.depart.conclude.discipline"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="zmdi zmdi-thumb-up-down" style="color:#f1b53d"></i> <span style="color:#f1b53d"><spring:message code="content.achievement.depart.conclude.none"/></span>
                                            </c:otherwise>
                                        </c:choose>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div> <!-- end row -->

    </div> <!-- container -->
</div> <!-- End wrapper -->

<script>
    $(document).ready(function () {

        //initialize datable
        var table = $('#datatable').DataTable({
            "lengthMenu": [[5, 20, 50, -1], [5, 20, 50, "<spring:message code="content.select.all"/>"]],
            "language": {
                "lengthMenu": "<spring:message code="content.table.slengthmenu"/>",
                "zeroRecords": "<spring:message code="content.table.szerorecords"/>",
                "info": "<spring:message code="content.table.sinfo"/>",
                "infoEmpty": "<spring:message code="content.table.sinfo.empty"/>",
                "search": "<spring:message code="content.table.ssearch"/>",
                "paginate": {
                    "first": "<spring:message code="content.table.opaginate.sfirst"/>",
                    "last": "<spring:message code="content.table.opaginate.slast"/>",
                    "next": "<spring:message code="content.table.opaginate.snext"/>",
                    "previous": "<spring:message code="content.table.opaginate.sprevios"/>"
                }
            }
        });
    });
</script>
