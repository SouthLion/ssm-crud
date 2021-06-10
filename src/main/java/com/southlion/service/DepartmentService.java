package com.southlion.service;

import com.southlion.dao.DepartmentMapper;
import com.southlion.pojo.Department;
import com.southlion.pojo.Employee;
import com.southlion.test.MVCTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ZhangZhengtao
 * @Description
 * @create 2021-06-08 11:08
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAllDept(){
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }


}
