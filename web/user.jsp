<%@page pageEncoding="UTF-8" %>

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
        $('#user_table').datagrid({
            type:'post',
            url:"${pageContext.request.contextPath}/user/selectAll",
            pagination:true,
            singleSelect:true,
            width:1056,
            height:568,
            pageSize:10,
            pageList:[5,10,15,20],
            columns:[[
                {field:'head_img',title:'客户头像',width:100,align:'center',
                    formatter: function(value,row,index){
                        return "<img src='${pageContext.request.contextPath}/"+row.head_img+"' style='height:60px;width:90px'/>"
                    },
                },
                {field:'id',title:'客户编号',width:70,align:'center'},
                {field:'name',title:'客户部门',width:80,align:'center'},
                {field:'legal_name',title:'客户名称',width:80,align:'center'},
                {field:'guru',title:'对接职员',width:110,align:'center',
                    formatter:function (data) {
                        return data.legal_name;
                    }},
                {field:'sex',title:'性别',width:50,align:'center'},
                {field:'city',title:'城市',width:80,align:'center'},
                {field:'phone',title:'手机号',width:100,align:'center'},
                {field:'sign',title:'客户签名',width:150,align:'center'},
                {field:'reg_data',title:'注册时间',width:100,formatter: formatDatebox,align:'center'},
                {field:'status',title:'客户状态',width:100,align:'center',
                    formatter: function(value,row,index){
                        if (value==1){
                            return "<input class='swbutton' value='"+row.id+"' checked/>";
                        } else {
                            return "<input class='swbutton' value='"+row.id+"' />";
                        }
                    }
                },
            ]],
            view: detailview,
            detailFormatter: function(rowIndex, rowData){
                return '<table><tr>' +
                    '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/'+rowData.head_img+'" style="height:50px"></td>' +
                    '<td style="border:0">' +
                    '<p>状态: ' + rowData.status + '</p>' +
                    '<p>法名: ' + rowData.legal_name + '</p>' +
                    '<p>性别: ' + rowData.sex + '</p>' +
                    '<p>手机号: ' + rowData.phone + '</p>' +
                    '<p>签名: ' + rowData.sign + '</p>' +
                    '</td>' +
                    '</tr></table>';
            },
            onLoadSuccess:function(data){
                $(".swbutton").switchbutton({
                    onText:"激活",
                    offText:"冻结",
                    onChange:function(dat){
                        if(dat){
                            $.ajax({
                                type:"POST",
                                datatype:"JSON",
                                url:"${pageContext.request.contextPath}/user/updateByStatus",
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
                                url:"${pageContext.request.contextPath}/user/updateByStatus",
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
                        $("#user_table").datagrid('load');
                    }
                });


            }

        });
    });

</script>

<table id="user_table"></table>


