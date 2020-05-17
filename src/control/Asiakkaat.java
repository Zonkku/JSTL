package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;
import org.json.JSONObject;
import asiakastieto.Asiakas;
import asiakastieto.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.Asiakkaat()");
    }

    //asiakkaan hakeminen
  //GET /asiakkaat/{hakusana}
    //GET /asiakkaat/haeyksi/asiakas_id
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()");
		String pathInfo = request.getPathInfo();
		System.out.println("polku: "+pathInfo);
		Dao dao = new Dao ();
		ArrayList<Asiakas> asiakkaat;
		String strJSON = "";
		if(pathInfo==null) {
			asiakkaat = dao.listaaKaikki(); //haetaan kaikki asiakkaat
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		} else if (pathInfo.indexOf("haeyksi")!=-1) { //jos polussa on sana "haeyksi"
			int asiakas_id = Integer.parseInt(pathInfo.replace("/haeyksi/", "")); //poistetaan "/haeyksi/" ja j‰ljelle j‰‰ asiakas_id
			Asiakas asiakas = dao.etsiAsiakas(asiakas_id);
			if (asiakas==null) {
				strJSON = "{}"; //jos asiakasta ei lˆydy, luodaan tyhj‰ objekti
			}
			
			JSONObject JSON = new JSONObject();
			JSON.put("etunimi", asiakas.getEtunimi());
			JSON.put("sukunimi", asiakas.getSukunimi());
			JSON.put("puhelin", asiakas.getPuhelin());
			JSON.put("sposti", asiakas.getSposti());
			JSON.put("asiakas_id", asiakas.getAsiakas_id());	
			strJSON = JSON.toString();		
		} else {
			String hakusana = pathInfo.replace("/", "");
			asiakkaat = dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		}
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);
	}
	
	//asiakkaan lis‰‰minen
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request); //muutetaan json-string objektiksi
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.lisaaAsiakas(asiakas)){ //true/false
			out.println("{\"response\":1}"); //asiakkaan lis‰‰minen onnistui
		}else{
			out.println("{\"response\":0}"); //asiakkaan lis‰‰minen ep‰onnistui
		}
	}

	//asiakastietojen muuttaminen 	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
		JSONObject jsonObj = new JsonStrToObj().convert(request); //muutetaan json-string objektiksi
		 
		Asiakas asiakas = new Asiakas();
		asiakas.setAsiakas_id(Integer.parseInt(jsonObj.getString("asiakas_id")));
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.muutaAsiakas(asiakas)){ //true/false
			out.println("{\"response\":1}"); //asiakastietojen lis‰‰minen onnistui
		}else{
			out.println("{\"response\":0}"); //asiakastietojen lis‰‰minen ep‰onnistui
		}
	}

	//asiakkaan poistaminen
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");
		String pathInfo = request.getPathInfo();
		System.out.println("polku: "+pathInfo);
		int asiakas_id = Integer.parseInt(pathInfo.replace("/", ""));
		Dao dao = new Dao();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
					
		if(dao.poistaAsiakas(asiakas_id)){ 
			out.println("{\"response\":1}"); //Asiakkaan poistaminen onnistui
		}else{
			out.println("{\"response\":0}"); //Asiakkaan poistaminen ep‰onnistui
		}
		

	}

}
