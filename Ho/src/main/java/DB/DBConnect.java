package DB;

import java.sql.*;

public class DBConnect {

            public static Connection  getConnection() {
                
                Connection conn = null;    // Connection(연결객체) 변수 conn 선언
                
                String url = "jdbc:oracle:thin:@localhost:1521:xe";  // 연결 드라이버 주소
                String id = "system";   // 계정아이디
                String pw = "1234";   //계정비번
                
                try {     //로그인 실패를 고려한 예외처리 
                        Class.forName("oracle.jdbc.OracleDriver");
                        conn = DriverManager.getConnection(url, id, pw);
                        System.out.println("DB 연결 성공");
                        
                    } catch(Exception e) {  
                    	e.printStackTrace(); 
                    	System.out.println("DB 연결 실패");
                    }
                		return conn;
                }            

		}