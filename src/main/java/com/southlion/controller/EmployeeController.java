package com.southlion.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.southlion.pojo.Employee;
import com.southlion.pojo.Msg;
import com.southlion.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author ZhangZhengtao
 * @Description
 * @create 2021-06-03 19:03
 */
@Controller
public class EmployeeController {

@Autowired
EmployeeService employeeService;

/**
 * @Description: 接受ajax返回的对象，需要导入jackson包
 * @Author: zhang
 * @Date: 2021/6/6 9:08
 * @Param: [pn]
 * @Return: com.github.pagehelper.PageInfo
 */
@RequestMapping("/emps")
@ResponseBody
public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
    PageHelper.startPage(pn,5);
    List<Employee> emps = employeeService.getAll();
    PageInfo Info = new PageInfo(emps,5);
    return Msg.success().add("pageInfo",Info);
}

//    //    查询员工数据，分页查询
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo Info = new PageInfo(emps,5);
        model.addAttribute("pageInfo",Info);
        return "list";
    }
}
