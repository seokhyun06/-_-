<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
   <%
   
   		request.setCharacterEncoding("UTF-8");
   		String sql = "insert into member_tbl_02 values(?, ?, ?, ?, ?, ?, ?)";
   		
   		Connection conn = DBConnect .getConnection();
   		PreparedStatement ps = conn.prepareStatement(sql);
   		
   		ps.setInt(1, Integer.parseInt(request.getParameter("custno")));
   		
   		ps.setString(2, request.getParameter("custname"));
   		ps.setString(3, request.getParameter("phone"));
   		ps.setString(4, request.getParameter("address"));
   		ps.setString(5, request.getParameter("joindate"));
   		ps.setString(6, request.getParameter("grade"));
   		ps.setString(7, request.getParameter("city"));
   		
   		ps.executeUpdate();
   		
   %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원등록</title>
<jsp:forward page = "index.jsp"></jsp:forward>
</head>
<body>

</body>
</html>