<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <script type="text/javascript">
        $.ajax({
            url: '../dto/dto',
            dataType: 'json',
            success: function (data) {
                    var myChart = echarts.init(document.getElementById('main1'));
                var option = {
                        title: {
                            text: '用户所在城市分布图',
                            subtext: '详情',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'item'
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            data: ['人数']
                        },
                        visualMap: {
                            min: 0,
                            max: 200,
                            left: 'left',
                            top: 'bottom',
                            text: ['高', '低'],
                            calculable: true
                        },
                        toolbox: {
                            show: true,
                            orient: 'vertical',
                            left: 'right',
                            top: 'center',
                            feature: {
                                mark: {show: true},
                                dataView: {show: true, readOnly: false},
                                restore: {show: true},
                                saveAsImage: {show: true}
                            }
                        },
                        series: [

                            {
                                name: '人数',
                                type: 'map',
                                mapType: 'china',
                                roam: false,
                                label: {
                                    normal: {
                                        show: false
                                    },
                                    emphasis: {
                                        show: true
                                    }
                                },
                                data: data.success
                            }]
                    }
                    //使用刚指定的配置项和数据显示图表
                    myChart.setOption(option);
                }
            })
    </script>
    <%--为Echarts准备一个具备大小（宽高）的dom--%>
    <div id="main1" style="width:1000px;height: 500px;"></div>
</html>
