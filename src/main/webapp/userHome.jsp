<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Home</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <%
				String uName= session.getAttribute("un").toString();
				String userType = session.getAttribute("ut").toString();
				
				int ut=Integer.parseInt(userType);
				
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryManagement", "root", "root");
		
					PreparedStatement stmt = con.prepareStatement("select * from user_menu where user_Role="+ut);
					
					ResultSet rst = stmt.executeQuery();
					
					while(rst.next()){
						out.println("<a class='nav-link' href="+rst.getString("URL")+">"+rst.getString("menu_item")+"</a>");
					}
					
				}
				catch(Exception e)
				{
					out.println(e.toString());
				}
				
			%>
        </li>
      </ul>
    </div>
  </div>
</nav>

<h1 class="text-center mt-3">Welcome To Library Management</h1>
</body>
</html>