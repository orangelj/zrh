<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
    th,td{
        text-align: center;
    }
</style>
    <table id="album_table"></table>
    <div id="album_tool">
        <a href="#" id="album_details" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">报告详情</a>
        <a href="#" id="add_album" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true">添加标题</a>
        <a href="#" id="add_chapter" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true">添加章节</a>
        <a href="#" id="download_audio" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true">下载音频</a>
        <a href="#" id="onplay_audio" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true">在线播放</a>
    </div>

    <div id="details" style="display: none">
        <h2>报告详情</h2>
        <table id="details_album" style="width:500px"></table>
        <h2>章节列表</h2>
        <table id="details_chapter"></table>
    </div>
    <div id="addAlbum" style="display: none;">
        <style>
            #addAlbum_form>div{
                text-align: center;
                margin-top: 10px;
            }
        </style>
        <form id="addAlbum_form" method="post" enctype="multipart/form-data">
            <div>
                <label>报告名称</label>
                <input class="easyui-validatebox" type="text" name="title"/>
            </div>
            <div>
                <label>报告评分</label>
                <input class="easyui-validatebox" type="text" name="score" />
            </div>
            <div>
                <label>报告职员</label>
                <input class="easyui-validatebox" type="text" name="author"/>
            </div>
           <div>
                <label>播音</label>
                <input class="easyui-validatebox" type="text" name="beam"/>
            </div>
            <div>
                <label>报告条目</label>
                <input class="easyui-validatebox" type="text" name="count"/>
            </div>
            <div>
                <label>报告内容</label>
                <input class="easyui-validatebox" type="text" name="content"/>
            </div>
           <div>
                <label>图片:</label>
                <input type="file" name="upload" />
            </div>
        </form>
    </div>
    <%--音频播放--%>
    <div id="auto_play" style="display: none;"></div>

    <div id="addChapter" style="display: none;">
        <style>
            #addChapter_form>div{
                text-align: center;
                margin-top: 10px;
            }
        </style>
        <form id="addChapter_form" method="post" enctype="multipart/form-data">
            <div>
                <label>报告名称</label>
                <input class="easyui-validatebox" type="text" name="title"/>
            </div>
            <div>
                <label>报告音频:</label>
                <input type="file" name="upload" />
            </div>
            <input type="hidden" id="album_id" name="album_id">
        </form>
    </div>

    <%----%>

    <script>
        $(function () {
            $("#album_table").treegrid({
                url:'../album/selectAll',
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
                    {field:'title',title:'报告名称',width:100},
                    {field:'url',title:'路径',width:100},
                    {field:'size',title:'报告大小',width:100},
                    {field:'duration',title:'报告时长',width:100},
                    {field:'pub_date',title:'生成时间',width:100}
                ]]
            });
        $("#album_details").click(function () {
            var row = $("#album_table").treegrid("getSelected");
            if(row==null){
                $.messager.confirm("信息提示","请选择报告标题");
            }if (row.author==null){
                $.messager.confirm("信息提示","请选择报告标题");
            }else{
                $("#details").dialog({
                    title:'报告详情',
                    width:400,
                    height:400
                });
            }

            $("#details_chapter").datagrid({
                data:row.children,
                fitColumns:true,
                columns:[[
                    {field:'title',title:'报告名称',width:100},
                    {field:'url',title:'路径',width:100},
                    {field:'size',title:'报告大小',width:100},
                    {field:'duration',title:'报告时长',width:100},
                    {field:'pub_date',title:'生成时间',width:100}
                ]]
            });
        });
        $("#add_album").click(function () {
            $("#addAlbum_form").form({
                url:"../album/insertAlbum",
                onSubmit:function (param) {
                    return $("#addAlbum_form").form("validate");
                },
                success:function (r) {
                    $("#addAlbum").dialog("close");
                    $("#album_table").treegrid('load');
                }
            });
            $("#addAlbum").dialog({
                title:'添加标题',
                width:400,
                height:300,
                modal: true,
                buttons:[{
                    text:'添加',
                    handler:function () {
                        $("#addAlbum_form").submit();
                    }
                },{
                    text:'取消',
                    handler:function () {
                        $("#addAlbum").dialog("close");
                    }
                }]
            });
        });
        //    添加章节

        $("#add_chapter").click(function () {
            var row = $("#album_table").treegrid("getSelected");
            if(row==null){
                $.messager.confirm("信息提示","请选择报告");
            }else {
                if (row.author==null){
                    $.messager.confirm("信息提示","请选择报告");
                }else {
                    $("#album_id").val(row.id);
                    $("#addChapter_form").form({
                        url:"../album/insertChapter",
                        onSubmit:function (param) {
                            return $("#addChapter_form").form("validate");
                        },
                        success:function (r) {
                            $("#addChapter").dialog("close");
                            $("#album_table").treegrid('load');
                        }
                    });
                    $("#addChapter").dialog({
                        title:'添加章节',
                        width:400,
                        height:300,
                        modal: true,
                        buttons:[{
                            text:'添加',
                            handler:function () {
                                $("#addChapter_form").submit();
                            }
                        },{
                            text:'取消',
                            handler:function () {
                                $("#addAlbum").dialog("close");
                            }
                        }]
                    });
                }
            }

        });

//    下载音频
        $("#download_audio").click(function () {
            var row = $("#album_table").treegrid("getSelected");
            if(row==null){
                $.messager.confirm("信息提示","请选择要下载的音频");
            }else {
                if (row.author==null){
                    location.href='../album/selectByChapterByURL?url='+row.url+"&flag=1";
                }else {
                    $.messager.confirm("信息提示","请选择要下载的音频");
                }
            }
        });
    });
        //    在线播放
        $("#onplay_audio").click(function () {
            var row = $("#album_table").treegrid("getSelected");
            if(row==null){
                $.messager.confirm("信息提示","请选择要播放的的音频");
            }else {
                if (row.author==null){
                    $("#auto_play").dialog({
                        title:"音频播放",
                        width:600,
                        height:600,
                        onOpen:function () {
                            $("#auto_play").append(
                                "<video   controls='controls' style='margin: 20px 0px 0px 40px'  autoplay='autoplay'>"
                                +"<source src='../album"+row.url+"' />"
                                +"</video >"
                            );
                        },
                        onClose:function () {
                            $("#auto_play").empty();
                        }
                    });
                }else {
                    $.messager.confirm("信息提示","请选择要播放的音频");
                }
            }
        });
    </script>
</html>