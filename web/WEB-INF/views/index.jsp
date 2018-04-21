<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="wrapper">
    <div class="container">

        <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">

                <h4 class="page-title"><spring:message code="content.dashboard.title"/></h4>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                <div class="card-box tilebox-two">
                    <i class="icon-dislike pull-xs-right text-muted" style="color:#ff0000"></i>
                    <h6 class="text-muted text-uppercase m-b-20"><spring:message code="content.dashboard.totaldiscipline"/></h6>
                    <h2 class="m-b-20"><span data-plugin="counterup">${totalDisciplines}</span></h2>
                </div>
            </div>

            <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                <div class="card-box tilebox-two">
                    <i class="icon-badge pull-xs-right text-muted" style="color:#00d8ae"></i>
                    <h6 class="text-muted text-uppercase m-b-20"><spring:message code="content.dashboard.totalreward"/></h6>
                    <h2 class="m-b-20"><span data-plugin="counterup">${totalRewards}</span></h2>
                </div>
            </div>

            <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                <div class="card-box tilebox-two">
                    <i class="icon-people pull-xs-right text-muted" style="color:#00abff"></i>
                    <h6 class="text-muted text-uppercase m-b-20"><spring:message code="content.dashboard.totalstaff"/></h6>
                    <h2 class="m-b-20" data-plugin="counterup">${totalStaffs}</h2>
                </div>
            </div>

            <div class="col-xs-12 col-md-6 col-lg-6 col-xl-3">
                <div class="card-box tilebox-two">
                    <i class="icon-layers pull-xs-right text-muted" style="color:#8938ef"></i>
                    <h6 class="text-muted text-uppercase m-b-20"><spring:message code="content.dashboard.totaldepart"/></h6>
                    <h2 class="m-b-20" data-plugin="counterup">${totalDeparts}</h2>
                </div>
            </div>
        </div>				
        <!-- end row -->


        <div class="row">
            <div class="col-xs-12 col-lg-12 col-xl-8">
                <div class="card-box">
                    <h4 class="header-title m-t-0 m-b-30"><spring:message code="content.dashboard.departsummary"/></h4>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-hover m-b-0">
                            <thead>
                                <tr>
                                    <th style="width: 120px"><spring:message code="content.dashboard.departsummary.code"/></th>
                                    <th><spring:message code="content.dashboard.departsummary.name"/></th>
                                    <th><spring:message code="content.dashboard.departsummary.total"/></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dep" items="${departSummary}">
                                    <tr>
                                        <td>${dep[0]}</td>
                                        <th class="text-muted">${dep[1]}</th>
                                        <td>${dep[2]}</td>
                                    </tr>
                                </c:forEach>                             

                            </tbody>
                        </table>
                    </div>


                </div>

            </div><!-- end col-->

            <div class="col-xs-12 col-lg-12 col-xl-4">
                <div class="card-box">
                    <h4 class="header-title m-t-0 m-b-20"><spring:message code="content.dashboard.ratingstaff"/></h4>

                    <div class="text-xs-center m-b-20">
                        <div id="monthItems" class="btn-group" role="group">
                            <button type="button" id="1" class="btn btn-sm btn-secondary active"><spring:message code="content.dashboard.ratingstaff.all"/></button>
                            <button type="button" id="2" class="btn btn-sm btn-secondary"><spring:message code="content.dashboard.ratingstaff.thismonth"/></button>
                            <button type="button" id="3" class="btn btn-sm btn-secondary"><spring:message code="content.dashboard.ratingstaff.lastmonth"/></button>
                        </div>
                    </div>

                    <div id="ratings" class="inbox-widget nicescroll" style="height: 320px;">
                        <c:set var="id" value="0"/>
                        <c:forEach var="row" items="${bestStaffs}">
                            <c:set var="id" value="${id + 1}"/>
                            <a href="#">
                                <div class="inbox-item">
                                    <div class="inbox-item-img"><img src="../${row[1]}" class="img-circle" style="width:40px; height: 40px" alt="${row[0]}"></div>
                                    <p class="inbox-item-author"><b class="text-muted">${row[0]}</b></p>
                                    <p class="inbox-item-text">${row[2]}</p>
                                    <p class="inbox-item-date">Top ${id}</p>
                                </div>
                            </a>
                        </c:forEach>                       
                    </div>
                </div>
            </div><!-- end col-->

        </div>
        <!-- end row -->

    </div> <!-- container -->

</div> <!-- End wrapper -->



<script type="text/javascript">
    $(document).ready(function () {

        //Department Summary
        $('#datatable').DataTable({
            "lengthMenu": [[5, 10, 50, -1], [5, 10, 50, "<spring:message code="content.select.all"/>"]],
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


        $('#monthItems button').click(function () {
            $('#monthItems button').removeClass("active");
            $(this).addClass("active");
            var link;
            var id = $(this).attr("id");

            var date = moment().format("YYYY-MM-DD");
            var startOfMonth = moment().startOf('month').format('YYYY-MM-DD');
            var startOfLastMonth = moment().subtract(1, 'month').startOf('month').format('YYYY-MM-DD');
            var endOfLastMonth = moment().subtract(1, 'month').endOf('month').format('YYYY-MM-DD');

            if (id == 1) {
                link = "";
            } else if (id == 2) {
                link = "?dateFilter&dateStart=" + startOfMonth + "&dateEnd=" + date;
            } else {
                link = "?dateFilter&dateStart=" + startOfLastMonth + "&dateEnd=" + endOfLastMonth;
            }
            $.get(link, function (data) {
                var result = $('<div />').append(data).find('#ratings').html();
                $('#ratings').html(result);
            });
        });

    });
</script>

<!-- Counter Up  -->
<script src="../assets/plugins/waypoints/lib/jquery.waypoints.js"></script>
<script src="../assets/plugins/counterup/jquery.counterup.min.js"></script>

