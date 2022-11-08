<%@page import="java.text.SimpleDateFormat"%>
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

<style type="text/css">

input {
	background-color: pink;
}

[type=submit] {
	background-color: skyblue;
}

</style>

</head>
<body>

	<form action="memoInsert.jsp" method="post">
		<table width="1000" align="center" border="1" cellpadding="5" cellspacing="0">
			<tr>
				<th colspan="3">Mk's의 첫 출첵 게시판 Ver 1.0</th>
			</tr>
			
			<tr>
				<th width="100">이름</th>
				<th width="100">비밀번호</th>
				<th width="800">메모</th>
			</tr>
			
			<tr>
				<td align="center">
					<input type="text" name="name" style="width:90%; height: 25px;"/>
				</td>
				<td align="center">
					<input type="password" name="password" style="width:90%; height: 25px;"/>
				</td>
				<td align="center">
					<input type="text" name="memo" style="width:90%; height: 25px;"/>
					<input type="submit" value="저장" style="height: 30px;"/>
				</td>
			</tr>
		</table>
	</form>

	<br/>
	<hr size="3" color="dodgerblue">
	<br/>
	
	<%
	Connection conn = DBUtill.getMysqlConnection();
	String sql = "select * from memoList order by idx desc";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
// 	if (rs.next()) {
// 		do {
// 			out.println(rs.getInt("idx") + ", ");
// 			out.println(rs.getString("name") + ", ");
// 			out.println(rs.getString("password") + ", ");
// 			out.println(rs.getString("memo") + ", ");
// 			out.println(rs.getTimestamp("writeDate") + ", ");
// 			out.println(rs.getString("ip") + "<br/>");
// 		} while (rs.next());
// 	} else {
// 		// 테이블에 저장된 글이 없는 경우
// 		out.println("테이블에 저장된 글이 없습니다.<br/>");
// 	}
	
	%>
	
	<table width="1200" align="center" border="1" cellpadding="5" cellspacing="0">
	
		<tr>
			<th width="80">글번호</th>
			<th width="80">이름</th>
			<th width="840">메모</th>
			<th width="120">작성일</th>
			<th width="80">ip</th>
		</tr>
	
	<% 
		if(rs.next()) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E)");
			do {
	%>
		<tr>
			<td><%=rs.getInt("idx")%></td>
			<td><%=rs.getString("name") %></td>
			<td><%=rs.getString("memo") %></td>
			<td><%=sdf.format(rs.getTimestamp("writeDate")) %></td>
			<td><%=rs.getString("ip") %></td>
		</tr>
	<% 	
			} while (rs.next());
		} else {
			
	%>
			<tr>
			<td colspan="5">
				<marquee>테이블에 저장된 글이 없습니다.</marquee>
			</td>
		</tr>
	<%
	}	
	%>

	</table>
	
	
	
	
	
	
	
	
	
	 


</body>
</html>