	
<html>
<body>

	<h1>Spring Boot - File Upload</h1>

	<form method="POST" action="/upload" enctype="multipart/form-data">
		<input type="file" name="file" /><br />
		<br /> <input type="submit" value="Submit" />

            <input type="hidden"  name="${_csrf.parameterName}"	value="${_csrf.token}"/>

	</form>

</body>
</html>