<%@page pageEncoding="UTF-8"%>

<form align="center">
    ID:<input id="ID" class="easyui-validatebox" value="${param.id}" data-options="required:true" /><br><br>
    title:<input id="title" class="easyui-validatebox" value="${param.title }" data-options="required:true" /><br><br>
    头像:<input id="ww" class="easyui-validatebox" value="${param.author }" data-options="required:true" /><br><br>
    时间:<input id="vv" class="easyui-validatebox" value="${param.pub_date}" data-options="required:true" /><br><br>

</form>