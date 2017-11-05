package com.nian.test;

import java.util.UUID;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nian.dao.ProductsMapper;
import com.nian.bean.Category;
import com.nian.bean.Products;
import com.nian.dao.CategoryMapper;


/**
 * dao-test
 * @author Niantianlei
 * @ContextConfiguration指定Spring配置文件的位置
 * 用autowired注解直接拿到要使用的组件
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	CategoryMapper CategoryMapper;
	@Autowired
	ProductsMapper productsMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		/*	//1、创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2、从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		
		//插入一些品类的测试
		/*CategoryMapper.insertSelective(new Category(null, "水果"));
		CategoryMapper.insertSelective(new Category(null, "蔬菜"));
		CategoryMapper.insertSelective(new Category(null, "肉类"));
		CategoryMapper.insertSelective(new Category(null, "百货"));*/
		
		//测试商品数据的插入
		//productsMapper.insertSelective(new Products(null, "苹果", "M", "0074025", "5", "100", 1));
		//查询测试
		//productsMapper.selectByPrimaryKey(1);
		
		//批量插入数据；批量，使用可以执行批量操作的sqlSession
		/*ProductsMapper mapper = sqlSession.getMapper(ProductsMapper.class);
		for(int i = 0; i < 10; i++){
			String uid = UUID.randomUUID().toString().substring(0,7)+i;
			mapper.insertSelective(new Products(null, "猪里脊"+i, "M", uid, "15", "10"+i, 3));
		}*/
		ProductsMapper mapper = sqlSession.getMapper(ProductsMapper.class);
		for(int i = 0; i < 10; i++){
			String uid = UUID.randomUUID().toString().substring(0,7)+i;
			mapper.insertSelective(new Products(null, "笔记本"+i, "M", uid, "7", "5"+i, 4));
		}
		System.out.println("数据已生成");
	}
}
