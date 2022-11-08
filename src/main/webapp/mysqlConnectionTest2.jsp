<%@page import="com.tjoeun.memoList.DBUtill"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	Connection conn = DBUtill.getMysqlConnection();
		// 데이터베이스와 연결이 되엇으므로 데이터베이스를 사용한다.
		out.print("연결성공: " + conn + "<br/>");
	DBUtill.close(conn);
	
	
%>

</body>
</html>