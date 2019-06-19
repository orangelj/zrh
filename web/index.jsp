
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>

  </body>
<%--  <script src="​http://cdn-hangzhou.goeasy.io/goeasy.js​"></script>--%>
  <script src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>
<script>
    var goEasy = new GoEasy({
      appkey: "BC-39419ba4feae497a8f616b8fc931252f"
    });
    goEasy.subscribe({
      channel: "my_channel",
      onMessage: function (message) {
        alert("Channel:" + message.channel + " content:" + message.content);
      }
    })
</script>
</html>
