<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>echars map</title>
        <!-- 引入echarts.js的js -->
        <script src="js/echarts.min.js"></script>
</head>
<body>
<!-- 创建一个DOM -->
<div id="div" style="width:1000px;height:600px;"></div>
<script type="text/javascript">
       /* $.ajax({
                url:'../dto/dto',
                dataType:'json',
                type:'post',
                success:function (data) {
                        console.log(data.success);
                        var city = [];
                        for (var i = 0; i < data.success.length; i++) {
                                city.push(data.success[i].name)
                        }*/
                        //基于准备好的dom，初始化echarts实例
                        var myChart = echarts.init(document.getElementById('div'));
                        //指定图表的配置项和数据
                        var option = ({
                                title: {
                                        text: '用户所在城市分布图',//主标题文本，支持\n换行
                                        left: 'center',//离容器左侧的距离
                                        top: 'top'//距离容器上测的距离
                                },

                                textStyle: {
                                        color: '#1810ee'//文字的颜色
                                },
                                series: [
                                        {
                                                name: '饼状图',
                                                type: 'pie',//每个系列，通过type决定自己的系列型号
                                                radius: '55%',//设置百分比
                                                //radius: ['30%', '60%'],
                                                data:
                                                [
                                                        {value:400, name:'北京'},
                                                        {value:335, name:'上海'},
                                                        {value:310, name:'广州'},
                                                        {value:274, name:'深圳'},
                                                        {value:235, name:'郑州'}
                                                ],
                                                roseType: 'angle',

                                                itemStyle: {//图形样式 normal，emphasis
                                                        emphasis: {
                                                                shadowBlur: 200,
                                                                shadowOffsetX: 0,
                                                                shadowColor: 'rgba(30, 144, 255, 0.5)'
                                                        },
                                                        normal: {
                                                                label: {
                                                                        show: true,
                                                                        formatter: '{b} : {c} ({d}%)'
                                                                },
                                                                labelLine: {show: true}
                                                        }
                                                },

                                                label: {//饼形图上的文本标签
                                                        normal: {
                                                                textStyle: {
                                                                        color: '#0851ee'
                                                                }
                                                        }
                                                },
                                                labelLine: {//标签的视觉引导线
                                                        normal: {
                                                                lineStyle: {
                                                                        color: '#1810ee'
                                                                }
                                                        }
                                                }

                                        }
                                ]
                        })
                        myChart.setOption(option);
      /*          }
        })*/
</script>
<!--
1.引入echarts.min.js
2.准备DOM
3.初始化echars实例
4.准备数据项
5.调用setOption方法将数据和图标显示在图表上
 -->
</body>
</html>