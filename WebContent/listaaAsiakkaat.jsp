<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<scrips src="scripts/main.js"></scrips>
<title>Asiakkaiden listaus</title>
</head>
<body>
<form action="haeasiakkaat"  method="get">

	<table id="listaus">
		<thead>
			<tr>
			
				<th colspan="5" class="oikealle"><a href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
			</tr>				
			<tr>
				<th class="oikealle">Hakusana:</th>
				
				<th colspan="3"><input type="text" name="hakusana" id="hakusana" value="${param['hakusana']}"></th>
				
			
				<th><input type="submit" value="Hae" id="hakunappi"></th>
			</tr>
		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
				<c:forEach items="${asiakkaat}" var="listItem">
					<tr>
				        <td>${listItem.etunimi}</td>
				        <td>${listItem.sukunimi}</td>
			    	    <td>${listItem.puhelin}</td>
			        	<td>${listItem.sposti}</td>

				        <td>
				        	<a href="muutaasiakas?asiakas_id=${listItem.asiakas_id}" class="muuta">muuta</a>
				        	<a onclick="varmista(${listItem.asiakas_id})" class="poista">poista</a>			        	
				        </td>
		        	</tr>
			    </c:forEach>		
		</tbody>
</table>
</form>
<script>
haeTiedot();
document.getElementById("hakusana").focus();

function tutkiKey(event) {
	id(event.keyCode==13) {
		haeTiedot();
	}
	
}

function haeTiedot() {
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("hakusana").value, {
		method: 'GET'
		
		})
	.then(function (response) {
		return response.json ()
	})
	.then(function (responseJson) {
		console.log(responseJson);
		var asiakkaat = responseJson.asiakkaat;
		var htmlStr="";
		for(var i=0;i<asiakkaat.length;i++) {
			htmlStr+="<tr>";
			htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
			htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
			htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
			htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";
			htmlStr+="<td><a href='muutaasiakas.jsp?asiakas_id="+asiakkaat[i].asiakas_id+">Muuta</a>&nbsp;";
			htmlStr+="<span class='poista' onclick=poista("+asiakkaat[i].asiakas_id+">Poista</span></td>"
			htmlStr+="</tr>";
		}
		document.getElementById("tbody").innerHTML = htmlStr;
	})
}

function varmista(asiakas_id){
	if(confirm("Haluatko varmasti poistaa asiakkaan "+ asiakas_id + "?")){
		document.location="poistaasiakas?asiakas_id="+asiakas_id;
	}
}	
</script>

</body>
</html>