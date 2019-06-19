<%@page pageEncoding="UTF-8" %>
<style>
    th,td{
        text-align: center;
    }
</style>
<div id="project_tool">
    <a href="#" id="project_details" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">项目详情</a>
    <a href="#" id="add_project" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true">添加项目</a>
    <a href="#" id="add_banner" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true">添加设备</a>
</div>
<table id="project_table"></table>

<div id="details" style="display: none">
    <h2>项目详情</h2>
    <table id="details_project" style="width:500px"></table>
    <h2>设备列表</h2>
    <table id="details_banner"></table>
</div>
<div id="addproject" style="display: none;">
    <style>
        #addAlbum_form>div{
            text-align: center;
            margin-top: 10px;
        }
    </style>
    <form id="addProject_form" method="post" enctype="multipart/form-data">
        <div>
            <label>项目名称</label>
            <input class="easyui-validatebox" type="text" name="name"/>
        </div>
        <div>
            <label>热效率/%</label>
            <input class="easyui-validatebox" type="text" name="hot" />
        </div>
        <div>
            <label>累计流量/T</label>
            <input class="easyui-validatebox" type="text" name="flow"/>
        </div>
       <div>
            <label>累计耗电量/kw.h</label>
            <input class="easyui-validatebox" type="text" name="power"/>
        </div>
        <div>
            <label>累计耗水量/T</label>
            <input class="easyui-validatebox" type="text" name="water"/>
        </div>
        <div>
            <label>客户名称</label>
            <input class="easyui-validatebox" type="text" name="Guru_id"/>
        </div>
    </form>
</div>

<div id="addbanner" style="display: none;">
    <style>
        #addChapter_form>div{
            text-align: center;
            margin-top: 10px;
        }
    </style>
    <form id="addbanner_form" method="post" enctype="multipart/form-data">
        <div>
            <label>设备名称</label>
            <input class="easyui-validatebox" type="text" name="title"/>
        </div>
        <div>
            <label>设备描述:</label>
            <textarea name="description">
                请输入描述信息!~
            </textarea>
        </div>
        <input type="hidden" id="project_id" name="project_id">
    </form>
</div>

    <%----%>

<script>
    $(function () {
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
        $("#project_table").treegrid({
            url:'../project/selectAll',
            fitColumns:true,
            idField:'id',
            treeField:'title',
            pagination:true,
            width:1056,
            height:568,
            pageSize:20,
            pageList:[2,5,10,15,20],
            toolbar:'#album_tool',
            columns:[[
                {field:'name',title:'项目名称',width:100},
                {field:'hot',title:'热效率/%',width:100},
                {field:'flow',title:'累计流量/T',width:100},
                {field:'power',title:'累计耗电量/kw.h',width:100},
                {field:'water',title:'累计耗水量/T',width:100},
                {field:'guru',title:'对接职员',width:110,align:'center',
                    formatter:function (data) {
                        return data;
                    }},
                {field:'pro_date',title:'项目创建时间',width:100,formatter: formatDatebox,align:'center'},
                {field:'status',title:'项目状态',width:100,align:'center',
                    formatter: function(value,row,index){
                        if (value==1){
                            return "<input class='swbutton' value='"+row.id+"' checked/>";
                        } else {
                            return "<input class='swbutton' value='"+row.id+"' />";
                        }
                    }
                }
            ]]
        });
    $("#project_details").click(function () {
        var row = $("#project_table").treegrid("getSelected");
        if(row==null){
            $.messager.confirm("信息提示","请选择项目");
        }if (row.name==null){
            $.messager.confirm("信息提示","请选择项目");
        }else{
            $("#details").dialog({
                title:'项目详情',
                width:400,
                height:400
            });
        }

        $("#details_banner").datagrid({
            data:row.children,
            fitColumns:true,
            columns:[[
                {field:'name',title:'项目名称',width:100},
                {field:'hot',title:'热效率/%',width:100},
                {field:'flow',title:'累计流量/T',width:100},
                {field:'power',title:'累计耗电量/kw.h',width:100},
                {field:'water',title:'累计耗水量/T',width:100},
                {field:'guru',title:'对接职员',width:110,align:'center',
                    formatter:function (data) {
                        return data;
                    }},
                // {field:'pro_date',title:'项目创建时间',width:100,formatter: formatDatebox,align:'center'},
                {field:'status',title:'项目状态',width:100,align:'center',
                    formatter: function(value,row,index){
                        if (value==1){
                            return "<input class='swbutton' value='"+row.id+"' checked/>";
                        } else {
                            return "<input class='swbutton' value='"+row.id+"' />";
                        }
                    }
                }
            ]]
        });
    });
    $("#add_project").click(function () {
        $("#addProject_form").form({
            url:"../project/insert",
            onSubmit:function (param) {
                return $("#addProject_form").form("validate");
            },
            success:function (r) {
                $("#addProject").dialog("close");
                $("#project_table").treegrid('load');
            }
        });
        $("#addproject").dialog({
            title:'添加项目',
            width:400,
            height:300,
            modal: true,
            buttons:[{
                text:'添加',
                handler:function () {
                    $("#addProject_form").submit();
                }
            },{
                text:'取消',
                handler:function () {
                    $("#addproject").dialog("close");
                }
            }]
        });
    });

    //    添加设备
    $("#add_banner").click(function () {
        var row = $("#project_table").treegrid("getSelected");
        if(row==null){
            $.messager.confirm("信息提示","请选择项目");
        }else {
            if (row.name==null){
                $.messager.confirm("信息提示","请选择项目");
            }else {
                $("#project_id").val(row.id);
                $("#addbanner_form").form({
                    url:"../banner/insert",
                    onSubmit:function (param) {
                        return $("#addbanner_form").form("validate");
                    },
                    success:function (r) {
                        $("#addbanner").dialog("close");
                        $("#project_table").treegrid('load');
                    }
                });
                $("#addbanner").dialog({
                    title:'添加设备',
                    width:400,
                    height:300,
                    modal: true,
                    buttons:[{
                        text:'添加',
                        handler:function () {
                            $("#addbanner_form").submit();
                        }
                    },{
                        text:'取消',
                        handler:function () {
                            $("#addproject").dialog("close");
                        }
                    }]
                });
            }
        }
    });
});
</script>