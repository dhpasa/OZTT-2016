package com.org.oztt.base.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.net.ssl.HttpsURLConnection;

import org.json.JSONObject;

public class ShortUrlUtil{


    public static final String USER_AGENT = "Mozilla/5.0";
	// HTTP POST request



    public static String getShortUrl(String longUrl) throws Exception {
    	longUrl=URLEncoder.encode(longUrl, "UTF-8");

    	  String url="https://api-ssl.bitly.com/v3/shorten"
  	    		+ "?access_token=670e4d56a7031d9ae245763dfd19893056a9caae"
    			  +"&longUrl="+longUrl
    			  +"&format=txt";
  		URL obj = new URL(url);
  		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

  		// optional default is GET
		con.setRequestMethod("GET");

		//add request header
		con.setRequestProperty("User-Agent", USER_AGENT);

		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'GET' request to URL : " + url);
		System.out.println("Response Code : " + responseCode);



		BufferedReader in =null;
		if(responseCode<400)
			in= new BufferedReader(new InputStreamReader(con.getInputStream()));
		else
			in=new BufferedReader(new InputStreamReader(con.getErrorStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		System.out.println(response.toString());
		return response.toString();
  	   //con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
    }
	public static String getGoogleShortUrl(String longUrl) throws Exception {

	    String url="https://www.googleapis.com/urlshortener/v1/url"
	    		+ "?key=AIzaSyB88gEPHPNyj3XSmI-6GsGq4C2d5CTgvPY";
		URL obj = new URL(url);
		HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

		//add reuqest header
		con.setRequestMethod("POST");
		con.setRequestProperty("User-Agent", USER_AGENT);
		con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

		String parameter="{\"longUrl\": \""+longUrl+"\"}";


		//String urlParameters = "sn=C02G8416DRJM&cn=&locale=&caller=&num=12345";
		// Send post request
		con.setDoOutput(true);
		OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
		wr.write(parameter);
		wr.flush();
		wr.close();

		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'POST' request to URL : " + url);
		System.out.println("Post parameters : " + parameter);
		System.out.println("Response Code : " + responseCode);


		BufferedReader in =null;
		if(responseCode<400)
			in= new BufferedReader(new InputStreamReader(con.getInputStream()));
		else
			in=new BufferedReader(new InputStreamReader(con.getErrorStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		System.out.println(response.toString());
		//print result
		 JSONObject jo = new JSONObject(response.toString());
	       // JSONArray ja = jo.getJSONArray("map");

		String json_result=jo.getString("id");
		return json_result;

	}


}
