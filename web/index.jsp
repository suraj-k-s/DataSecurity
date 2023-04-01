<%@page import="javax.crypto.spec.IvParameterSpec"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="java.util.Base64"%>
<%@page import="java.security.SecureRandom"%>
<jsp:useBean class="Security.DataSecurity" id="obj"></jsp:useBean>

<%
//Created By Suraj K S 01/04/2023
//    Working Encryption and Decryption code  
//      The algorithm used in this code is 
//              AES (Advanced Encryption Standard) with 
//                      CBC (Cipher Block Chaining) mode of operation 
//                              and PKCS5Padding for padding.

    String message = "Hello, World!";

    out.println("Message : " + message + "<br><br> Static Way <br>---------------------------------<br>");

    String keyString = "DoRKxtLcO7yqRpKgg4pNWg==";

    String ivString = "D7Y1qPwiU7TdEXHHbqnsJw==";

    String encryptedData = obj.encodeData(message, keyString, ivString);

    String decryptedData = obj.decodeData(encryptedData, keyString, ivString);

    out.println("<br> keyString : " + keyString);

    out.println("<br> ivString : " + ivString);

    out.println("<br> Encripted : " + encryptedData);

    out.println("<br> Decrypted : " + decryptedData);

    out.println("<br>=================<br>");

//    Also We can use dynamicaly by below Code
    out.println("<br> Dynamic Way <br>---------------------------------<br>");

    // Generate a random 128-bit AES key
    SecureRandom random = new SecureRandom();
    byte[] keyBytes = new byte[16];
    random.nextBytes(keyBytes);
    String key = Base64.getEncoder().encodeToString(keyBytes);

    // Generate a random 128-bit IV
    byte[] ivBytes = new byte[16];
    random.nextBytes(ivBytes);
    String iv = Base64.getEncoder().encodeToString(ivBytes);

    // Encrypt the message using AES encryption with the key and IV
    SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
    cipher.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(ivBytes));
    byte[] encryptedBytes = cipher.doFinal(message.getBytes("UTF-8"));

    // Print the encrypted message, key, and IV
    out.println("<br>Encrypted message: " + Base64.getEncoder().encodeToString(encryptedBytes));
    out.println("<br>Encryption key: " + key);
    out.println("<br>Initialization vector: " + iv);

    // Decrypt the message using AES decryption with the key and IV
    byte[] decodedKey = Base64.getDecoder().decode(key);
    byte[] decodedIV = Base64.getDecoder().decode(iv);
    SecretKeySpec decryptedKeySpec = new SecretKeySpec(decodedKey, "AES");
    Cipher decryptCipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
    decryptCipher.init(Cipher.DECRYPT_MODE, decryptedKeySpec, new IvParameterSpec(decodedIV));
    byte[] decryptedBytes = decryptCipher.doFinal(encryptedBytes);
    String decryptedMessage = new String(decryptedBytes, "UTF-8");
    // Print the decrypted message
    out.println("<br>Decrypted message: " + decryptedMessage);


%>