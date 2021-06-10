package com.southlion.service;

import com.southlion.dao.EmployeeMapper;
import com.southlion.pojo.Department;
import com.southlion.pojo.Employee;
import com.southlion.pojo.EmployeeExample;
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

    public void addDept(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    public boolean checkDesignatedEmp(String lastName){
       EmployeeExample example = new EmployeeExample();
       EmployeeExample.Criteria criteria = example.createCriteria();
       criteria.andLastNameEqualTo(lastName);
       long count = employeeMapper.countByExample(example);
       return count == 0;
    }
}
