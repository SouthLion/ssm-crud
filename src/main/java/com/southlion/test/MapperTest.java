package com.southlion.test;

import com.southlion.dao.DepartmentMapper;
import com.southlion.dao.EmployeeMapper;
import com.southlion.pojo.Department;
import com.southlion.pojo.Employee;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.xml.stream.Location;
import java.util.UUID;

/**
 * @author ZhangZhengtao
 * @Description
 * @create 2021-06-02 20:31
 */
@ContextConfiguration(locations = "classpath:conf/applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void test04(){
        //1.创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("conf/applicationContext.xml");
        //2.从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);

        //1.插入几个部门
//        departmentMapper.insertSelective(new Department(null,"妹妹部"));
//        departmentMapper.insertSelective(new Department(null,"哥哥部"));

//        employeeMapper.insertSelective(new Employee(null,"周杰伦的爸爸","男","110@110.com",1));

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);

        for(int i = 0;i < 1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
        }
    }

}
