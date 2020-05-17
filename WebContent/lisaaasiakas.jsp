<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Lisää asiakas</title>
</head>
<body>
<form id="tiedot" action="lisaaasiakas" method="post">
	<table>
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>							
				<th></th>				
			</tr>		
	</thead>
	<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="button" id="tallenna" value="Lisää" onclick="tarkasta()"></td>
			</tr>
	</tbody>

	</table>

	<input type="hidden" name="asiakas_id" id="asiakas_id" value="${asiakas.asiakas_id}">

</form>
<span id="ilmo"></span>

</body>
<script>

function lisaaTiedot(){
	var ilmo="";
	
	if(document.getElementById("etunimi").value.length<2){
		ilmo = "Etunimi ei kelpaa!";
		return;
	}else if(document.getElementById("sukunimi").value.length<2){
		ilmo = "Sukunimi ei kelpaa!";
		return;
	}else if(document.getElementById("puhelin").value.length<1){
		ilmo = "Puhelinnumero ei kelpaa!";
		return;
	}else if(document.getElementById("sposti").value.length<3){
		ilmo = "Sähköpostiosoite ei kelpaa!";
		return;
	}
	document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
	document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);
	document.forms["tiedot"].submit();
}

function siivoa(teksti){
	teksti=teksti.replace("<","");
	teksti=teksti.replace(";","");
	teksti=teksti.replace("'","''");
	return teksti;
}

var formJsonStr=formDataToJSON(document.getElementById("tiedot"));
fetch ("asiakkaat", {
	method: 'POST',
	body:formJsonStr
})
.then(function (response) {
	return response.json()
})
.then(function (responseJson) {
	var vastaus = responseJson.response;
	if(vastaus==0) {
		document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen epäonnistui."
	} else if (vastaus==1) {
		document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen onnistui."
	}
	setTimeout(function() { document.getElementById("ilmo").innerHTML=""; }, 5000);
});
document.getElementById("tiedot").reset();
</script>
</html>

