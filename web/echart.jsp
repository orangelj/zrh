<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
        <%--为echarts准备一个具备大小（宽高）的Dom--%>
        <div id="main" style="width: 1000px;height: 500px;"></div>
        <%--引入 echarts.js--%>
        <script type="text/javascript">
            $.ajax({
                url:'../dto/dto',
                dataType:'json',
                type:'post',
                success:function (data) {
                    console.log(data.success);
                    var city = [];
                    for (var i=0;i<data.success.length;i++){
                        city.push(data.success[i].name)
                    }
                    //基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main'));
                    //指定图表的配置项和数据
                    var option = {
                        title:{
                            text:'用户所在城市分布图'
                        },
                        tooltip:{},
                        legend:{
                            data:['柱状图','折线图']
                        },
                        xAxis:{
                            data:city
                        },
                        yAxis:{},
                        series:[{
                            name:'柱状图',
                            type:'bar',
                            data:data.success,
                            itemStyle:{
                                color:'#9ef8ff'
                            },
                        },{
                            name:'折线图',
                            type:'line',
                            lineStyle:{
                              color:'#5c46ff'
                            },
                            data:data.success
                        }]
                    };
                    //使用刚指定的配置项和数据显示图表
                    myChart.setOption(option);
                }
            })
        </script>
</html>
