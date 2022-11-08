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
	Connection conn = null;
	
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/javaam?useUnicode=true&characterEncoding=UTF-8";
		conn = DriverManager.getConnection(url, "root", "0000");
		// 데이터베이스와 연결이 되엇으므로 데이터베이스를 사용한다.
		out.print("연결성공: " + conn + "<br/>");
	} catch (ClassNotFoundException e) {
		out.print("드라이버 클래스가 없거나 읽어올수없습니다.");
	} catch (SQLException e) {
		out.print("데이터베이스 접속정보가 올바르지 않습니다.");
	} finally {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) { e.printStackTrace();
		}
	}}
%>

</body>
</html>