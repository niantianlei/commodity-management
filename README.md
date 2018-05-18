# commodity-management

简易商品管理系统

---------

这个说明文档没怎么排版，可以到[我的博客](https://niantianlei.github.io/2017/11/05/commodity-management/)查看！  


一个简单的商品管理的系统，使用的技术有：Maven+Spring+SpringMVC+MyBatis，前端框架boostrap。数据库使用mysql。  
用到两个表：一个商品信息表，一个种类表。使用外键关联将两个表联结起来。  

完整代码已上传github，地址为[https://github.com/niantianlei/commodity-management](https://github.com/niantianlei/commodity-management)  
欢迎`fork`以及`star`
<hr />
## 实现的功能  

1. 利用PageHelper插件分页显示数据  
2. 新增商品数据  
其中商品名、货号需要检测格式是否符合要求以及数据库中是否存在，这里用到js正则表达式、JSR303。  
3. 修改商品信息  
修改需要根据欲修改的商品'id'从数据库中查找，返回相应的信息  
4. 删除  
删除可以删除单条商品数据，也可以多选删除  

## SSM整合
[上一篇博客](https://niantianlei.github.io/2017/10/13/SSM/)已经有了这部分的介绍，只是添加jar包的方式不一样（一个手动添加一个Maven管理），配置文件是不变的，代码中也有详细注释。这里只做简单说明  
`pom.xml`文件管理项目依赖的jar包，各个包的作用见注释。  
`web.xml`配置Spring、前端控制器、过滤器等。前端控制器的init-param属性指定SpringMVC配置文件的位置，可以删除（不指定），此时需在web.xml统计目录创建名为servlet-name属性值-servlet(如:dispatcherServlet-servlet.xml)的配置文件。  
`dispatcherServlet-servlet.xml`SpringMVC的配置文件，扫描注释为@controller的控制器，配置视图解析器等。  
`applicationContext.xml`Spring配置文件，配置数据库，与MyBatis整合，配置事务等，需扫描除控制器之外的文件。  
`mybatis-config.xml`也可放在Spring的bean里。  

## MyBatis逆向工程
利用MyBatis生成对应的pojo、dao类及其映射文件，可参考[之前的博客](https://niantianlei.github.io/2017/10/10/Mybatis6/)，    
以及[官方文档](http://www.mybatis.org/generator/quickstart.html)  
首先，在MySQL中新建数据库，然后建表，sql脚本也放在了项目中了。  
新建一个`generatorConfig.xml`官方文档中有示例可直接复制过来，然后进行一些配置修改。  
采用Java结合配置文件进行生成的方法，[Java执行示例](http://www.mybatis.org/generator/running/runningWithJava.html)链接里面的代码可以直接拿过来，改下配置文件的路径、名字，直接运行即可。  
完成后刷新，可看到文件已生成。

## 修改dao层文件
使用mybatis生成的文件不一定就能满足我们的需求，可以在其基础上进行更改，实现需要的功能。  
此项目中，在查询商品时需要将种类表的信息也查询出来，这样才是完整信息。但是逆向工程只是生成单表操作，所以需要自己添加查询语句。  
1. bean文件`Products.java`中添加种类字段信息`private Category category;`，并生成getter和setter  
2. 在`ProductsMapper.java`接口中添加两个方法selectByExampleWithCate和selectByPrimaryKeyWithCate，表示同时查询种类信息。  
3. 修改映射文件`ProductsMapper.xml`添加联表查询sql语句，详细代码见github仓库，比较简单，不必细说。  

**需要注意的就是：**最一开始我没有在查询信息时排序，导致在页面插入商品时在最后找不到，仔细看了下，是插在了中间。也就是说没有按主键id排序，所以添加了如下代码：  
```
<!-- 如果未指定查询顺序，则以prducts表的主键id排序  -->
<if test="orderByClause == null">
  order by e.pro_id
</if>
```

## dao层测试
在com.nian.test包下新建一个类MapperTest.java，注解`@RunWith(SpringJUnit4ClassRunner.class)`表示是在Spring上下文中进行测试，`@ContextConfiguration`找到Spring配置文件  
直接用`@Autowired`注入一个CategoryMapper。  
再调用其方法insertSelective插入种类数据（为方便初始化数据，可以在bean里添加有参构造器，但同时要写上无参构造器）。   
此时可以去数据库中查看是否已将数据添加，来检验到目前为止的工作是否正确。  
<img src="http://chuantu.biz/t6/135/1510280933x3396406237.png" />  
成功显示数据。  
插入商品数据测试：  
利用for循环批量插入，使用UUID设置货号信息，保证随机性。  
可以在Spring配置文件中配置一个批量执行任务的sqlSession，然后通过`@Autowired`注入。  

## 页面搭建
使用boostrap框架的[栅格系统](http://v3.bootcss.com/css/#grid)，快速搭建好一个大致轮廓，根据使用手册慢慢弄，我写前端就是多试，多调，不断查看效果，满意为止。  
前端的内容就不具体说明了，框架使用很简单。  


## 功能实现
使用RESTful（表现层状态转化）风格的URI，将页面普通的post请求转为指定的delete或者put请求。  
HTTP协议，是一个无状态协议。这意味着，所有的状态都保存在服务器端。因此，如果客户端想要操作服务器，必须通过某种手段，让服务器端发生"状态转化"（State Transfer）。而这种转化是建立在表现层之上的，所以就是"表现层状态转化"。  
客户端用到的手段，只能是HTTP协议。具体来说，就是HTTP协议里面，四个表示操作方式的动词：GET、POST、PUT、DELETE。它们分别对应四种基本操作：GET用来查询商品数据，POST用来新建资源（也可以用于更新资源），PUT用来修改数据，DELETE用来删除商品。  

页面获取数据的形式：客户端（浏览器等）向服务器发送ajax请求，然后服务端返回一个JSON，利用js解析JSON就可以获得我们需要的数据。下面详细说明  
#### 查询
查询时，首先访问index.jsp页面，页面会发送ajax请求查询数据，ProductsController接受请求，查出数据，转化为JSON格式传到页面，页面进行解析展示。  
分页使用pageHelper插件，[使用文档](https://github.com/pagehelper/Mybatis-PageHelper/blob/master/wikis/zh/HowToUse.md)。  
index.jsp发送ajax请求进行数据查询，服务端返回JSON，解析之后使用dom将数据填充到页面中或改变页面。  
新建一个控制器ProductsController.java，编写方法  
```
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
```
`@ResponseBody`表示将返回对象转为JSON字符串  
`@RequestMapping("/pros")`表示处理请求地址映射的注解，也就是遇到pros请求会调用该方法  
`@RequestParam(value = "pn", defaultValue = "1")`表示传入参数，也就是查询的页码  
productsService是自动注入的ProductsService实例，其getAll方法用来调用dao层方法实现数据的查询操作。  
将查询结果封装到PageInfo对象中，  
另外新建一个标志类Msg.java识别请求是否成功，用一个Map保存数据返回给浏览器。将Msg作为一个通用的返回类型。  
在index.jsp中编写ajax请求  
```
function to_page(pn){
	$.ajax({
		url:"${APP_PATH}/pros",
		data:"pn="+pn,
		type:"GET",
		success:function(result){
			
		}
	});
}
```
url请求路径，data传入页码参数pn。表示调用控制器的getProductsWithJson方法  
在回调函数中利用js解析JSON，可以在url输入`http://localhost:8080/commodity-management/pros`查看JSON数据，以便解析。使用dom添加到页面中，具体细节见程序  
为首页，上一页（末页，下一页）或其他页码增加click事件，利用to_page函数实现分页页面的跳转。  

#### 新增
1. 首先在页面点击新增按钮  
2. 其中类别信息要利用get请求从数据库中找到所有种类，返回给下拉列表进行选择  
3. 弹出新增的对话框，输入信息  
4. 对输入信息进行商品查重和格式验证  
5. 点击保存按钮，发送post请求进行保存。  

发送ajax请求查询数据使用get，然后遍历返回的数据，将其添加到下拉列表的select中  
```
$.ajax({
	url:"${APP_PATH}/depts",
	type:"GET",
	success:function(result){
		//在下拉列表中显示种类信息
		$.each(result.extend.depts,function(){
			var optionEle = $("<option></option>").append(this.cateName).attr("value",this.cateId);
			optionEle.appendTo(ele);
		});
	}
});
```
新建控制器CategoryController.java，  
```
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
```
调用的service层方法  
```
@Service
public class CategoryService {
	
	@Autowired
	private CategoryMapper categoryMapper;

	public List<Category> getDepts() {
		List<Category> list = categoryMapper.selectByExample(null);
		return list;
	}
}
```
在新增的模态框将新的商品信息填好之后，点击保存按钮，就要将数据添加到数据库。  
在ProductsService.java中新增  
```
@RequestMapping(value="/emp",method=RequestMethod.POST)
@ResponseBody
public Msg saveEmp(Products products) {
	productsService.saveEmp(products);
	return Msg.success();
}
```
同时写service层  
```
public void saveEmp(Products product) {
	productsMapper.insertSelective(product);
}
```
然后在页面发送ajax请求，进行保存。  
##### 数据格式检验
**js验证**  
利用js的正则表达式对input标签的值（输入信息）进行验证，如果和正则表达式不匹配（验证失败）就添加boostrap校验失败状态的样式，并且在下面的span标签内增加失败信息，作提示。  
**校验商品是否已存在**  
此时需要访问数据库，要在controller层编写方法，不贴代码了，思想就是按照proName用countByExample方法查找表返回数据数量，如果返回0则没有该名字的商品存在；如果返回值不为0，则商品已存在，添加则失败。  
而前端并不知道商品名是否存在，需要把Msg的code状态码当作标识。但ajax的回调函数外又不能访问到该变量，所以在函数内根据code为保存按钮增加一个用来判断的属性。  
页面判断该属性的值间接判断商品是否已存在。  
**JSR303校验**  
首先添加jar包依赖，pom中有说明  
为需要验证的Products字段增加注解  
```
@Pattern(regexp="(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+)"
,message="商品名必须是中文开头或者3-16位英文和数字的组合")
```
```
@Pattern(regexp="^[a-zA-Z0-9]{6,10}",
message="货号必须是6-10位字母数字的组合")
```
并且在ProductsController.java中的保存方法的参数列表中增加`@Valid`注解，并用BindingResult封装校验结果。  

#### 修改
1. 点击修改按钮，弹出信息框  
2. 根据点击的按钮的id显示商品的数据  
3. 输入信息后点击保存按钮发送put请求进行保存。  

首先编写模态框，与新增的模态框差不多。改下id就可以了。  
然后为修改按钮绑定事件，这里用到  
```
$(document).on("click", 元素, function(){

}
```
这是因为按钮是build_pros_table函数后来填充到页面上的，直接用元素绑定click事件不生效。  

然后查询对应id的数据填到表中。  
在ProductsController.java中新建方法  
```
@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
@ResponseBody
public Msg getEmp(@PathVariable("id")Integer id){
	
	Products product = productsService.getEmp(id);
	return Msg.success().add("emp", product);
}
```
用到的productsService.getEmp方法  
```
public Products getEmp(Integer id) {
	Products product = productsMapper.selectByPrimaryKey(id);
	return product;
}
```
@PathVariable("id")指定从路径的id中取到值  

发送ajax，get方式请求，在回调函数中将数据显示在页面中。  
```
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
```
填写数据，为修改按钮增加事件。同样增加格式验证。然后发送put类型的ajax请求，进行保存。  
在controller层处理保存的请求。  
```
@ResponseBody
@RequestMapping(value="/emp/{proId}",method=RequestMethod.PUT)
public Msg saveEmp(Products product){
	productsService.updateEmp(product);
	return Msg.success()	;
}
```
用到的service方法  
```
public void updateEmp(Products product) {
	productsMapper.updateByPrimaryKeySelective(product);
}
```
页面的ajax请求为PUT类型，部署在tomcat上，提示SQL语法错误，检查了一下是因为没有传入数据，只有id信息。  

**原因：**  
Tomcat将请求体中的数据，封装一个map。 request.getParameter("proName")就会从这个map中取值。  
SpringMVC封装POJO对象的时候。 会用request.getParamter();得到POJO每个属性的值。  

但是只有POST形式的请求才封装请求体为map，Tomcat遇见PUT请求不会封装请求体中的数据为map。  

所以AJAX发送PUT请求，request.getParameter("proName")拿不到请求体中的数据。  
查看tomcat源码发现，只有在请求是POST时才会继续后续工作，否则会直接返回。  

**解决方案：**
配置上HttpPutFormContentFilter，将请求体中的数据解析包装成一个map。 request.getParameter()被重写，就会从自己封装的map中取数据。  

#### 删除
支持单个删除和自定义删除。  
处理请求为/emp/{ids}，判断ids是一个id还是包含多个。然后再进行删除操作。  
控制层：  
```
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
```
对应的service层：  
```
public void deleteEmp(Integer id) {
	productsMapper.deleteByPrimaryKey(id);
}

public void deleteBatch(List<Integer> ids) {
	ProductsExample example = new ProductsExample();
	Criteria criteria = example.createCriteria();
	criteria.andProIdIn(ids);
	productsMapper.deleteByExample(example);
}
```
deleteEmp方法直接按主键id单独删除，deleteBatch方法批量删除。  
为前端页面增加复选框，达到多项删除的目的。  
前端代码不贴了，见程序吧。  

## 总结

前端页面发送请求后，前端控制器会分发请求（如果能处理的话），交给对应的控制器来处理请求。  
在web.xml中，DispatcherServlet映射配置为"/"，则Spring MVC将捕获Web容器所有的请求，包括静态资源的请求。  
如果处理器不能处理，在dispatcherServlet-servlet.xml配置文件中添加`<mvc:default-servlet-handler/>`，交给tomcat处理。  
实际上会对进入前端控制器的URL进行检查，如果是静态资源请求，就由Web应用服务器默认的Servlet处理，如果不是静态请求才会用DispatcherServlet处理。  
经过service层，在dao层操作数据库，进行相应的增删改查操作。然后返回JSON格式的字符串，交给前端页面，用js即可解析出数据。反馈到页面中。  

## 注意  
因为要把服务端返回的数据封装成一个JSON，用到`@ResponseBody`注解。需要导入jack-databind的jar包依赖，我添加后，运行tomcat总是(显示enter a problem)启动失败，网上找了许多方法也没解决。晚上思考的时候感觉是版本问题，赶紧下床开电脑将版本由2.8.8换成2.8.3，测试后成功解决问题。  
主要是缺乏经验，没想到版本会这么重要。  