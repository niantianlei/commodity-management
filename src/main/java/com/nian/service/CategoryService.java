package com.nian.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nian.bean.Category;
import com.nian.dao.CategoryMapper;


@Service
public class CategoryService {
	
	@Autowired
	private CategoryMapper categoryMapper;

	public List<Category> getDepts() {
		List<Category> list = categoryMapper.selectByExample(null);
		return list;
	}

}
