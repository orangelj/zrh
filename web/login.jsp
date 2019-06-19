<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>后台管理系统</title>
			
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
	<link rel="icon" href="img/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="css/common.css" type="text/css"></link>
	<link rel="stylesheet" href="css/login.css" type="text/css"></link>
	<link rel="stylesheet" type="text/css" href="themes/icon.css"/>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/IconExtension.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/datagrid-detailview.js"></script>
	<script type="text/javascript" src="script/common.js"></script>
</head>
<body>
		<div class="login">
			<form id="loginForm"  method="post" >
				<table>
					<tbody>
						<tr>
								<td width="200" rowspan="2" align="center" valign="bottom" >
								<%--<img src="img/1.gif" width="100px" height="150px"/>--%>
							</td>
							<th>
								用户名:
							</th>
							<td>
								<input id="username" data-options="required:true" class="easyui-validatebox" name="username" type="text" style="width:150px">
								<%--<input type="text"  name="user.name" class="text" value="xxx" maxlength="20"/>--%>
							</td>
					  </tr>
					  <tr>
							<th>
								密&nbsp;&nbsp;&nbsp;码:
							</th>
							<td>
								<input id="password" data-options="required:true" class="easyui-validatebox" name="password" type="text" style="width:150px">
								<%--<input type="password" name="user.password" class="text" value="xxx" maxlength="20" autocomplete="off"/>--%>
							</td>
					  </tr>

						<tr>
							<td>&nbsp;</td>
							<th>验证码:</th>
							<td>
								<input type="text" id="enCode" name="number" class="text captcha" maxlength="4" autocomplete="off"/>
								<img id="captchaImage" class="captchaImage" src="${pageContext.request.contextPath}/code/image" title="点击更换验证码"/>
							</td>
						</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<th>
							&nbsp;
						</th>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<th>&nbsp;</th>
						<td>
							<input type="button" class="homeButton" value="" onclick="location.href='/'"><input type="button" class="loginButton" id="loginBtn" value="登录">
							<input type="button" class="homeButton" value="" onclick="location.href='/'"><input type="button" class="loginButton" id="registerBtn" value="注册">
						</td>
					</tr>
				</tbody></table>
			</form>
			<div id="test1" style="display: none;text-align: center;padding-top: 60px" >
				<form id="form1" >
					<p style="margin-bottom: 30px">
						<input id="username1" data-options="required:true" class="easyui-validatebox" name="username" style="width:150px">
					</p>
					<p>
						<input id="password1" data-options="required:true" class="easyui-validatebox" name="password" style="width:150px">
					</p>
				</form>
			</div>
			<div class="powered">COPYRIGHT © 2008-2017.</div>
			<div class="link">
				<a href="">后台管理系统</a> |
				<a href="">交流论坛</a> |
				<a href="">关于我们</a> |
				<a href="">联系我们</a> |
				<a href="">授权查询</a>
			</div>
		</div>
</body>
<script>
	$("#username").textbox({
		iconCls:'icon-man',
		iconAlign:'right',
		prompt:'username',

	});

	$("#password").passwordbox({
		iconAlign:'right',
		prompt:'password',
		showEye: true
	});
	$("#username1").textbox({
		iconCls:'icon-man',
		iconAlign:'right',
		prompt:'username',
		label:'username : ',

	});

	$("#password1").passwordbox({
		showEye: true,
		iconAlign:'right',
		prompt:'password',
		label:'password : ',
	});

	//点击更换验证码：
	$("#captchaImage").click(function(){ //点击更换验证码
		$(this).attr('src','${pageContext.request.contextPath}/code/image?'+(new Date()).getTime());
	});



	var code=false;
	$("#enCode").blur(function () {
		var code1 = $(this).val().toLowerCase();
		if(code1.trim().length!=0) {
			$.ajax({
				url: 'admin/code',
				success: function (data) {
					if (data.code == code1) {
						code=true;
					}else {
						$.messager.confirm("温馨小提示","验证码不正确呦！","error");
					}
				}
			})
		}
	});
	//  form 表单提交
	$("#loginBtn").click(function () {
		if(code){
			//初始化
			$("#loginForm").form({
				url: 'admin/login',
				onSubmit: function (param) {
					//完成表单验证
					return $("#loginForm").form('validate');
				},
				success: function (r) {
					if (JSON.parse(r).message==200){
						window.location.href='main/main.jsp';
						// console.log("登陆成功")
					} else {
						$.messager.confirm("温馨小提示","用户名或密码不正确呦！","error");
					}

				},
			});
			$("#loginForm").submit();
		}else {
			$.messager.confirm("温馨小提示","信息不正确呦！","error");
		}

	});

	$("#registerBtn").click(function () {
		//初始化
		$("#form1").form({
			url: 'admin/register',
			onSubmit: function (param) {
				//完成表单验证
				return $("#form1").form('validate');
			},
			success: function (r) {
				$.messager.confirm("提示","注册成功，跳转到主页？",function (r) {
					if (r){
						window.location.href='main/main.jsp';
					} else {
						//关闭会话框
						$("#test1").dialog('close');
					}
				})

			}
		});
		// 初始化会话窗口
		$("#test1").dialog({
			title: '注册',
			iconCls: 'icon-edit',
			width: 400,
			height: 300,
			modal: true,  //遮盖效果
			buttons: [{
				text: '注册',
				iconCls: 'icon-edit',
				handler: function () {
					//提交表单
					$("#form1").submit();
				}
			}]
		});
	})
</script>
</html>