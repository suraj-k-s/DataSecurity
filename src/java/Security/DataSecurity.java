//Created By Suraj K S 01/04/2023
package Security;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class DataSecurity {

    public String encodeData(String messageString, String keyString, String ivString) {
        String encodedData = "";
        try {

            byte[] keyBytes = Base64.getDecoder().decode(keyString);
            byte[] ivBytes = Base64.getDecoder().decode(ivString);

            // Encrypt the message using AES encryption with the key and IV
            SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(ivBytes));
            byte[] encryptedBytes = cipher.doFinal(messageString.getBytes("UTF-8"));
            encodedData = Base64.getEncoder().encodeToString(encryptedBytes);

        } catch (UnsupportedEncodingException | InvalidAlgorithmParameterException | InvalidKeyException | NoSuchAlgorithmException | BadPaddingException | IllegalBlockSizeException | NoSuchPaddingException ex) {
            System.out.println(ex);
        }
        return encodedData;
    }

    public String decodeData(String encryptedMessage, String keyString, String ivString) {
        String decodedData = "";
        try {
            byte[] keyBytes = Base64.getDecoder().decode(keyString);
            byte[] ivBytes = Base64.getDecoder().decode(ivString);
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
            IvParameterSpec ivSpec = new IvParameterSpec(ivBytes);
            cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
            byte[] encryptedBytes = Base64.getDecoder().decode(encryptedMessage);
            byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
            decodedData = new String(decryptedBytes, "UTF-8");
        } catch (UnsupportedEncodingException | InvalidAlgorithmParameterException | InvalidKeyException | NoSuchAlgorithmException | BadPaddingException | IllegalBlockSizeException | NoSuchPaddingException e) {
            System.out.println("Error decoding data: " + e.getMessage());
        }
        return decodedData;
    }
}
