<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.tjoeun.memoList.DBUtill"%>
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

수정이다

<%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String password = request.getParameter("password");
String memo = request.getParameter("memo");
String ip = request.getRemoteAddr();

Connection conn = DBUtill.getMysqlConnection();
// out.print(conn);

/* // String sql = "insert into memolist (name, password, memo, ip) values ('" + name + "', '" + password + "', '" + memo + "', '" + ip + "')";
// out.print(sql);

String sql = String.format("insert into memolist (name, password, memo, ip) values ('%s', '%s', '%s', '%s')", name, password, memo, ip);
// out.print(sql);

Statement stmt = conn.createStatement();
stmt.executeUpdate(sql); */

String sql = "insert into memolist (name, password, memo, ip) values (?, ?, ?, ?)"; 

PreparedStatement pstmt = conn.prepareStatement(sql);

pstmt.setString(1, name);          // 데이터타입에맞게set메소드 고른다. int면 setInt
pstmt.setString(2, password);
pstmt.setString(3, memo);
pstmt.setString(4, ip);              // 다 채웠다. 이제서야 명령문이 완전해졌다. 이제 명령실행. 
//sql 명령을 실행한다.
pstmt.executeUpdate();    

DBUtill.close(conn);
response.sendRedirect("memoList4.jsp");


%>

</body>
</html>