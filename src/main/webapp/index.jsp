<%--
  Created by IntelliJ IDEA.
  User: zhang
  Date: 2021/6/3
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_Path", request.getContextPath());
    %>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
          integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link href="https://cdn2.jianshu.io/assets/favicons/favicon-e743bfb1821442341c3ab15bdbe804f7ad97676bd07a770ccc9483473aa76f06.ico"
          rel="shortcut icon" type="image/x-icon">
    <script type="text/javascript" src="${APP_Path}/static/js/jquery-3.6.0.min.js"></script>
    <script src="${APP_Path}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Modal title</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add-form">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="lastName" placeholder="name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empEmail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="empEmail" name="email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="depart-select" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save-button">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="container">
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1 align="center">SSM-CRUD</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="table-employee">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>

            <!-- 显示分页信息 -->
            <div class="row">
                <!-- 分页文字信息 -->
                <div class="col-md-6" id="page-info-area">

                </div>
                <!-- 分页条信息 -->
                <div class="col-md-6" id="page-nav-info">
                    <nav aria-label="Page navigation">
                        <ul class="pagination" id="pagination">
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var totalRecord;
    var flag = 0;

    $(function () {
        ajaxFunction(1);
    });

    function ajaxFunction(pn) {
        $.ajax({
            url: "${APP_Path}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空内容
        $("#table-employee tbody").empty();
        var emps = result.extenden.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.id);
            var empLastNameTd = $("<td></td>").append(item.lastName);
            var empGenderTd = $("<td></td>").append(item.gender == 'M'?"男":"女");
            var empEmailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var btnAddTd = $("<button></button>").addClass("btn btn-info btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            var btnDeleteTd = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("删除"));
            var btnTd = $("<td></td>").append(btnAddTd).append(" ").append(btnDeleteTd);
            $("<tr></tr>").append(empIdTd)
                .append(empLastNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(deptNameTd)
                .append(btnTd).appendTo("#table-employee tbody");
        });
    }

    function build_page_nav(result) {
        totalRecord = result.extenden.pageInfo.total;
        $("#page-info-area").empty();
        $("#page-info-area").append(" 当前第" + result.extenden.pageInfo.pageNum + "页，总共有" + result.extenden.pageInfo.pages + "页," + result.extenden.pageInfo.total + "条记录");
    }

    function build_page_info(result) {
        //清空内容
        $("#pagination").empty();
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extenden.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                ajaxFunction(result.extenden.pageInfo.pageNum + 1);
            })
            lastPageLi.click(function () {
                ajaxFunction(result.extenden.pageInfo.pages);
            })
        }
        if (result.extenden.pageInfo.hasPreviousPage == false) {
            prePageLi.addClass("disabled");
            firstPageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                ajaxFunction(1);
            })
            prePageLi.click(function () {
                ajaxFunction(result.extenden.pageInfo.pageNum - 1);
            })
        }
        $("#pagination").append(firstPageLi).append(prePageLi);
        $.each(result.extenden.pageInfo.navigatepageNums, function (index, item) {
            var NumLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
            if (result.extenden.pageInfo.pageNum == item) {
                NumLi.addClass("active");
            }
            NumLi.click(function () {
                ajaxFunction(item);
            })
            $("#pagination").append(NumLi);
        });
        $("#pagination").append(nextPageLi).append(lastPageLi);
    }

    $("#emp_add_model_btn").click(function () {

        $("#emp_add_modal").modal({
            backdrop: "static"
        });
        $.ajax({
            url: "${APP_Path}/depts",
            type: "GET",
            success: function (result) {
                $.each(result.extenden.deptInfo, function () {
                    var deptOption = $("<option></option>").append(this.deptName).attr("value", this.id);
                    deptOption.appendTo("#depart-select");

                })
            }
        });
    });

        $("#empName").blur(function () {
            var empName = $("#empName").val();
            var regName = /^([a-zA-Z0-9_-]|[\u4E00-\u9FA5]){4,20}$/;
            if (!regName.test(empName)) {
                $("#empName").parent().removeClass("has-success has-error");
                $("#empName").parent().addClass("has-error");
                $("#empName").next("span").text("用户名为4到20个字母或者汉字，可以包含-或者_");
                flag = 0;
            } else {
                $("#empName").parent().removeClass("has-success has-error");
                $("#empName").parent().addClass("has-success");
                $("#empName").next("span").text("")
            }
        });

        $("#empEmail").blur(function (){
            var email = $("#empEmail").val();
            var regEmail = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            if(!regEmail.test(email)){
                $("#empEmail").parent().removeClass("has-success has-error");
                $("#empEmail").parent().addClass("has-error");
                $("#empEmail").next("span").text("邮箱格式不正确");
                flag = 0
            }else{
                $("#empEmail").parent().removeClass("has-success has-error");
                $("#empEmail").parent().addClass("has-success");
                $("#empEmail").next("span").text("");
            }
            flag = 1;
        });

        $("#empName").change(function (){
            var lastName = this.value;
            $.ajax({
                url: "${APP_Path}/checkuser",
                type: "POST",
                data: "lastName="+lastName,
                success: function (result) {
                    if(result.code == 100){
                        $("#empName").parent().removeClass("has-success has-error");
                        $("#empName").parent().addClass("has-success");
                        $("#empName").next("span").text("");
                    }else{
                        $("#empName").parent().removeClass("has-success has-error");
                        $("#empName").parent().addClass("has-error");
                        $("#empName").next("span").text("用户名重复");
                    }
                }
            });
        });

       //2.校验邮箱信息
    $("#save-button").click(function () {
        if(!flag){
            return false;
        }

        $.ajax({
            url: "${APP_Path}/emp",
            type: "POST",
            data: $("#add-form").serialize(),
            success: function (result) {
                alert(result.msg);
                $('#emp_add_modal').modal('toggle');
                ajaxFunction(totalRecord + 1);
            }
        });
    });

</script>
</body>
</html>
