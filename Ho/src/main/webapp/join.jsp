<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>
    
   <%	
   
   		String sql = "select max(custno) from member_tbl_02";
		//DB 연결 기능을 객체변수 conn 에 저장 -> 1.DB 연결
   		Connection conn = DBConnect.getConnection();
   		// sql변수에 저장되어 있는 문장이 쿼리문이 됨 -> 2. DB 연결 후 쿼리문이 생성
   		// PreparedStatement <- 쿼리문 형식으로 변환 해준다.
   		
   		PreparedStatement ps = conn.prepareStatement(sql);
   		// 변수 pstmt에 저장되어 있는 SQL문을 실행하여 객체 변수 rs에 저장
   		// 쿼리문 결과값을 받아온다.
   		
   		ResultSet rs = ps.executeQuery();
   		// 기준이 되는 변수에 결과값이 저장되어 있는 경우 next()를 호출하여 마지막 값을 확인
   		// 결과값이 없을 경우엔 실행 하지 않아도 됨.
   		
   		rs.next();
   		
   		int num = rs.getInt(1) + 1;
   
   %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<link rel ="stylesheet" href = "css/style.css">
<script type="text/javascript">
	function checkValue(){
		if(!document.data.custno.value){
			alert("회원성명을 확인해주세요");
			data.custno.foucs();
			return false
			
		} else if(!document.data.custname.value){
			alert("회원이름을 확인해주세요");
			data.custname.foucs();
			return false
			
		} else if(!document.data.phone.value){
			alert("전화번호를 확인해주세요");
			data.phone.foucs();
			return false
			
		} else if(!document.data.address.value){
			alert("주소를 확인해주세요");
			data.address.foucs();
			return false
			
		} else if(!document.data.joindate.value){
			alert("가입일자를 확인해주세요");
			data.joindate.foucs();
			return false
			
		} else if(!document.data.grade.value){
			alert("고객등급을 확인해주세요");
			data.grade.foucs();
			return false
			
		} else if(!document.data.city.value){
			alert("도시코드를 확인해주세요");
			data.city.foucs();
			return false
			
		}
			alert("회원등록이 완료되었습니다.")
			return true;

	}

</script>
</head>
<body>
<header>
	<jsp:include page = "layout/header.jsp"></jsp:include>
</header>

<nav>
	<jsp:include page = "layout/nav.jsp"></jsp:include>

</nav>
<section class = "section">
	<h2> 회원등록 </h2>
	<form name = "data" method = "post" onsubmit = "return checkValue()" action = "join_p.jsp">
		<table class = "table_style">
		
		<tr>
			<th>회원번호</th>
			<td><input type = "text" name = "custno" value = "<%=num%>" readonly></td>
		</tr>
		
		<tr>
			<th>회원성명</th>
			<td><input type = "text" name = "custname" value = ""></td>
		</tr>
		
		<tr>
			<th>회원전화</th>
			<td><input type = "text" name = "phone" value = ""></td>
		</tr>
		
		<tr>
			<th>회원주소</th>
			<td><input type = "text" name = "address" value = ""></td>
		</tr>
		
		<tr>
			<th>가입일자</th>
			<td><input type = "text" name = "joindate" value = ""></td>
		</tr>
		
		<tr>
			<th>고객등급[A:VIP, B:일반, C:직원]</th>
			<td><input type = "text" name = "grade" value = ""></td>
		</tr>
		
		<tr>
			<th>도시코드</th>
			<td><input type = "text" name = "city" ></td>
		</tr>
		
		<tr>
			<th colspan="2">
			<input type = "submit" value = "등록">
			<input type = "button" onclick = "location.href = 'join.jsp'" value = "취소">
			<input type = "button" onclick = "location.href = 'member_list.jsp'" value = "조회"></th> <!-- "location.href = 는 현재 브라우저에 연결페이지 로딩" -->
		</tr>
		</table>
	</form>
</section>

<footer>
	<jsp:include page = "layout/footer.jsp"></jsp:include>
</footer>

</body>
</html>