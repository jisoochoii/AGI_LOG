package com.agilog.services2;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.stereotype.Service;
 
@Service
public class smsSend { /* 문자전송 */
 
    private final static String apiUrl = "https://sslsms.cafe24.com/sms_sender.php";
    private final static String userAgent = "Mozilla/5.0";
    private final static String charset = "UTF-8";
 
    public void sendSMS(HashMap map){
        try{
            URL obj =new URL(apiUrl);
            HttpsURLConnection con= (HttpsURLConnection) obj.openConnection();
            con.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
            con.setRequestProperty("Accept-Charset", charset);
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", userAgent);
            
            String content = map.get("resCoName")+"\n"+"담당의 "+map.get("resDoName")+"\n"
    				+map.get("resDate")+"\n"
    				+map.get("resSuName")+"님 "
    				+map.get("resActionName");
            
            String rphone = (String) map.get("resSuPhone");
            
            String postParams = "user_id="+base64Encode("chlwltn94")
                                +"&secure="+base64Encode("138dbdd3d3c63b3571f7e64c3cb2bfd3")
                                +"&msg="+base64Encode(content)+"&sphone1="+base64Encode("010")+"&sphone2="+base64Encode("2081")+"&sphone3="+base64Encode("9036")
                                +"&rphone="+base64Encode(rphone) //수신자 번호
                                +"&mode="+base64Encode("1")+"&smsType=S"+"&rdate"+base64Encode("")+"&rtime"+base64Encode(""); // SMS/LMS 여부
 
            con.setDoOutput(true);
            OutputStream os = con.getOutputStream();
            os.write(postParams.getBytes());
            os.flush();
            os.close();
            int responseCode = con.getResponseCode();
 
            if(responseCode == HttpURLConnection.HTTP_OK){ // success
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer buf  = new StringBuffer();
 
                while((inputLine=in.readLine())!=null){
                    buf.append(inputLine);
                }
                in.close();
            }else{
            }
        }catch(IOException ex){
        }
    }
 
    /**
    * BASE64 Encoder
    * @param str
    * @return
    */
    public static String base64Encode(String str)  throws java.io.IOException {
      Encoder encoder = Base64.getEncoder();
        byte[] strByte = str.getBytes("UTF-8");
        String result = encoder.encodeToString(strByte);
        return result ;
    }

    /**
      * BASE64 Decoder
      * @param str
      * @return
      */
    public static String base64Decode(String str)  throws java.io.IOException {
      Decoder decoder = Base64.getDecoder();
        byte[] strByte = decoder.decode(str);
        String result = new String(strByte);
        return result ;
    }
 
}