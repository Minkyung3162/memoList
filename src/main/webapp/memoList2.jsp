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

button {
	border: 0px;
	background-color: white;
	font-size: 20px;
}

#ta {
	background-color: lightgreen;
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
	int pageSize = 10;
	int totalCount = 0;
	int totalPage = 0;
	int currentPage = 1;
	int startNo = 0;
	int endNo = 0;
	int startPage = 0;
	int endPage = 0;
	
	Connection conn = DBUtill.getMysqlConnection();

//	totalCount 변수에 테이블에 저장된 전체 글의 개수를 얻어와서 저장한다.
	String sql = "select count(*) from memoList";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	rs.next();  // 이거 안쓰면 에러남.. 
	totalCount = rs.getInt(1);
//	out.println("테이블에 저장된 전체 글의 개수: " + totalCount + "개<br/>");
	
// 	totalPage = ((totalCount % pageSize) == 0) ? totalCount/pageSize : (totalCount/pageSize) + 1;
	totalPage = (totalCount - 1) / pageSize + 1;  
//	out.println("전체 페이지 개수: " + totalPage + "개<br/>");
	
	
	
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		currentPage = currentPage > totalPage ? totalPage : currentPage;
		
	} catch (NumberFormatException e) {
		
	}
	
	startNo = (currentPage -1) * pageSize; 
	endNo = startNo + pageSize - 1;
	endNo = endNo > totalCount ? totalCount : endNo;
	
	sql = "select * from memoList order by idx desc limit ?, ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, startNo);
	pstmt.setInt(2, pageSize);
	rs = pstmt.executeQuery();
%>
	
	<table width="1200" align="center" border="1" cellpadding="5" cellspacing="0">
	
		<tr>
			<th id="ta" width="80">글번호</th>
			<th id="ta" width="80">이름</th>
			<th id="ta" width="840">메모</th>
			<th id="ta" width="120">작성일</th>
			<th id="ta" width="80">ip</th>
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

		<tr>
			<td colspan="5" align="center">
	<%
				for (int i=1; i<=totalPage; i++) {
					if (i == currentPage) {
	%>
						<button type="button" disabled="disabled"><%=i%></button>
	<% 
					} else {
	%>
						<button type="button" onclick="location.href='?currentPage=<%=i%>'"><%=i%></button>
	<%
					}
				}
	%>				
			</td>		
		</tr>

	</table>
	

</body>
</html>