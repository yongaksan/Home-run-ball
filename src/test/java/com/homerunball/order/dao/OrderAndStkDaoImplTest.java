package com.homerunball.order.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class OrderAndStkDaoImplTest {
    @Autowired
    private OrderAndStkDao orderAndStkDao;
    @Test
    public void getcartItem() {
        System.out.println("orderAndStkDao.getcartItem(100003) = " + orderAndStkDao.getcartItem(100003));
    }
}