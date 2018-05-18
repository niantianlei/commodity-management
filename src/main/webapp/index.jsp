<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- pageContext代表页面上下文 -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js">
</script>
<style type="text/css">
	.title {
		text-align: center;
		font-family: Microsoft YaHei;
		color: #00C5CD;
	}
	body {
		background-color: #F5FFFA;
	}
	.pageInformation {
		font-size: 16px;
		color: #EE0000;
	}
</style>
</head>
<body>
<!-- 商品数据修改的模态框 -->
<div class="modal fade" id="proUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改商品信息</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">商品名</label>
		    <div class="col-sm-10">
		      	<input type="text" name="proName" class="form-control" id="proName_update_static"></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">在售</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
				  <input type="radio" name="proState" value="M" checked="checked"> 是
				</label>
				<label class="radio-inline">
				  <input type="radio" name="proState" value="F"> 否
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">货号</label>
		    <div class="col-sm-10">
		      <input type="text" name="proNo" class="form-control" id="proNo_update_input">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">单价</label>
		    <div class="col-sm-10">
		      <input type="text" name="proPrice" class="form-control" id="proPrice_update_input">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">库存</label>
		    <div class="col-sm-10">
		      <input type="text" name="proNumber" class="form-control" id="proNumber_update_input">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">类别</label>
		    <div class="col-sm-4">
		      <select class="form-control" name="dId">
		      </select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-success" id="pro_update_btn">修改</button>
      </div>
    </div>
  </div>
</div>



<!-- 商品添加的模态框 -->
<div class="modal fade" id="proAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">商品添加</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">商品名</label>
		    <div class="col-sm-10">
		      <input type="text" name="proName" class="form-control" id="proName_add_input" placeholder="中文开头或英文(3-16)">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">在售</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
				  <input type="radio" name="proState" id="state1_add_input" value="M"> 是
				</label>
				<label class="radio-inline">
				  <input type="radio" name="proState" id="state2_add_input" value="F" checked="checked"> 否
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">货号</label>
		    <div class="col-sm-10">
		      <input type="text" name="proNo" class="form-control" id="proNo_add_input" placeholder="6-10个字母数字的组合">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">单价</label>
		    <div class="col-sm-10">
		      <input type="text" name="proPrice" class="form-control" id="proPrice_add_input" placeholder="10">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">库存</label>
		    <div class="col-sm-10">
		      <input type="text" name="proNumber" class="form-control" id="proNumber_add_input" placeholder="100">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">类别</label>
		    <div class="col-sm-4">
		      <select class="form-control" name="dId">
		      </select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-success" id="pro_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>


	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row title">
			<div class="col-md-12">
				<h1>商品管理系统</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary btn-lg" id="pro_add_modal_btn"><span class="glyphicon glyphicon-plus"></span>新增</button>
				<button class="btn btn-danger btn-lg" id="pro_delete_all_btn"><span class="glyphicon glyphicon-remove"></span>删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="pros_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th> 
							<th>序号</th>
							<th>商品名</th>
							<th>在售</th>
							<th>货号</th>
							<th>单价</th>
							<th>库存</th>
							<th>类别</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>

		<!-- 显示分页信息 -->
		<div class="row">
			<!--分页文字信息  -->
			<div class="col-md-3 col-md-offset-3" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
		
	</div>
	<script type="text/javascript">
	
		var totalRecord,currentPage;
		//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/pros",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1、解析并显示商品数据
					build_pros_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		}
		
		function build_pros_table(result){
			//清空table表格
			$("#pros_table tbody").empty();
			var pros = result.extend.pageInfo.list;
			$.each(pros,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var proIdTd = $("<td></td>").append(item.proId);
				var proNameTd = $("<td></td>").append(item.proName);
				var stateTd = $("<td></td>").append(item.proState=='M'?"是":"否");
				var noTd = $("<td></td>").append(item.proNo);
				var priceTd = $("<td></td>").append(item.proPrice);
				var numberTd = $("<td></td>").append(item.proNumber);
				var cateNameTd = $("<td></td>").append(item.category.cateName);
				
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
				//为编辑按钮添加一个自定义的属性，来表示当前商品id
				editBtn.attr("edit-id",item.proId);
				var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个自定义的属性来表示当前删除的商品id
				delBtn.attr("del-id",item.proId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//append方法执行完成以后还是返回原来的元素，所以可以使用链式操作
				$("<tr></tr>").append(checkBoxTd)
					.append(proIdTd)
					.append(proNameTd)
					.append(stateTd)
					.append(noTd)
					.append(priceTd)
					.append(numberTd)
					.append(cateNameTd)
					.append(btnTd)
					.appendTo("#pros_table tbody");
			});
		}
		//解析json显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页/共"+
					result.extend.pageInfo.pages+"页， 共有"+
					result.extend.pageInfo.total+"条记录").addClass("pageInformation");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条，点击分页要能去对应页码
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			//构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("上一页"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum -1);
				});
			}
			
			
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("下一页"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum +1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			
			
			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2,3遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		//页码解析完毕
		
		
		//清空表单样式及内容
		function reset_form(ele){
			//jQuery没有reset方法，先转化为js，调用reset重置表单
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮弹出模态框。
		$("#pro_add_modal_btn").click(function(){
			//清除表单数据（表单完整重置（表单的数据，表单的样式））
			reset_form("#proAddModal form");
			//s$("")[0].reset();
			//发送ajax请求，查出品种信息，显示在下拉列表中
			getCate("#proAddModal select");
			//弹出模态框
			$("#proAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出所有的种类信息并显示在下拉列表中
		function getCate(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					//在下拉列表中显示种类信息
					//不传参用this表示当前遍历对象
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.cateName).attr("value",this.cateId);
						optionEle.appendTo(ele);
					});
				}
			});
			
		}
		
		//校验表单数据
		function validate_add_form(){
			//1、拿到要校验的数据，使用正则表达式
			var proName = $("#proName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+)/;
			if(!regName.test(proName)){
				//alert("商品名可以是中文开头或者3-16位英文和数字的组合");
				show_validate_msg("#proName_add_input", "error", "商品名可以是中文开头或者3-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#proName_add_input", "success", "");
			};
			
			//2、校验货号信息
			var proNo = $("#proNo_add_input").val();
			var regNo = /^[a-zA-Z0-9]{6,10}/;
			
			if(!regNo.test(proNo)){
				show_validate_msg("#proNo_add_input", "error", "货号格式不正确（6-10位字母数字的组合）");
				return false;
			}else{
				show_validate_msg("#proNo_add_input", "success", "");
			}
			return true;
		}
		
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//首先清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//校验商品是否已存在
		$("#proName_add_input").change(function(){
			//发送ajax请求校验商品是否已存在
			var proName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"proName="+proName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#proName_add_input","success","商品名可用");
						//额外增加属性用作判断
						$("#pro_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#proName_add_input","error",result.extend.va_msg);
						$("#pro_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		//点击保存，保存商品。
		$("#pro_save_btn").click(function(){
			//alert($("#proAddModal form").serialize());
			//利用jQuery的serialize()快速获取form表单的数据，注意到表单的name属性要和bean中的一样
			//产生的格式为：key=value&key=value&...
			
			//1、模态框中填写的表单数据提交给服务器进行保存
			//先对要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			};
			//1、判断之前的ajax商品名校验是否成功。如果成功。
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//2、发送ajax请求保存商品
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#proAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
						//商品保存成功；
						//1、关闭模态框
						$("#proAddModal").modal('hide');
						
						//2、来到最后一页，显示刚才保存的数据
						//发送ajax请求显示最后一页数据即可，这里任意大的数即可，只要大于最后一页的页码数
						to_page(totalRecord);
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息就显示哪个字段的；
						if(undefined != result.extend.errorFields.proNo){
							//显示货号错误信息
							show_validate_msg("#proNo_add_input", "error", result.extend.errorFields.proNo);
						}
						if(undefined != result.extend.errorFields.proName){
							//显示商品名的错误信息
							show_validate_msg("#proName_add_input", "error", result.extend.errorFields.proName);
						}
					}
				}
			});
		});
		
		//创建之前就绑定了click，所以绑定不上。
		//使用on绑定click事件     动态刷新后事件仍存在
		$(document).on("click",".edit_btn",function(){
			//1、查出种类信息，并显示种类列表
			getCate("#proUpdateModal select");
			//2、查出商品信息，显示商品信息
			getPro($(this).attr("edit-id"));
			
			//3、把商品的id传递给模态框的修改按钮
			$("#pro_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#proUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getPro(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var proData = result.extend.emp;
					$("#proName_update_static").val(proData.proName);
					$("#proNo_update_input").val(proData.proNo);
					$("#proPrice_update_input").val(proData.proPrice);
					$("#proNumber_update_input").val(proData.proNumber);
					$("#proUpdateModal input[name=proState]").val([proData.proState]);
					$("#proUpdateModal select").val([proData.dId]);
				}
			});
		}
		
		//点击修改，更新商品信息
		$("#pro_update_btn").click(function(){
			
			//1、js校验货号信息
			var proNo = $("#proNo_update_input").val();
			var regNo = /^[a-zA-Z0-9]{6,10}/;
			
			if(!regNo.test(proNo)){
				show_validate_msg("#proNo_add_input", "error", "货号格式不正确（6-10位字母数字的组合）");
				return false;
			}else{
				show_validate_msg("#proNo_add_input", "success", "");
			}
			
			//2、发送ajax请求保存修改的商品数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				//传递id信息
				data:$("#proUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1、关闭对话框
					$("#proUpdateModal").modal("hide");
					//2、回到本页面
					to_page(currentPage); 
				}
			});
		});
		
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//1、弹出是否确认删除对话框
			var proName = $(this).parents("tr").find("td:eq(2)").text();
			var proId = $(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if(confirm("确认删除["+proName+"]吗？")){
				//确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/emp/"+proId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//刷新本页
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选/全不选功能
		$("#check_all").click(function(){
			//attr获取checked是undefined;
			//我们这些dom原生的属性；attr获取自定义属性的值；
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否7个
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#pro_delete_all_btn").click(function(){
			//
			var proNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//this代表当前遍历的对象
				proNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装商品id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除proNames多余的,
			proNames = proNames.substring(0, proNames.length-1);
			//去除删除的id多余的-
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			if(confirm("确认删除【"+proNames+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>