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
<title>Insert title here</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>S�hk�posti</th>							
				<th></th>				
		</tr>		
	</thead>
	<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Lis��"></td>
			</tr>
	</tbody>

	</table>


</form>
<span id="ilmo"></span>

</body>
<script>

$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaAsiakkaat.jsp";
	});
	$("#tiedot").validate({						
		rules: 
			etunimi:  {
				required: true,
				minlength: 2,
				maxlength: 50
								
			},
			sukunimi:  {
				required: true,
				minlength: 2,
				maxlength: 50
								
			},
			puhelin:  {
				required: true,
				number: true,
				minlength: 10,
				maxlength: 20
			},	
			sposti:  {
				required: true,
				minlength: 3,
				maxlength: 100,
			}	
		},
		messages: {
			
			etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitk�"
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitk�"
			},
			puhelin: {
				required: "Puuttuu",
				number: "Ei kelpaa",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitk�"
			},
			sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitk�",

			}
		},			
		submitHandler: function(form) {	
			lisaaTiedot();
		}
}

	
function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) {        
		if(result.response==0){
      		$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
      	}else if(result.response==1){			
      		$("#ilmo").html("Asiakkaan lis��minen onnistui.");
      		$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
}

</script>

</html>