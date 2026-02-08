<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function getState()
{
	  var xhr = new XMLHttpRequest();

	    // Making our connection  
	    var country=document.getElementById("ctry").value;
	    var url = 'Ajax.jsp?country='+country;
	    xhr.open("GET", url, true);

	    // function execute after request is successful 
	    xhr.onreadystatechange = function () 
	    {
			//alert(this.readyState);
	        if (this.readyState == 4 && this.status == 200) {
	           
	        	document.getElementById("state").innerHTML=this.responseText;
	        }
	    }
	    // Sending our request 
	    xhr.send();	

}


</script>



</head>
<body>
Name<input type="Text">
Class<input type="Text">
Country<select id="ctry" onchange="getState()">
<option value="country">Select Country</option>
<option value="india">india</option>
<option value="canada">Canada</option>
<option value="Pakistan">Pakistan</option>
<option value="Australia">Australia</option>
<option value="USA">USA</option>
</select>

State<select id="state">
<option value="state">Select State</option>
</select>
District<select id="district">
<option value="state">Select State</option>
</select>
</body>
</html>