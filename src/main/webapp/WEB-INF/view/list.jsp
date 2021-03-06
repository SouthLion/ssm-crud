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
    <script src="${APP_Path}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <script src="${APP_Path}/static/jquery/jquery-3.6.0.min.js"></script>
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
                    <table class="table table-hover">
                        <tr>
                            <th>#</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${pageInfo.list}" var="emp">
                            <tr>
                                <td>${emp.id}</td>
                                <td>${emp.lastName}</td>
                                <td>${emp.gender}</td>
                                <td>${emp.email}</td>
                                <td>${emp.department.deptName}</td>
                                <td>
                                    <button class="btn btn-info btn-sm">
                                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                        新增
                                    </button>
                                    <button class="btn btn-danger btn-sm" >
                                        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                        删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>

                <!-- 显示分页信息 -->
                <div class="row">
                    <!-- 分页文字信息 -->
                    <div class="col-md-6" id="page-info-area">
                        当前第${pageInfo.pageNum}页，总共有${pageInfo.pages}页,${pageInfo.total}条记录
                    </div>
                    <!-- 分页条信息 -->
                    <div class="col-md-6">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <li><a href="${APP_Path}/emps?pn=1">首页</a></li>
                                <li>
                                    <a href="${APP_Path}/emps?pn=${pageInfo.pageNum > 1 ? pageInfo.pageNum-1 : 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                                    <c:if test="${pageNum == pageInfo.pageNum}">
                                        <li class="active"><a href="#">${pageNum}</a></li>
                                    </c:if>
                                    <c:if test="${pageNum != pageInfo.pageNum}">
                                        <li><a href="${APP_Path}/emps?pn=${pageNum}">${pageNum}</a></li>
                                    </c:if>
                                </c:forEach>
                                <li>
                                    <a href="${APP_Path}/emps?pn=${pageInfo.pageNum < pageInfo.pages  ? pageInfo.pageNum + 1 : pageInfo.pageNum}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                                <li><a href="${APP_Path}/emps?pn=${pageInfo.pages}">末页</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
