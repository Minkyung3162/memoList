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
<title>삭제할 글 보기</title>
</head>
<body>



<%
request.setCharacterEncoding("UTF-8");
String tempIdx = request.getParameter("idx");
String tempCurrentPage = request.getParameter("currentPage");

// out.print(tempIdx + "," + tempCurrentPage);

if (tempIdx != null && tempCurrentPage != null && tempIdx.trim().length() != 0 && tempCurrentPage.trim().length() != 0) {
	
	// 삭제할 글번호와 돌아갈 페이지 번호가 모두 숫자인가 검사한다.
			try {
				int idx = Integer.parseInt(tempIdx);
				int currentPage = Integer.parseInt(tempCurrentPage);
				
				Connection conn = DBUtill.getMysqlConnection();
				String sql = "select * from memoList where idx = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				ResultSet rs = pstmt.executeQuery();
				
					if(rs.next()) {
						
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E) a h시 mm분 ss초");
%>
			<form action="deleteOK.jsp" method="post">
				<table width="700" align="center" border="1" cellpadding="5" cellspacing="0">
					<tr>
						<th colspan="2">삭제할 글 확인</th>
					</tr>
					<tr>
						<th width="100">글번호</th>
						<th width="600"><%=rs.getInt("idx")%></th>
					</tr>
					<tr>
						<th>이름</th>
						<td><%=rs.getString("name").replace("<", "&lt;").replace(">", "&gt;")%></td>
					</tr>
					<tr>
						<th>작성일</th>
						<td><%=sdf.format(rs.getTimestamp("writeDate"))%></td>
					</tr>
					<tr>
						<th>메모</th>
						<td><%=rs.getString("memo").replace("<", "&lt;").replace(">", "&gt;")%></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<label>
								비밀번호 <input type="password" name="password"/>
							</label>
							<input type="submit" value="삭제하기"/>
							<input type="reset" value="다시쓰기"/>
							<input type="button" value="돌아가기1" onclick="history.back()"/>
							<input type="button" value="돌아가기2" onclick="history.go(-1)"/>
							<input type="button" value="돌아가기3" 
								onclick="location.href='memoList4.jsp?currentPage=<%=currentPage%>'"/>
						</td>
				</tr>	
				</table>	
				
				<input type="hidden" name="idx" value="<%=idx%>"/>   <!-- @@ 왜 안되지?? 그냥바로 idx쓰면 된다돼돼.ㅣ 보기개수 지정된건 세션꺼야ㄷ됨...-->
				<input type="hidden" name="currentPage" value="<%=currentPage%>"/>
				
				
				
			</form>	
					
						

<%				DBUtill.close(conn);		
					} else {
						out.println("<script>");
						out.println("alert(`글은 존재하지 않습니다.`)");
						out.println("location.href='memoList4.jsp'");
						out.println("</script>");
					}
		
				
			} catch(NumberFormatException e) {
				out.println("<script>");
				out.println("alert('삭제할 글번호 또는 돌아갈 페이지 번호가 넘어오지 않았습니다.')");
				out.println("location.href='memoList4.jsp'");
				out.println("</script>");
			}
	
	
} else {
	// 삭제할 글번호와 돌아갈 페이지 번호가 모두 넘어오지 않았으므로 에러 메시지를 출력하고 memoList4.jsp로 보낸다.
	out.println("<script>");
	out.println("alert('삭제할 글번호 또는 돌아갈 페이지 번호가 넘어오지 않았습니다.')");
	out.println("location.href='memoList4.jsp'");
	out.println("</script>");
}



%>




</body>
</html>