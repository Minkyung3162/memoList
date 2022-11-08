package com.tjoeun.memoList;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtill {

	public static Connection getMysqlConnection() {
		
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/javaam?useUnicode=true&characterEncoding=UTF-8";
			conn = DriverManager.getConnection(url, "root", "0000");
			
			// 데이터베이스와 연결이 되엇으므로 데이터베이스를 사용한다.
			// System.out.print("연결성공: " + conn + "<br/>");
			
		} catch (ClassNotFoundException e) {
			System.out.print("드라이버 클래스가 없거나 읽어올수없습니다.");
		} catch (SQLException e) {
			System.out.print("데이터베이스 접속정보가 올바르지 않습니다.");
		} 
		return conn;
	}
	
	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) { e.printStackTrace();
		}
	}
	}
	
	
}


