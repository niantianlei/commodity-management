package com.nian.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nian.bean.Products;
import com.nian.bean.ProductsExample;
import com.nian.bean.ProductsExample.Criteria;
import com.nian.dao.ProductsMapper;

@Service
public class ProductsService {
	
	@Autowired
	ProductsMapper productsMapper;
	
	
	/**
	 * 查询所有
	 * @return
	 */
	public List<Products> getAll() {
		return productsMapper.selectByExampleWithCate(null);
	}


	/**
	 * 数据保存
	 * @param product
	 */
	public void saveEmp(Products product) {
		productsMapper.insertSelective(product);
	}

	/**
	 * 
	 * 检验商品是否存在
	 * 
	 * @param proName
	 * @return  true：代表当前姓名可用   fasle：不可用
	 */
	public boolean checkUser(String proName) {
		ProductsExample example = new ProductsExample();
		Criteria criteria = example.createCriteria();
		criteria.andProNameEqualTo(proName);
		long count = productsMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 根据id查询商品
	 * @param id
	 * @return
	 */
	public Products getEmp(Integer id) {
		Products product = productsMapper.selectByPrimaryKey(id);
		return product;
	}

	/**
	 * 数据更新
	 * @param product
	 */
	public void updateEmp(Products product) {
		productsMapper.updateByPrimaryKeySelective(product);
	}

	/**
	 * 商品删除
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		productsMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		ProductsExample example = new ProductsExample();
		Criteria criteria = example.createCriteria();
		criteria.andProIdIn(ids);
		productsMapper.deleteByExample(example);
	}
}
