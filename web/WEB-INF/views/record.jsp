<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="wrapper">
    <div class="container">

        <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <div class="btn-group pull-right m-t-15">
                    <a href="#addRecordModal" class="btn btn-primary" data-toggle="modal"><i class="fa fa-plus-circle"></i> <span><spring:message code="content.button.addnew"/></span></a> 
                </div>
                <h4 class="page-title"><spring:message code="content.recordstaff.title"/></h4>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-12">
                <div class="card-box table-responsive">                   

                    <table id="datatable" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th style="width: 72px"><spring:message code="content.recordstaff.code"/></th>
                                <th><spring:message code="content.recordstaff.name"/></th>
                                <th><spring:message code="content.recordstaff.type"/></th>
                                <th><spring:message code="content.recordstaff.date"/></th>
                                <th><spring:message code="content.recordstaff.reason"/></th>
                                <th><spring:message code="content.recordstaff.action"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${records}">
                                <tr>
                                    <td>${row.staff.id}</td>
                                    <th class="text-muted">${row.staff.name}</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${row.type}">
                                                <spring:message code="content.recordstaff.type.reward"/>
                                            </c:when>
                                            <c:otherwise>
                                                <spring:message code="content.recordstaff.type.discipline"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><f:formatDate pattern="dd/MM/yyyy" value="${row.date}"/></td>
                                    <td>${row.reason}</td>
                                    <td style="text-align: center">
                                        <%-- <a href="?edit&id=${row.id}" class="edit" id="${row.id}" data-toggle="modal"><i class="zmdi  zmdi-edit" data-toggle="tooltip" title="Edit"></i></a> --%>
                                        <a href="?del&id=${row.id}" class="delete" data-toggle="modal"><i class="zmdi  zmdi-delete" data-toggle="tooltip" title="<spring:message code="content.a.del.title"/>"></i></a>
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

<!-- Add Modal HTML -->
<div id="addRecordModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form:form action="record.html" method="POST" id="frmAdd" modelAttribute="record">
                <div class="modal-header">						
                    <h4 class="modal-title"><spring:message code="content.recordstaff.addnew.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <div class="form-group">
                        <label><spring:message code="content.recordstaff.addnew.depart"/><span class="text-danger">*</span></label>      
                        <select class="form-control" id="depart" required="required">
                            <option value="0"><spring:message code="content.recordstaff.addnew.depart.message"/></option>
                            <c:forEach var="dep" items="${departs}">
                                <c:choose>
                                    <c:when test = "${depId == dep.id}">
                                        <option value="${dep.id}" selected="true">${dep.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${dep.id}">${dep.name}</option>
                                    </c:otherwise>
                                </c:choose>                                    
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group" id="staff">
                        <label><spring:message code="content.recordstaff.addnew.staff"/><span class="text-danger">*</span></label> 
                        <form:select path="staff.id" cssClass="form-control">
                            <option value="0"><spring:message code="content.recordstaff.addnew.staff.message"/></option>
                            <c:forEach var="emp" items="${staffs}">
                                <option value="${emp.id}">${emp.id} - ${emp.name}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <label><spring:message code="content.recordstaff.date"/><span class="text-danger">*</span></label><br/>
                        <label style="display: block">
                            <div class="input-group">
                                <input type="text" name="dateInput" class="form-control" placeholder="dd/MM/yyyy" id="datepicker">
                                <span class="input-group-addon bg-custom b-0"><i class="icon-calender"></i></span>
                            </div><!-- input-group -->
                        </label>
                    </div>
                    <div class="form-group">
                        <label><spring:message code="content.recordstaff.type"/></label><br/>
                        <label class="c-input c-radio">
                            <form:radiobutton path="type" value="false"/><spring:message code="content.recordstaff.type.discipline"/>
                            <span class="c-indicator"></span>
                        </label> 
                        <label class="c-input c-radio">
                            <form:radiobutton path="type" value="true"/><spring:message code="content.recordstaff.type.reward"/>
                            <span class="c-indicator"></span>
                        </label>
                    </div>

                    <div class="form-group">
                        <label><spring:message code="content.recordstaff.reason"/></label>
                        <form:textarea path="reason" cssClass="form-control" rows="4"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal"><spring:message code="content.button.cancel"/></button>
                    <input name="insert" type="submit" class="btn btn-success" value="<spring:message code="content.button.add"/>">
                </div>
            </form:form>
        </div>
    </div>
</div>

<!-- Delete Modal HTML -->
<div id="deleteModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <form>
                <div class="modal-header">						
                    <h4 class="modal-title"><spring:message code="content.recordstaff.del.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <p><spring:message code="content.recordstaff.del.message"/></p>
                    <p class="text-warning"><small><spring:message code="content.recordstaff.del.message.warning"/></small></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal"><spring:message code="content.button.cancel"/></button>
                    <a href="" class="btn btn-danger removeBtn"><spring:message code="content.button.del"/></a>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {

        $('#datepicker').datepicker({
            format: "dd/mm/yyyy",
            todayHighlight: true,
            autoclose: true
        });

        //validate form
        $('#frmAdd').submit(function () {
            var flag = true;
            var date = $('#datepicker').datepicker("getDate");
            var now = moment().format('DD/MM/YYYY');
            var then = moment(date).format('DD/MM/YYYY');

            $('#depart').parent().children("ul").remove();
            $('#staff').children("ul").remove();
            $('#datepicker').parent().parent().children("ul").remove();


            if ($('#depart').val() == 0) {
                $('#depart').addClass("parsley-error");
                $('#depart').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.recordstaff.addnew.depart.message.empty"/></li></ul>')
                flag = false;
            } else {
                $('#depart').removeClass("parsley-error");
            }

            if ($('#staff').children("select").val() == 0) {
                $('#staff').children("select").addClass("parsley-error");
                $('#staff').append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.recordstaff.addnew.staff.message.empty"/></li></ul>')
                flag = false;
            } else {
                $('#staff').children("select").removeClass("parsley-error");
            }

            if (date == '' || date == null) {
                $('#datepicker').addClass("parsley-error");
                $('#datepicker').parent().parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.recordstaff.date.message.empty"/></li></ul>')
                flag = false;
            } else if (then > now) {
                $('#datepicker').addClass("parsley-error");
                $('#datepicker').parent().parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.recordstaff.date.message.past"/></li></ul>')
                flag = false;
            } else {
                $('#datepicker').removeClass("parsley-error");
            }

            if (flag == false) {
                return false;
            }
        });

        //initialize date sorter dd/mm/yyyy
        $.fn.dataTable.moment = function (format, locale) {
            var types = $.fn.dataTable.ext.type;

            // Add type detection
            types.detect.unshift(function (d) {
                return moment(d, format, locale, true).isValid() ?
                        'moment-' + format :
                        null;
            });

            // Add sorting method - use an integer for the sorting
            types.order[ 'moment-' + format + '-pre' ] = function (d) {
                return moment(d, format, locale, true).unix();
            };
        };
        $.fn.dataTable.moment('DD/MM/YYYY');

        //initialize datable
        var table = $('#datatable').DataTable({
            lengthChange: false,
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

        //Add control
        $('#datatable_wrapper .col-md-6:eq(0)').html('<div id="dataTables_length" class="dataTables_length"><label><span><spring:message code="content.recordstaff.dateStart"/>: </span><input type="text" class="form-control" placeholder="mm/dd/yyyy" id="min"></label><label><span>&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="content.recordstaff.dateEnd"/>:&nbsp;&nbsp;</san><input type="text" class="form-control" placeholder="mm/dd/yyyy" id="max"></label></div>');
        //Set value control
        $("#datatable_wrapper .col-md-6:eq(0) #min").val(moment().subtract(7, 'd').format('DD/MM/YYYY'));
        $("#datatable_wrapper .col-md-6:eq(0) #max").val(moment().format('DD/MM/YYYY'));

        //initialize date filter
        $.fn.dataTable.ext.search.push(
                function (settings, data, dataIndex) {
                    var min = $('#datatable_wrapper .col-md-6:eq(0) #min').datepicker("getDate");
                    var max = $('#datatable_wrapper .col-md-6:eq(0) #max').datepicker("getDate");
                    // need to change str order before making  date obect since it uses a new Date("mm/dd/yyyy") format for short date.
                    var d = data[3].split("/");
                    var startDate = new Date(d[1] + "/" + d[0] + "/" + d[2]);

                    if (min == null && max == null) {
                        return true;
                    }
                    if (min == null && startDate <= max) {
                        return true;
                    }
                    if (max == null && startDate >= min) {
                        return true;
                    }
                    if (startDate <= max && startDate >= min) {
                        return true;
                    }
                    return false;
                }
        );

        $("#datatable_wrapper .col-md-6:eq(0) #min").datepicker({
            format: "dd/mm/yyyy",
            todayHighlight: true,
            autoclose: true,
            onSelect: function () {
                table.draw();
            }, changeMonth: true, changeYear: true, dateFormat: "dd/mm/yyyy", orientation: "top"});

        $("#datatable_wrapper .col-md-6:eq(0) #max").datepicker({
            format: "dd/mm/yyyy",
            todayHighlight: true,
            autoclose: true,
            onSelect: function () {
                table.draw();
            }, changeMonth: true, changeYear: true, dateFormat: "dd/mm/yyyy", orientation: "top"});

        // Event listener to the two range filtering inputs to redraw on input
        $('#datatable_wrapper .col-md-6:eq(0) #min, #datatable_wrapper .col-md-6:eq(0) #max').change(function () {
            table.draw();
        });

        //get Staff list by depart when value change
        $('#depart').change(function () {
            var departId = $(this).val();
            if (departId > 0) {
                var link = "?depart&id=" + $(this).val();
            } else {
                var link = $(location).attr('href');
            }

            $.get(link, function (data) {
                var result = $('<div />').append(data).find('#staff').html();
                $('#staff').html(result);
            });
        });

        /* Show delete modal */
        $("body").on("click", "#datatable .delete", function (e) {
            e.preventDefault();
            $("#deleteModal .removeBtn").attr("href", $(this).attr("href"));
            $("#deleteModal").modal();
        });

        table.draw();
    });
</script>