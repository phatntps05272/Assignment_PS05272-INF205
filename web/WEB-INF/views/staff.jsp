<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<div class="wrapper">
    <div class="container">

        <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <div class="btn-group pull-right m-t-15">
                    <a href="#addStaffModal" class="btn btn-primary" data-toggle="modal"><i class="fa fa-plus-circle"></i> <span><spring:message code="content.button.addnew"/></span></a>
                </div>
                <h4 class="page-title"><spring:message code="content.managestaff.title"/></h4>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-12">
                <div class="card-box table-responsive">                   
                    <table id="datatable" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th style="width: 50px"><spring:message code="content.managestaff.code"/></th>
                                <th><spring:message code="content.managestaff.name"/></th>
                                <th><spring:message code="content.managestaff.gender"/></th>
                                <th><spring:message code="content.managestaff.birthday"/></th>						
                                <th><spring:message code="content.managestaff.email"/></th>						
                                <th><spring:message code="content.managestaff.phone"/></th>
                                <th><spring:message code="content.managestaff.salary"/></th>
                                <th><spring:message code="content.managestaff.notes"/></th>
                                <th><spring:message code="content.managestaff.departname"/></th>
                                <th><spring:message code="content.managestaff.action"/></th>
                            </tr>
                        </thead>
                        <tbody>   
                            <c:forEach var="row" items="${staffs}">
                                <tr>
                                    <td>${row.id}</td>
                                    <td><a href="#"><img src="../${row.photo}" class="avatar" alt="Avatar"> ${row.name}</a></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${row.gender}">
                                                <spring:message code="content.managestaff.gender.male"/>
                                            </c:when>
                                            <c:otherwise>
                                                <spring:message code="content.managestaff.gender.female"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><f:formatDate pattern="MMM dd, yyyy" value="${row.birthday}"/></td>                        
                                    <td>${row.email}</td>
                                    <td>${row.phone}</td>
                                    <td><f:formatNumber value="${row.salary}" currencySymbol="$" type="currency"/></td>
                                    <td>${row.notes}</td>
                                    <td>${row.depart.name}</td>
                                    <td style="text-align: center">
                                        <a href="?edit&id=${row.id}" class="edit" data-toggle="modal"><i class="zmdi  zmdi-edit" data-toggle="tooltip" title="<spring:message code="content.a.edit.title"/>"></i></a>
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
<div id="addStaffModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form:form action="staff.html" id="frmAdd" method="POST" modelAttribute="staff" enctype="multipart/form-data">
                <div class="modal-header">						
                    <h4 class="modal-title"><spring:message code="content.managestaff.addnew.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.fullname"/><span class="text-danger">*</span></label>
                                <form:input path="name" cssClass="form-control"/>
                            </div>
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.email"/><span class="text-danger">*</span></label>
                                <form:input path="email" cssClass="form-control" />
                            </div>
                        </div>        	
                    </div>   
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.gender"/></label>
                                <br/>
                                <label class="c-input c-radio">
                                    <form:radiobutton path="gender" value="false"/><spring:message code="content.managestaff.gender.female"/>
                                    <span class="c-indicator"></span>
                                </label> 
                                <label class="c-input c-radio">
                                    <form:radiobutton path="gender" value="true"/><spring:message code="content.managestaff.gender.male"/>
                                    <span class="c-indicator"></span>
                                </label>
                            </div>
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.birthday"/><span class="text-danger">*</span></label>
                                <label>
                                    <div class="input-group">
                                        <input type="text" name="dob" class="form-control" placeholder="dd/MM/yyyy" id="datepicker" style="max-width: 120px">
                                        <span class="input-group-addon bg-custom b-0"><i class="icon-calender"></i></span>
                                    </div><!-- input-group -->
                                </label>
                            </div>
                        </div>        	
                    </div>  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.avatar"/></label><br/>
                                <img src="../assets/images/users/no-avatar.jpg" id="imagePreview" style="width:99px; height: 75px;"/><br/>
                                <div class="input-group">
                                    <label class="input-group-btn" style="margin:0px;">                                    
                                        <span class="btn btn-primary">
                                            <spring:message code="content.button.browser"/>&hellip; <input name="avatar" id="imageUpload" type="file" style="display: none;" multiple >
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label><spring:message code="content.managestaff.phone"/></label>
                                    <form:input path="phone" cssClass="form-control"/> 
                                </div>
                                <div class="form-group">
                                    <label><spring:message code="content.managestaff.salary"/><span class="text-danger">*</span></label>
                                    <form:input path="salary" cssClass="form-control"/>
                                </div>
                            </div>
                        </div>        	
                    </div> 

                    <div class="form-group">
                        <label><spring:message code="content.managestaff.notes"/></label>
                        <form:textarea path="notes" cssClass="form-control" cols="6"/>
                    </div>
                    <div class="form-group">
                        <label><spring:message code="content.managestaff.departname"/></label>
                        <form:select path="depart.id" items="${departs}" cssClass="form-control" itemValue="id" itemLabel="name"/>
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

<!-- Edit Modal HTML -->
<div id="editStaffModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form:form action="staff.html" method="POST" modelAttribute="staff" enctype="multipart/form-data">
                <div class="modal-header">						
                    <h4 class="modal-title"><spring:message code="content.managestaff.edit.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">	
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.fullname"/><span class="text-danger">*</span></label>
                                <form:input path="name" cssClass="form-control"/>
                            </div>
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.email"/><span class="text-danger">*</span></label>
                                <form:input path="email" cssClass="form-control" />
                            </div>
                        </div>        	
                    </div>   
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.gender"/></label><br/>
                                <label class="c-input c-radio">
                                    <form:radiobutton path="gender" value="false"/><spring:message code="content.managestaff.gender.female"/>
                                    <span class="c-indicator"></span>
                                </label> 
                                <label class="c-input c-radio">
                                    <form:radiobutton path="gender" value="true"/><spring:message code="content.managestaff.gender.male"/>
                                    <span class="c-indicator"></span>
                                </label>
                            </div>
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.birthday"/><span class="text-danger">*</span></label>
                                <label>
                                    <div class="input-group">
                                        <input type="text" name="dob" class="form-control" placeholder="dd/MM/yyyy" id="datepicker" style="max-width: 120px" value="${dob}">
                                        <span class="input-group-addon bg-custom b-0"><i class="icon-calender"></i></span>
                                    </div><!-- input-group -->
                                </label>                                    
                            </div>
                        </div>        	
                    </div>  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-6">
                                <label><spring:message code="content.managestaff.avatar"/></label><br/>
                                <img src="../${avatar}" id="imagePreview" style="width:99px; height: 75px;"/><br/>
                                <div class="input-group">
                                    <label class="input-group-btn" style="margin:0px">                                    
                                        <span class="btn btn-primary">
                                            <spring:message code="content.button.browser"/>&hellip;<input name="avatar" id="imageUpload" type="file" style="display: none;" multiple>
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label><spring:message code="content.managestaff.phone"/></label>
                                    <form:input path="phone" cssClass="form-control"/> 
                                </div>
                                <div class="form-group">
                                    <label><spring:message code="content.managestaff.salary"/><span class="text-danger">*</span></label>
                                    <form:input path="salary" cssClass="form-control"/>
                                </div>
                            </div>
                        </div>        	
                    </div> 

                    <div class="form-group">
                        <label><spring:message code="content.managestaff.notes"/></label>
                        <form:textarea path="notes" cssClass="form-control"/>
                    </div>
                    <div class="form-group">
                        <label><spring:message code="content.managestaff.departname"/></label>
                        <form:select path="depart.id" items="${departs}" cssClass="form-control" itemValue="id" itemLabel="name"/>
                    </div>  

                </div>
                <div class="modal-footer">
                    <form:input path="id" type="hidden"/>
                    <input name="avatarTemp" type="hidden" value="${avatar}" />
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal"><spring:message code="content.button.cancel"/></button>
                    <input name="update" type="submit" class="btn btn-info" value="<spring:message code="content.button.save"/>">
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
                    <h4 class="modal-title"><spring:message code="content.managestaff.del.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <p><spring:message code="content.managestaff.del.message"/></p>
                    <p class="text-warning"><small><spring:message code="content.managestaff.del.message.warning"/></small></p>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" value="<spring:message code="content.button.cancel"/>">
                    <a href="" class="btn btn-danger removeBtn"><spring:message code="content.button.del"/></a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(function () {
        $(document).ready(function () {
            //validate form
            $('#frmAdd').submit(function () {

                var phoneReg = /^\d{10,11}$/;
                var salaryReg = /^-?(\d+\.?\d*)$|(\d*\.?\d+)$/;
                var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
                var flag = true;
                var date = $('#datepicker').datepicker("getDate");
                var now = moment().format('YYYY-MM-DD');
                var then = moment(date).format('YYYY-MM-DD');


                $('#name').parent().children("ul").remove();
                $('#email').parent().children("ul").remove();
                $('#datepicker').parent().parent().children("ul").remove();
                $('#phone').parent().children("ul").remove();
                $('#salary').parent().children("ul").remove();


                if ($('#name').val() == '') {
                    $('#name').addClass("parsley-error");
                    $('#name').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.fullname.message.empty"/></li></ul>');
                    flag = false;
                } else {
                    $('#name').removeClass("parsley-error");
                }

                if ($('#email').val() == '') {
                    $('#email').addClass("parsley-error");
                    $('#email').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.email.message.empty"/></li></ul>');
                    flag = false;
                } else if (!emailReg.test($('#email').val())) {
                    $('#email').addClass("parsley-error");
                    $('#email').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.email.message.valid"/></li></ul>');
                    flag = false;
                } else {
                    $('#email').removeClass("parsley-error");
                }

                if ($('#datepicker').val() == '') {
                    $('#datepicker').addClass("parsley-error");
                    $('#datepicker').parent().after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.birthday.message.empty"/></li></ul>');
                    flag = false;
                } else if (then > now) {
                    $('#datepicker').addClass("parsley-error");
                    $('#datepicker').parent().after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.birthday.message.past"/></li></ul>');
                    flag = false;
                } else {
                    $('#datepicker').removeClass("parsley-error");
                }

                if ($('#phone').val() != '' && !phoneReg.test($('#phone').val())) {
                    $('#phone').addClass("parsley-error");
                    $('#phone').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.phone.message.valid"/></li></ul>');
                    flag = false;
                } else {
                    $('#phone').removeClass("parsley-error");
                }

                if ($('#salary').val() <= 0) {
                    $('#salary').addClass("parsley-error");
                    $('#salary').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.salary.message.empty"/></li></ul>');
                    flag = false;
                } else if (!salaryReg.test($('#salary').val())) {
                    $('#salary').addClass("parsley-error");
                    $('#salary').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.salary.message.valid"/></li></ul>');
                    flag = false;
                } else {
                    $('#salary').removeClass("parsley-error");
                }

                if (flag == false) {
                    return false;
                }
            });

            $('#datatable').DataTable({
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "<spring:message code="content.select.all"/>"]],
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

            $('#datepicker').datepicker({
                format: "dd/mm/yyyy",
                todayHighlight: true,
                autoclose: true
            });

            /* Preview images */
            $('#imageUpload').change(function () {
                readImgUrlAndPreview(this);
                function readImgUrlAndPreview(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#imagePreview').attr('src', e.target.result);
                        }
                    }
                    ;
                    reader.readAsDataURL(input.files[0]);
                }
            });

            /* Show delete modal */
            $("body").on("click", "#datatable .delete", function (e) {
                e.preventDefault();
                $("#deleteModal .removeBtn").attr("href", $(this).attr("href"));
                $("#deleteModal").modal();
            });

            /* Show edit modal */
            $("body").on("click", "#datatable .edit", function (e) {
                var link = $(this).attr("href");
                e.preventDefault();
                $.get(link, function (data) {
                    var result = $('<div />').append(data).find('#editStaffModal').html();
                    $('#editStaffModal').html(result);
                    $('#editStaffModal #datepicker').datepicker({
                        format: "dd/mm/yyyy",
                        todayHighlight: true,
                        autoclose: true
                    });

                    $('#editStaffModal #imageUpload').change(function () {
                        readImgUrlAndPreview(this);
                        function readImgUrlAndPreview(input) {
                            if (input.files && input.files[0]) {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    $('#editStaffModal #imagePreview').attr('src', e.target.result);
                                }
                            }
                            ;
                            reader.readAsDataURL(input.files[0]);
                        }
                    });

                    $('#editStaffModal').modal();

                    $('#staff').submit(function () {

                        var phoneReg = /^\d{10,11}$/;
                        var salaryReg = /^-?(\d+\.?\d*)$|(\d*\.?\d+)$/;
                        var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
                        var flag = true;
                        var date = $('#editStaffModal #datepicker').datepicker("getDate");
                        var now = moment().format('YYYY-MM-DD');
                        var then = moment(date).format('YYYY-MM-DD');

                        $('#staff #name').parent().children("ul").remove();
                        $('#staff #email').parent().children("ul").remove();
                        $('#staff #datepicker').parent().parent().children("ul").remove();
                        $('#staff #phone').parent().children("ul").remove();
                        $('#staff #salary').parent().children("ul").remove();


                        if ($('#staff #name').val() == '') {
                            $('#staff #name').addClass("parsley-error");
                            $('#staff #name').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.fullname.message.empty"/></li></ul>');
                            flag = false;
                        } else {
                            $('#staff #name').removeClass("parsley-error");
                        }

                        if ($('#staff #email').val() == '') {
                            $('#staff #email').addClass("parsley-error");
                            $('#staff #email').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.email.message.empty"/></li></ul>');
                            flag = false;
                        } else if (!emailReg.test($('#staff #email').val())) {
                            $('#staff #email').addClass("parsley-error");
                            $('#staff #email').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.email.message.valid"/></li></ul>');
                            flag = false;
                        } else {
                            $('#staff #email').removeClass("parsley-error");
                        }

                        if ($('#staff #datepicker').val() == '') {
                            $('#staff #datepicker').addClass("parsley-error");
                            $('#staff #datepicker').parent().after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.birthday.message.empty"/></li></ul>');
                            flag = false;
                        } else if (then > now) {
                            $('#staff #datepicker').addClass("parsley-error");
                            $('#staff #datepicker').parent().after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.birthday.message.past"/></li></ul>');
                            flag = false;
                        } else {
                            $('#staff #datepicker').removeClass("parsley-error");
                        }

                        if ($('#staff #phone').val() != '' && !phoneReg.test($('#staff #phone').val())) {
                            $('#staff #phone').addClass("parsley-error");
                            $('#staff #phone').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.phone.message.valid"/></li></ul>');
                            flag = false;
                        } else {
                            $('#staff #phone').removeClass("parsley-error");
                        }

                        if ($('#staff #salary').val() <= 0) {
                            $('#staff #salary').addClass("parsley-error");
                            $('#staff #salary').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.salary.message.empty"/></li></ul>');
                            flag = false;
                        } else if (!salaryReg.test($('#staff #salary').val())) {
                            $('#staff #salary').addClass("parsley-error");
                            $('#staff #salary').after('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managestaff.salary.message.valid"/></li></ul>');
                            flag = false;
                        } else {
                            $('#staff #salary').removeClass("parsley-error");
                        }

                        if (flag == false) {
                            return false;
                        }
                    });

                });

            });

        });
    });

</script>
