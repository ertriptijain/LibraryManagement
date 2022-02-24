<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Library Management</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<style type="text/css">
body{
	background: url(img/bg.jpg);
	    height: 100vh;
    background-size: cover;
    background-repeat: no-repeat;
    display: flex;
    align-items: center;
    justify-content: center;
}
</style>
<script>
	function validateForm() {
		let x = document.forms["form1"]["username"].value;
		let y = document.forms["form1"]["password"].value;
		if (x == "" || y == "") {
			alert("UserName and Password must be filled out");
			return false;
		}
	}
</script>

</head>


<body>

	<%
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String uname = request.getParameter("username");
		String pwd = request.getParameter("password");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryManagement", "root", "root");
			PreparedStatement stmt = con.prepareStatement("select * from user where user_name=? and password=? and status=1");

			stmt.setString(1, uname);
			stmt.setString(2, pwd);
			ResultSet rst = stmt.executeQuery();

			if (rst.next()) {

		//out.println("Valid user,Loged in succesfully");
		//out.println("User name is: " + rst.getString("user_name"));
		//out.println("User type: " + rst.getInt("user_type"));

		session.setAttribute("un", uname);
		session.setAttribute("ut", rst.getInt("user_type"));
		
		response.sendRedirect("userHome.jsp");
		

			} else {
		out.println("Invalid Crententials. Try again");
			}

		} catch (Exception e) {
		out.println(e.toString());
		}

	} else

	{
	%>
	<!-- <form name="form1" action="Login.jsp" method="post" onSubmit="return validateForm()">
		<div>
			<label>User Name : </label><input type="text" name="username" required />
		</div>
		<br>

		<div>
			<label>Password : </label><input type="password" name="password" required />
		</div>
		<br> <input type="submit" value="Login" /> <input type="reset" 	value="Cancel" />


	</form> -->
	
	<div class="container" style="width:600px;margin:auto; background: #eee;
    padding: 30px;">
    <div class="text-center">
    <img src="img/logo.png" style="width: 100px;" />
    </div>
	<form name="form1" action="Login.jsp" method="post" onSubmit="return validateForm()">
  	<div class="mb-3">
    <label for="exampleInputEmail1" class="form-label">User Name</label>
    <input type="text" class="form-control" name="username" required />
 	</div>
  	<div class="mb-3">
    <label for="exampleInputPassword1" class="form-label">Password</label>
   	<input type="password" class="form-control" name="password" required />
  	</div>
  	<input type="submit" value="Login" class="btn btn-primary" /> <input type="reset" class="btn btn-primary"	value="Cancel" />
	</form>
	</div>
	<%
	}
	%>





</body>
</html>