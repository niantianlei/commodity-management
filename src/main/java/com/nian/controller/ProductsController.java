package com.nian.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.nian.bean.Msg;
import com.nian.bean.Products;
import com.nian.service.ProductsService;


/**
 * 处理请求
 * @author Niantianlei
 *
 */
@Controller
public class ProductsController {
	@Autowired
	ProductsService productsService;
	
	/**
	 * 分页查询数据
	 * @param pn
	 * @param model
	 * @return
	 */
	// @RequestMapping("/pro")
	public String getpros(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) {
		// 利用PageHelper插件进行分页查询
		
		// 输入页码以及每页的数据量
		PageHelper.startPage(pn, 7);
		// 这里顺序是不能乱的，必须先调用方法startPage然后在查询
		List<Products> pros = productsService.getAll();
		// 用pageInfo封装查询结果，然后将其传给页面
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(pros, 5);
		
		//利用Model向页面传值
		model.addAttribute("pageInfo", page);
		//根据试图解析器找到
		return "list";
	}
	
	
	/**
	 * 删除数据
	 * @param id
	 * @return
	 */
	//将返回对象转为json字符串
	@ResponseBody
	// 处理请求地址映射
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//批量删除
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			productsService.deleteBatch(del_ids);
		}else{
			//单独删除
			Integer id = Integer.parseInt(ids);
			productsService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	/**
	 * 商品更新方法
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{proId}",method=RequestMethod.PUT)
	public Msg saveEmp(Products product){
		System.out.println("将要更新的商品数据："+product);
		productsService.updateEmp(product);
		return Msg.success()	;
	}
	
	/**
	 * 根据id查询商品
	 * @param id
	 * @return
	 */
	//@PathVariable("id")指定从路径的id中取到值
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		
		Products product = productsService.getEmp(id);
		return Msg.success().add("emp", product);
	}
	
	
	/**
	 * 检查商品名是否已存在
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("proName")String proName){
		//先判断商品名是否合法;    这里也可以放在前端页面，在发送ajax请求之前。保证和js的验证一致
		String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+)";
		if(!proName.matches(regx)){
			return Msg.fail().add("va_msg", "商品名必须是中文开头或者3-16位英文和数字的组合");
		}
		
		//数据库商品名重复校验
		boolean b = productsService.checkUser(proName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "商品名不可用");
		}
	}
	
	
	/**
	 * 保存数据
	 * 1、支持JSR303校验
	 * 2、导入Hibernate-Validator
	 * @return
	 */
	//@Valid注解进行数据验证
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Products products, BindingResult result){
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			//保存
			productsService.saveEmp(products);
			return Msg.success();
		}
		
	}

	/**
	 * 导入jackson包。
	 * @param pn
	 * @return
	 */
	@RequestMapping("/pros")
	@ResponseBody
	public Msg getProductsWithJson(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 利用PageHelper插件进行分页查询
		
		// 输入页码以及每页的数据量
		PageHelper.startPage(pn, 7);
		// 这里顺序是不能乱的，必须先调用方法startPage然后在查询
		List<Products> pros = productsService.getAll();
		// 用pageInfo封装查询结果，然后将其传给页面
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(pros, 5);
		return Msg.success().add("pageInfo", page);
	}
	

}
