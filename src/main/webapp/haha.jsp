<%--
  Created by IntelliJ IDEA.
  User: zhang
  Date: 2021/6/6
  Time: 12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>

    </title>
    <script type="text/javascript" src="js/jquery-3.6.0.js"></script>
    <script type="text/javascript">
        $(function (){
            getStudentInfo();
            //绑定事件
            function getStudentInfo(){
                $.ajax({
                    url:"student/queryStudent.do",
                    dataType:"json",
                    success:function(resp){
                        $("#stuinfo").empty();
                        $.each(resp,function (i,n){
                            $("#stuinfo").append("<tr><td>"+n.id+"</td><td>"+n.name+"</td><td>"+n.age+"</td></tr>");
                        });
                    }
                });
            }
            $("#showStudent").on("click",function (){
                getStudentInfo();
            });
        });
    </script>
</head>
<body>

</body>
</html>
