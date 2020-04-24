<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Hei maailma
Hyvästi maailma
<%
for (int i=0; i<10000;i++){
	out.print("Hei maailma<br>" + "\n");
}

%>
</body>
</html>