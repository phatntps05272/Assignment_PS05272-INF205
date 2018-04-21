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
                    <%-- <a href="#addStaffModal" class="btn btn-primary" data-toggle="modal"><i class="zmdi zmdi-plus-circle"></i> <span>Add New</span></a>
                    --%>
                </div>
                <h4 class="page-title"><spring:message code="content.achievement.personal.title"/></h4>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-12">
                <div class="card-box table-responsive">                   

                    <table id="datatable" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th style="width: 72px"><spring:message code="content.achievement.personal.code"/></th>
                                <th><spring:message code="content.achievement.personal.name"/></th>
                                <th><spring:message code="content.achievement.personal.reward"/></th>
                                <th><spring:message code="content.achievement.personal.discipline"/></th>
                                <th><spring:message code="content.achievement.personal.accumulate"/></th>
                                <th><spring:message code="content.achievement.personal.conclude"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${arrays}">
                                <tr>

                                    <td>${row[0]}</td>

                                    <th> <a href="?personal-details&staffId=${row[0]}" id="details" data-toggle="modal" class="text-muted"> ${row[1]}</a></th>

                                    <td>${row[2]}</td>
                                    <td>${row[3]}</td>
                                    <c:set var="point" value="${row[2] - row[3]}"/>
                                    <td>${point}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${point > 0}">
                                                <i class="zmdi zmdi-thumb-up" style="color:#1bb99a"></i> <span style="color:#1bb99a"><spring:message code="content.achievement.personal.conclude.reward"/></span>
                                            </c:when>
                                            <c:when test="${point < 0}">
                                                <i class="zmdi zmdi-thumb-down" style="color:#ff5d48"></i> <span style="color:#ff5d48"><spring:message code="content.achievement.personal.conclude.discipline"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="zmdi zmdi-thumb-up-down" style="color:#f1b53d"></i> <span style="color:#f1b53d"><spring:message code="content.achievement.personal.conclude.none"/></span>
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

<!-- Personal  -->
<div id="detailModal" class="modal fade">
    <div class="modal-dialog modal-lg" style="max-width: none">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel"></h4>
            </div>
            <div class="modal-body">             
                <table id="detailTable" class="table table-hover">
                    <thead>
                        <tr>
                            <th><spring:message code="content.achievement.personal.no"/></th>
                            <th><spring:message code="content.recordstaff.type"/></th>
                            <th><spring:message code="content.recordstaff.date"/></th>
                            <th><spring:message code="content.recordstaff.reason"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="id" value="0"/>
                        <c:forEach var="item" items="${details}">
                            <c:set var="id" value="${id + 1}"/>
                            <tr>
                                <td>${id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.type}">
                                            <spring:message code="content.recordstaff.type.reward"/>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code="content.recordstaff.type.discipline"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td id="resultName">${item.staff.name}</td>
                                <td>${item.date}</td>
                                <td>${item.reason}</td>
                            </tr>   
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal"><spring:message code="content.button.close"/></button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script>
    $(document).ready(function () {

        //initialize datable
        var table = $('#datatable').DataTable({
            "lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "<spring:message code="content.select.all"/>"]],
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

        $("#datatable").on("click", "tbody tr", function (e) {
            var link = $('th a', this).eq(0).attr("href");
            e.preventDefault();
            $.get(link, function (data) {
                var result = $('<div />').append(data).find('#detailModal').html();
                $('#detailModal').html(result);
                $('#detailModal #myModalLabel').text("<spring:message code="content.achievement.personal.details.title"/> " + $('#resultName').text());
                $('#detailModal #resultName').remove();
                $('#detailModal').modal();
                $('#detailModal #detailTable').DataTable({
                    "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "<spring:message code="content.select.all"/>"]],
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
        });

    });
</script>
