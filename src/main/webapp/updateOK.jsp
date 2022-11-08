
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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

<%
request.setCharacterEncoding("UTF-8");
int idx = Integer.parseInt(request.getParameter("idx"));
int currentPage = Integer.parseInt(request.getParameter("currentPage"));
String password = request.getParameter("password");
String memo = request.getParameter("memo");

Connection conn = DBUtill.getMysqlConnection();
String sql = "select * from memoList where idx = ?";
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setInt(1, idx);
ResultSet rs = pstmt.executeQuery();

rs.next();

out.println("<script>");
if (password.equals(rs.getString("password"))) {
	
	sql = "UPDATE memoList SET MEMO =? where idx = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, memo);
	pstmt.setInt(2, idx);
	pstmt.executeUpdate();
	
	out.println("alert('글 수정완료')");
	
	
} else {
	out.println("alert('비밀번호가 일치하지 않습니다.')");
	
}

rs.close();
pstmt.close();
conn.close();
out.println("location.href='memoList4.jsp?currentPage=" + currentPage + "'");

out.println("</script>");
%>


</body>
</html>