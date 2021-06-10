package com.southlion.controller;

import com.southlion.pojo.Department;
import com.southlion.pojo.Msg;
import com.southlion.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author ZhangZhengtao
 * @Description
 * @create 2021-06-08 10:39
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDept(){
        List<Department> allDept = departmentService.getAllDept();
        return Msg.success().add("deptInfo",allDept);
    }


}
