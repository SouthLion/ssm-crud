package com.southlion.service;

import com.southlion.dao.EmployeeMapper;
import com.southlion.pojo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ZhangZhengtao
 * @Description
 * @create 2021-06-03 19:18
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * @Description: 查询所有员工
     * @Author: zhang
     * @Date: 2021/6/3 19:27
     * @Param: []
     * @Return: java.util.List<com.southlion.pojo.Employee>
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }
}
