<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>后台管理主页</title>
<link rel="stylesheet" type="text/css" href="../themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">   
<script type="text/javascript" src="../js/jquery.min.js"></script>   
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>  
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aT9QCEzrlup2GzhbtNr7L0UxGt2L9jnh"></script>

<script src="../js/echarts.js"></script>

    <script src="../js/china.js"></script>
<script type="text/javascript">
	<!--菜单处理-->
</script>

</head>
<body class="easyui-layout">   
    <div data-options="region:'north',split:true" style="height:60px;background-color: #565c39">
    	<div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px" >后台管理系统</div>
    	<div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">欢迎:${sessionScope.username} &nbsp;<a href="#" id="up" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a href="javascript:void(0);" id="exit" class="easyui-linkbutton" data-options="iconCls:'icon-01'">退出系统</a></div>
    </div>   
    <div data-options="region:'south',split:true" style="height: 50px;background: #565c39">
    	<%--<div style="text-align: center;font-size:30px; color: #FAF7F7;font-family: 楷体" >&copy;中瑞恒科技公司 @liangjie.com.cn</div>--%>
    </div>

    <div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    	<div id="aa" class="easyui-accordion" data-options="fit:true">
    		
		</div>  
    </div>   
    <div data-options="region:'center'">
    	<div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
<%--
		    <div title="主页" data-options="iconCls:'icon-neighbourhood',"  ;background-repeat: no-repeat;background-size:100% 100%;"></div>
--%>
                <div id="container"></div>
		</div>
    </div>
    <div id="test2" style="display: none;text-align: center;padding-top: 60px">
        <form id="form2" >
            <p style="margin-bottom: 30px">
                <input id="password2" data-options="required:true" class="easyui-validatebox" style="width:150px">
            </p>
            <p>
                <input id="password3" data-options="required:true" class="easyui-validatebox" name="password" style="width:150px">
            </p>
        </form>
    </div>
</body>
<script>
    $("#password2").passwordbox({
        showEye: true,
        iconAlign:'right',
        prompt:'password',
        label:'原密码 : ',
    });
    $("#password3").passwordbox({
        showEye: true,
        iconAlign:'right',
        prompt:'password',
        label:'新密码 : ',
    });
    $(function () {
        $.ajax({
            type:'post',
            datatype:'json',
            url:'../menu/selectAll',
            success:function (data) {
                var menu = data.success;
                $.each(menu,function (index,menu) {
                    var content = "<div align='center'style='margin-top: 10px;'>";
                    $.each(menu.children,function (i,child) {
                        var childs = JSON.stringify(child);
                        content+="<a class='easyui-linkbutton' data-options='iconCls:\""+child.iconCls+"\"' onclick='addTab("+childs+")' style='margin-top: 3px'>"+child.title+'</a>';
                    });
                    content+="</div>";

                    $("#aa").accordion('add',{
                        title:menu.title,
                        iconCls:menu.iconCls,
                        content:content,
                        selected:false
                    });
                });
            }
        });
    });

    //点击添加选项卡
    function addTab(child) {
        var tit = $("#tt").tabs('exists',child.title);

        if(!tit){
            $("#tt").tabs("add",{
                title:child.title,
                href:'../'+child.url,
                closable:true,
                tools:[{
                    iconCls:child.iconCls,
                    handler:function () {
                    }
                }]
            });
        }else {
            $("#tt").tabs('select',child.title);
        }
    }

    $("#exit").click(function () {
        $.ajax({
            url:'../admin/exit',
            dataType:'json',
            type:'post',
            success:function (data) {
                if(data.success==200){
                    window.location.href='../login.jsp';
                }
            }
        })
    });

    var password = false;

    $("#_easyui_textbox_input1").blur(function () {
        var pwdVal = $("#password2").val();
        console.log(pwdVal)
        if(pwdVal.trim().length!=0){
            $.ajax({
                url:'../admin/password',
                dataType:'json',
                type:'post',
                success:function (data) {
                    // console.log(data.admin.password);
                    // console.log()
                    if(data.admin.password == pwdVal){
                        console.log("正确")
                        password=true;
                    }else {
                        $.messager.confirm("温馨小提示","原密码不正确呦！","error");
                    }
                }
            })

        }

    });
    $("#up").click(function () {
        //初始化
        $("#form2").form({
            url: '../admin/updateByPassword',
            onSubmit: function (param) {
                //完成表单验证
                return $("#form2").form('validate');
            },
            success: function (r) {
                $.messager.confirm("温馨小提示","密码修改成功！","ok");
            }
        });
        // 初始化会话窗口
        $("#test2").dialog({
            title: '修改密码',
            iconCls: 'icon-edit',
            width: 400,
            height: 300,
            modal: true,  //遮盖效果
            buttons: [{
                text: '提交',
                iconCls: 'icon-edit',
                handler: function () {
                    //提交表单
                    $("#form2").submit();
                    $("#test2").dialog('close');
                }
            }]
        });
    })
    $(function () {
// 百度地图API功能
        var map = new BMap.Map("container");
        var point = new BMap.Point(116.417854,39.921988);
        var marker = new BMap.Marker(point);  // 创建标注
        map.addOverlay(marker);              // 将标注添加到地图中
        map.centerAndZoom(point, 15);
        var opts = {
            width : 200,     // 信息窗口宽度
            height: 100,     // 信息窗口高度
            title : "海底捞王府井店" , // 信息窗口标题
            enableMessage:true,//设置允许信息窗发送短息
            message:"亲耐滴，晚上一起吃个饭吧？戳下面的链接看下地址喔~"
        }
        var infoWindow = new BMap.InfoWindow("地址：北京市东城区王府井大街88号乐天银泰百货八层", opts);  // 创建信息窗口对象
        marker.addEventListener("click", function(){
            map.openInfoWindow(infoWindow,point); //开启信息窗口
        });
    })
</script>
</html>