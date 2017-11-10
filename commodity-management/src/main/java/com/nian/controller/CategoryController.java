package com.nian.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nian.bean.Category;
import com.nian.bean.Msg;
import com.nian.service.CategoryService;


/**
 * 处理请求
 * @author Niantianlei
 *
 */

@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService categoryService;
	
	/**
	 * 返回所有的类别信息
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		List<Category> list = categoryService.getDepts();
		return Msg.success().add("depts", list);
	}
}
