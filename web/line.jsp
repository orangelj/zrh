
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <script src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>
</head>
<body>
    <div id="myChart" style="width:600px;height: 400px;"></div>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/echarts.js"></script>
    <script>

        var goEasy = new GoEasy({
            appkey: "BC-39419ba4feae497a8f616b8fc931252f"
        });
        goEasy.subscribe({
            channel: "my_channel",
            onMessage: function (message) {
               fun(JSON.parse(message.content).counts);
            }
        })


        $.ajax({
            url:'admin/total',
            dataType:'json',
            type:'post',
            success:function (data) {
                //基于准备好的dom，初始化echarts实例
                fun(data.success);
            }
        })

        function fun(data) {
            var myChart = echarts.init(document.getElementById('myChart'));
            //指定图表的配置项和数据
            var option = {
                title:{
                    text:'用户人数变更图'
                },
                tooltip:{},
                legend:{
                    data:['柱状图','折线图']
                },
                xAxis:{
                    data:["人数"]
                },
                yAxis:{},
                series:[{
                    name:'柱状图',
                    type:'bar',
                    data:[data],
                    itemStyle:{
                        color:'#9cd9ff'
                    }
                }]
            };
            //使用刚指定的配置项和数据显示图表
            myChart.setOption(option);
        }
    </script>
</body>
</html>
