<%@page pageEncoding="UTF-8" %>

<%-- 会话窗口 --%>
<div id="dialog" style="display: none;padding-top: 45px;" align="center">
    <form method="post" id="form" enctype="multipart/form-data">
        <table>
            <tr>
                <td>设备状态:</td>
                <td>
                    <input name="status" id="status_btn" class="easyui-switchbutton" data-options="onText:'在线',offText:'冻结'"/>
                </td>
            </tr>
            <tr>
                <td>设备图片:</td>
                <td>
                    <input type="file" name="upload"  style="width: 200px"/>
                </td>
            </tr>
            <tr>
                <td>设备名称:</td>
                <td>
                    <input type="text" name="title" class="easyui-validatebox" data-options="required:true"/>
                </td>
            </tr>
            <tr>
                <td>设备描述:</td>
                <td>
                <textarea name="description">
                    请输入描述信息!~
                </textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<script>
    $(function(){
        Date.prototype.format = function (format) {
            var o = {
                "M+": this.getMonth() + 1, // month
                "d+": this.getDate(), // day
                "h+": this.getHours(), // hour
                "m+": this.getMinutes(), // minute
                "s+": this.getSeconds(), // second
                "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
                "S": this.getMilliseconds()
                // millisecond
            }
            if (/(y+)/.test(format))
                format = format.replace(RegExp.$1, (this.getFullYear() + "")
                    .substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(format))
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            return format;
        };
        function formatDatebox(value) {

            if (value == null || value == '') {
                return '';
            }
            var dt;
            if (value instanceof Date) {
                dt = value;
            } else {
                dt = new Date(value);
            }

            return dt.format("yyyy-MM-dd");
        };
        $('#bndg').datagrid({
            type:'post',
            url:"${pageContext.request.contextPath}/banner/selectAll",
            pagination:true,
            singleSelect:true,
            width:1056,
            height:568,
            pageSize:20,
            pageList:[5,10,15,20],
            toolbar: '#bntb',
            columns:[[
                {field:'id',title:'设备编码',width:100,align:'center'},
                {field:'title',title:'设备名称',width:250,align:'center'},
                {field:'description',title:'设备描述',width:250,align:'center'},
                {field:'pub_date',title:'设备创建时间',width:150,formatter: formatDatebox,align:'center'},
                {field:'status',title:'设备状态',width:100,align:'center',
                    formatter: function(value,row,index){
                        if (value==1){
                            return "<input class='swbutton' value='"+row.id+"' checked/>";
                        } else {
                            return "<input class='swbutton' value='"+row.id+"' />";
                        }
                    }
                },
                {field:'img_path',title:'设备图片路径',width:170,align:'center',
                 /*   formatter: function(value,row,index){
                        return "<img src='${pageContext.request.contextPath}/"+row.img_path+"' style='height:50px;width:70px'>"
                    },  */
                }
            ]],
            view: detailview,
            detailFormatter: function(rowIndex, rowData){
                return '<table><tr>' +
                    '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/'+rowData.img_path+'" style="height:50px;"></td>' +
                    '<td style="border:0">' +
                    '<p>状态: ' + rowData.status + '</p>' +
                    '<p>名字: ' + rowData.title + '</p>' +
                    '<p>描述: ' + rowData.description + '</p>' +
                    '</td>' +
                    '</tr></table>';
            },
            onLoadSuccess:function(data){
                $(".swbutton").switchbutton({
                    onText:"在线",
                    offText:"冻结",
                    onChange:function(dat){
                        if(dat){
                            $.ajax({
                                type:"POST",
                                datatype:"JSON",
                                url:"${pageContext.request.contextPath}/banner/updateBanner",
                                data:{"id":$(this).val(),"status":"1"},
                                success:function(data){
                                    $.messager.show({
                                        title:'提示信息',
                                        msg:data.message,
                                        timeout:5000,
                                        showType:'slide'
                                    });
                                }
                            });
                        }else{
                            $.ajax({
                                type:"POST",
                                datatype:"JSON",
                                url:"${pageContext.request.contextPath}/banner/updateBanner",
                                data:{"id":$(this).val(),"status":"0"},
                                success:function(data){
                                    $.messager.show({
                                        title:'提示信息',
                                        msg:data.message,
                                        timeout:5000,
                                        showType:'slide'
                                    });
                                }
                            });
                        }
                        $("#bndg").datagrid('load');
                    }
                });


            }

        });
    });

    //添加轮播图
    $("#addBtn").click(function () {
        //初始化
        $("#form").form({
            url: '../banner/insert',
            onSubmit: function (param) {
                //完成表单验证
                return $("#form").form('validate');
            },
            success: function (r) {
                //关闭会话框
                $("#dialog").dialog('close');
                //同时刷新数据
                $("#bndg").datagrid('load');
            }
        });
        // 会话窗口
        $("#dialog").dialog({
            title:'设备添加',
            iconCls:'icon-edit',
            width:350,
            height:350,
            modal:true,  //遮盖效果
            buttons:[{   //添加按钮
                text:'提交',
                iconCls:'icon-ok',
                handler:function () {
                    //提交表单
                    $("#form").submit();
                }
            }]
        });
    });

    <%--删除--%>
    $("#delete").click(function () {
        var hang = $("#bndg").datagrid("getSelected");
        if(hang){
            var id = hang.id;
            $.ajax({
                url:'../banner/delete?id='+id,
                success:function (data) {
                    $("#bndg").datagrid("load");
                }
            })
        }else{
            $.messager.alert('温馨小提示','亲，请选择要删除的行哦！','warning');
        }
    })
    $("[name='status']").val(1);
    $("#status_btn").switchbutton({
        checked:true,
        onChange:function (btn) {
            if(btn==true){
                $("[name='status']").val(1);
            }
            if(btn==false){
                $("[name='status']").val(0);
            }
        }
    })
</script>

<table id="bndg"></table>

<div id="bntb">
    <a href="#" class="easyui-linkbutton" id="addBtn"  data-options="iconCls:'icon-edit',plain:true">设备添加</a>
    <a href="#" class="easyui-linkbutton" id="delete" data-options="iconCls:'icon-help',plain:true">设备删除</a>
</div>


