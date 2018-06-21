<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="wrapper">
    <div class="container">

        <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <div class="btn-group pull-right m-t-15">
                    <a href="#addDepartmentModal" class="btn btn-primary" data-toggle="modal"><i class="fa fa-plus-circle"></i> <span><spring:message code="content.button.addnew"/></span></a>
                </div>
                <h4 class="page-title"><spring:message code="content.managedepart.title"/></h4>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-12">
                <div class="card-box table-responsive">                   
                    <table id="datatable" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th style="width: 120px;"><spring:message code="content.managedepart.code"/></th>
                                <th><spring:message code="content.managedepart.name"/></th>
                                <th><spring:message code="content.managedepart.action"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${departs}">
                                <tr>
                                    <td>${row.id}</td>
                                    <th class="text-muted">${row.name}</th>                        
                                    <td>
                                        <a href="?edit&id=${row.id}" class="edit"  data-toggle="modal"><i class="zmdi  zmdi-edit" data-toggle="tooltip" title="<spring:message code="content.a.edit.title"/>"></i></a>
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
<div id="addDepartmentModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="depart.html" id="frmAdd" method="POST" modelAttribute="depart">
                <div class="modal-header">						
                    <h4 class="modal-title"><spring:message code="content.managedepart.addnew.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <div class="form-group">
                        <label><spring:message code="content.managedepart.name"/><span class="text-danger">*</span></label>
                        <input name="name" id="name" type="text" class="form-control">                        
                    </div>      				
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal"><spring:message code="content.button.cancel"/></button>
                    <input name="insert" type="submit" class="btn btn-success" value="<spring:message code="content.button.add"/>">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Modal HTML -->
<div id="editDepartModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form:form action="depart.html" id="frmEdit" method="POST" modelAttribute="depart">
                <div class="modal-header">						
                    <h4 class="modal-title"><spring:message code="content.managedepart.edit.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <div class="form-group">
                        <label><spring:message code="content.managedepart.name"/><span class="text-danger">*</span></label>
                        <form:input type="text" path="name" cssClass="form-control"/>
                    </div>					
                </div>
                <div class="modal-footer">
                    <form:input type="hidden" path="id"/>
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
                    <h4 class="modal-title"><spring:message code="content.managedepart.del.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <p><spring:message code="content.managedepart.del.message"/></p>
                    <p class="text-warning"><small><spring:message code="content.managedepart.del.message.warning"/></small></p>
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

        $('#frmAdd').submit(function () {
            var flag = true;
            $('#name').parent().children("ul").remove();
            var name = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ]+$/u;

            if(!name.test($('#name').val())){
                $('#name').addClass("parsley-error");
                $('#name').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managedepart.name.message.empty"/></li></ul>')
                flag = false;
            } else {
                $('#name').removeClass("parsley-error");
            }

            if (flag == false) {
                return false;
            }
        });

        $('#datatable').DataTable({
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
                var result = $('<div />').append(data).find('#editDepartModal').html();
                $('#editDepartModal').html(result);
                $('#editDepartModal').modal();
                $('#frmEdit').submit(function () {
                    var flag = true;
                    $('#frmEdit #name').parent().children("ul").remove();

                    if ($('#frmEdit #name').val() == '') {
                        $('#frmEdit #name').addClass("parsley-error");
                        $('#frmEdit #name').parent().append('<ul class="parsley-errors-list filled"><li class="parsley-required"><spring:message code="content.managedepart.name.message.empty"/></li></ul>')
                        flag = false;
                    }

                    if (flag == false) {
                        return false;
                    }
                });
            });
        });

    });
</script>