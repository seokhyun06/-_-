# Oralce DB를 연동한 웹 프로그래밍

## 프로젝트 준비 - 환경셋팅

![image](https://github.com/seokhyun06/Shoppingmall/assets/122009563/b435a92d-e33b-430a-a790-af4db86a2a96)

좌측 상단 Window Preferences 클릭 => 검색창에 endcoding을 검색 => 체크 표시 돼있는 부분에 가서 'UTF-8'로 변경 => Apply and Close 버튼을 누른다.

### Tomcat 연결
![image](https://github.com/seokhyun06/Shoppingmall/assets/122009563/758b6fb7-9813-44ed-a257-ea1b3207ccf0)

Servers에서 마우스 우클릭 New Server 클릭 => Apache 폴더를 더블클릭 => 자신이 설치한 Tomcat 버전에 밪는 걸로 클릭 => finish

### Oracle 연결

### DB연결 

# 회원등록
![image](https://github.com/seokhyun06/Shoppingmall/assets/122009563/020f38ac-117a-4614-8c30-d4e26344d6b4)

```java
   <%	
   		String sql = "select max(custno) from member_tbl_02"; //DB 연결 기능을 객체변수 conn 에 저장 -> 1.DB 연결
   		Connection conn = DBConnect.getConnection(); // sql변수에 저장되어 있는 문장이 쿼리문이 됨 -> 2. DB 연결 후 쿼리문이 생성
   		
   		PreparedStatement ps = conn.prepareStatement(sql);
   		// 변수 pstmt에 저장되어 있는 SQL문을 실행하여 객체 변수 rs에 저장
   		// 쿼리문 결과값을 받아온다.
   		
   		ResultSet rs = ps.executeQuery();
   		// 기준이 되는 변수에 결과값이 저장되어 있는 경우 next()를 호출하여 마지막 값을 확인
   		// 결과값이 없을 경우엔 실행 하지 않아도 됨.
   		
   		rs.next();
   		
   		int num = rs.getInt(1) + 1;
      %>
```
회원 등록 자동 발생을 위하여 DB로 부터 가장 최근의 오라클에 들어온 회원정보를 불러온 뒤 해당 숫자에 1 을 더하여 회원번호 자동 발생한다.

## 유효성 검사
```java
<script type="text/javascript">
	function checkValue(){
		if(!document.data.custno.value){ // 'custname' 이라는 name에 value가 없을 경우
			alert("회원성명을 확인해주세요");
			data.custno.focus();
			return false
		} else if(!document.data.custname.value){
			alert("회원이름을 확인해주세요");
			data.custname.focus();
			return false
		} else if(!document.data.phone.value){
			alert("전화번호를 확인해주세요");
			data.phone.focus();
			return false
		} else if(!document.data.address.value){
			alert("주소를 확인해주세요");
			data.address.focus();
		} else if(!document.data.joindate.value){
			alert("가입일자를 확인해주세요");
			data.joindate.focus();
			return false
		} else if(!document.data.grade.value){
			alert("고객등급을 확인해주세요");
			data.grade.focus();
			return false
		} else if(!document.data.city.value){
			alert("도시코드를 확인해주세요");
			data.city.focus();
			return false
		}
			alert("회원등록이 완료되었습니다.")
			return true; // 모든 입력 사항이 입력 되었을 때 'true' 반환
	}
</script>
```
사용자가 입력한 데이터가 유효한지 확인하기 위한 유효성 체크 함수입니다.

## 회원정보 입력
```java
<%
	String sql = "insert into member_tbl_02 values (?, ?, ?, ?, ?, ?, ?)";
	
	// 오라클에 한글 입력시 깨지지 않음
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	// 웹 브라우저에서 불러오는 데이터는 문자열 형식으로 인식되므로, 
	// 숫자 데이터면 형 변환 *Integer.parseInt() 메서드를 이용해야 한다.
	pstmt.setInt(1, Integer.parseInt(request.getParameter("custno")));
	
	pstmt.setString(2, request.getParameter("custname"));
	pstmt.setString(3, request.getParameter("phone"));
	pstmt.setString(4, request.getParameter("address"));
	pstmt.setString(5, request.getParameter("joindate"));
	pstmt.setString(6, request.getParameter("grade"));
	pstmt.setString(7, request.getParameter("city"));
	
	// 데이터베이스 질의문을 실행하여 데이터 변경 작업을 수행하고 그 결과를 알려주는 역할을 한다.
	pstmt.executeUpdate(); // 쿼리문을 실행하고, 순서대로 member_tbl_02에 기록
%
```

join.jsp 파일에서 form 태그를 이용하여 데이터를 request 라는 객체에 실어 보내 데이터베이스에 유저정보를 삽입한다.


custno는 숫자 데이터이기 때문에 Integer.parseInt()이라는 메소드를 이용하여 형 변환을 해준다.

# 회원목록/수정
![image](https://github.com/seokhyun06/Shoppingmall/assets/122009563/d4563259-8440-4f56-8a95-b9e80fad0fc9)

```java
	<%
	
		String sql = "select custno, custname, phone, address, "
					+ "to_char(joindate, 'yyyy-mm-dd') as joindate, "
					+ "case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end as grade, city "
					+ "from member_tbl_02 order by custno";
		
		Connection conn = DBConnect.getConnection();
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
	
	%>
```
회원들을 조회하기 위한 쿼리문이다.


오라클에서 문자열을 날짜형 데이터로 형 변환을 하기 위해서는 TO_DATE 함수를 사용하여 joindate를 날짜형 데이터로 형 변환 시켜 준다.


# 회원정보조회
![image](https://github.com/seokhyun06/Shoppingmall/assets/122009563/f7466c53-35f5-4f70-96ee-15fb03a6b3cd)

![image](https://github.com/seokhyun06/Shoppingmall/assets/122009563/d438b957-75e6-459e-94d9-48038d980dea)

사용자가 입력한 회원정보가 존재하지 않는다면 해당 페이지로 이동한다.

다시조회 버튼을 누르면 전 페이지로 이동한다.
![image](https://github.com/seokhyun06/Shoppingmall/assets/122009563/61067e2c-380a-4ab8-917e-d405a74250f9)

```java
<% if(rs.next()) { %>
<table class = "table_style">
	<tr>
		<th>회원번호</th>
		<th>회원성명</th>
		<th>전화번호</th>
		<th>주소</th>
		<th>가입일자</th>
		<th>고객등급</th>
		<th>거주지역</th>
	</tr>
	<tr>
		<td><%= rs.getString("custno") %></td>		
		<td><%= rs.getString("custname") %></td>		
		<td><%= rs.getString("phone") %></td>		
		<td><%= rs.getString("address") %></td>		
		<td><%= rs.getString("joindate") %></td>		
		<td><%= rs.getString("grade") %></td>		
		<td><%= rs.getString("city") %></td>		

	</tr>
	<tr>
		<th colspan="7" align="center">
		<input type = "button" onclick = "location.href = 'index.jsp'" value = 홈으로></th>
	</tr>
</table>
	<% } else { %>
		<p align = "center">회원번호 <%= custno1 %>의 회원 정보가 없습니다.</p><br>
		<p align = "center"><input type = "button" onclick = "location.href = 'member_search.jsp'" value = 다시조회></p>
		<% } %>
```

데이터베이스에서 회원 정보를 검색하고, 검색 결과에 따라 웹 페이지에 다른 내용을 표시하는 기본적인 웹 애플리케이션의 일부분이다.


rs.next() 함수를 통해 다음 레코드(행)가 존재하는지 확인하는 조건문이다. 즉 데이터가 존재하면 사용자가 입력한 데이터를 가져온다.

존재하지 않으면 조회 할 수 없는 메세지를 띄우는 창을 띄운다.

# 회원매출조회

# 홈으로


