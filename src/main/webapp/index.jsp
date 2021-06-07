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
        pageContext.setAttribute("APP_Path",request.getContextPath());
    %>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link href="https://cdn2.jianshu.io/assets/favicons/favicon-e743bfb1821442341c3ab15bdbe804f7ad97676bd07a770ccc9483473aa76f06.ico" rel="shortcut icon" type="image/x-icon">
    <script type="text/javascript" src="${APP_Path}/static/js/jquery-3.6.0.min.js"></script>
    <script src="${APP_Path}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <script>

        $(function () {
            ajaxFunction(1);
        });

        function ajaxFunction(pn){
            $.ajax({
                url:"${APP_Path}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function(result){
                    //1.解析并显示员工数据
                    build_emps_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析并显示分页条数据
                    build_page_nav(result);
                }
            });
        }



        function build_emps_table(result){
            //清空内容
            $("#table-employee tbody").empty();
            var emps = result.extenden.pageInfo.list;
            $.each(emps,function (index,item){
                var empIdTd = $("<td></td>").append(item.id);
                var empLastNameTd = $("<td></td>").append(item.lastName);
                var empGenderTd = $("<td></td>").append(item.gender);
                var empEmailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                var btnAddTd = $("<button></button>").addClass("btn btn-info btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
                var btnDeleteTd = $("<button></button>").addClass("btn btn-danger btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
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
            $("#page-info-area").empty();
            $("#page-info-area").append(" 当前第"+ result.extenden.pageInfo.pageNum + "页，总共有"+ result.extenden.pageInfo.pages +"页," + result.extenden.pageInfo.total + "条记录");
        }

        function build_page_info(result) {
            //清空内容
            $("#pagination").empty();
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if (result.extenden.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    ajaxFunction(result.extenden.pageInfo.pageNum + 1);
                })
                lastPageLi.click(function(){
                    ajaxFunction(result.extenden.pageInfo.pages);
                })
            }
            if (result.extenden.pageInfo.hasPreviousPage == false){
                prePageLi.addClass("disabled");
                firstPageLi.addClass("disabled");
            }else{
                firstPageLi.click(function(){
                    ajaxFunction(1);
                })
                prePageLi.click(function(){
                    ajaxFunction(result.extenden.pageInfo.pageNum - 1);
                })
            }
            $("#pagination").append(firstPageLi).append(prePageLi);
            $.each(result.extenden.pageInfo.navigatepageNums,function (index,item){
                var NumLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if (result.extenden.pageInfo.pageNum == item){
                    NumLi.addClass("active");
                }
                NumLi.click(function (){
                    ajaxFunction(item);
                })
                $("#pagination").append(NumLi);
            });
            $("#pagination").append(nextPageLi).append(lastPageLi);



        }

    </script>
</head>
<body>
    <div class="container">
        <div class="container">
            <!-- 标题 -->
            <div class="row">
                <div class="col-md-12">
                    <h1 align="center" >SSM-CRUD</h1>
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
</body>
</html>
