<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>


<html>
<head>
<meta charset="UTF-8">
<title>회원정보조회</title>
<link rel = "stylesheet" href = "css/style.css">
<script type="text/javascript">
	function checkValue2() {
		if(!document.data1.custno.value()){
			alert("회원번호를 입력하세요");
			document.data1.custno.focus();
			return false;
			
		}		
			return ture;
			
	}

</script>
</head>
<body>
<header>
	<jsp:include page="layout/header.jsp"></jsp:include>
</header>

<nav>
	<jsp:include page="layout/nav.jsp"></jsp:include>
</nav>

<section class = "section">
	<h2>회원조회</h2>
		<form name = "data1" action="member_search_list.jsp" method = "post" onsubmit = "return checkValue2()">
			<table class = "table_style">
				<tr>
					<th> 회원 번호 </th>
					<td> <input type = "text" name = "custno1"></td>
				</tr>
				<tr>
					<th colspan="2">
					<input type = "button" onclick = "location.href = 'member_list.jsp'" value = 취소>
					<input type = "submit" value="조회"></th>
				
				</tr>
			</table>
		
		
		
		</form>
</section>

<footer>
	<jsp:include page="layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>