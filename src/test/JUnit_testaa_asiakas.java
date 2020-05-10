package test;

import static org.junit.jupiter.api.Assertions.*;
import java.util.ArrayList;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import asiakastieto.Asiakas;
import asiakastieto.dao.Dao;

@TestMethodOrder(OrderAnnotation.class)
class JUnit_testaa_asiakas {

	@Test
	@Order(1) 
	public void testPoistaKaikkiAsiakkaat() {
		//Poistetaan kaikki asiakkaat
		Dao dao = new Dao();
		dao.poistaKaikkiAsiakkaat("nimda");
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki();
		assertEquals(0, asiakkaat.size());
	}
	
	@Test
	@Order(2) 
	public void testLisaaAsiakas() {		
		Dao dao = new Dao();
		Asiakas asiakas_1 = new Asiakas("Matti", "Möttönen", "1234565434", "mat@mot");
		Asiakas asiakas_2 = new Asiakas("Maija", "Möttönen", "8709876543", "mai@mot");
		Asiakas asiakas_3 = new Asiakas("Pentti", "Penttinen", "7654988656", "pe@pe");
		Asiakas asiakas_4 = new Asiakas("Pirjo", "Penttinen", "3847563489", "pi@pe");
		assertEquals(true, dao.lisaaAsiakas(asiakas_1));
		assertEquals(true, dao.lisaaAsiakas(asiakas_2));
		assertEquals(true, dao.lisaaAsiakas(asiakas_3));
		assertEquals(true, dao.lisaaAsiakas(asiakas_4));
	}
	
	@Test
	@Order(3) 
	public void testMuutaAsiakas() {
		
		Dao dao = new Dao();
		Asiakas muutettava = dao.etsiAsiakas(1);
		muutettava.setEtunimi("Reima");
		muutettava.setSukunimi("Reipas");
		muutettava.setPuhelin("1111111111");
		muutettava.setSposti("re@re");
		dao.muutaAsiakas(muutettava, 1);	
		assertEquals("Reima", dao.etsiAsiakas(1).getEtunimi());
		assertEquals("Reipas", dao.etsiAsiakas(1).getSukunimi());
		assertEquals("1111111111", dao.etsiAsiakas(1).getPuhelin());
		assertEquals("re@re", dao.etsiAsiakas(1).getSposti());
	}
	
	@Test
	@Order(4) 
	public void testPoistaAsiakas() {
		Dao dao = new Dao();
		dao.poistaAsiakas(1);
		assertEquals(null, dao.etsiAsiakas(1));
	}

}