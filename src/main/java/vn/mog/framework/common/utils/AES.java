package vn.mog.framework.common.utils;

import java.security.Key;
import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

@SuppressWarnings("restriction")
public class AES {

  private static final String ALGORITHM = "AES";

  // //////////////////////////////////////////////////////////////////////////
  private static Key generateKey(byte[] keyValue) {
    Key key = new SecretKeySpec(keyValue, ALGORITHM);
    return key;
  }

  private static IvParameterSpec generateIv(byte[] iv) {
    return new IvParameterSpec(iv);
  }

  public static String encryptCTR(byte[] keyValue, byte[] iv, String data) throws Exception {
    Key key = generateKey(keyValue);
    IvParameterSpec ivSpec = generateIv(iv);

    Cipher cipher = Cipher.getInstance("AES/CTR/NoPadding");
    cipher.init(Cipher.ENCRYPT_MODE, key, ivSpec);
    byte[] encVal = cipher.doFinal(data.getBytes());

    String encryptedValue = new BASE64Encoder().encode(encVal);
    return encryptedValue;
  }

  public static String decryptCTR(byte[] keyValue, byte[] iv, String encryptedData) throws Exception {
    Key key = generateKey(keyValue);
    IvParameterSpec ivSpec = generateIv(iv);

    Cipher cipher = Cipher.getInstance("AES/CTR/NoPadding");
    cipher.init(Cipher.DECRYPT_MODE, key, ivSpec);

    byte[] decordedValue = new BASE64Decoder().decodeBuffer(encryptedData);
    byte[] decValue = cipher.doFinal(decordedValue);
    String decryptedValue = new String(decValue);
    return decryptedValue;
  }

  public static String encryptECB(byte[] keyValue, String data) throws Exception {
    Key key = generateKey(keyValue);

    Cipher cipher = Cipher.getInstance("AES/ECB/NoPadding");
    cipher.init(Cipher.ENCRYPT_MODE, key);

    byte[] encVal = cipher.doFinal(data.getBytes());
    String encryptedValue = new BASE64Encoder().encode(encVal);
    return encryptedValue;
  }

  public static String decryptECB(byte[] keyValue, String encryptedData) throws Exception {
    Key key = generateKey(keyValue);

    Cipher cipher = Cipher.getInstance("AES/ECB/NoPadding");
    cipher.init(Cipher.DECRYPT_MODE, key);

    byte[] decordedValue = new BASE64Decoder().decodeBuffer(encryptedData);
    byte[] decValue = cipher.doFinal(decordedValue);
    String decryptedValue = new String(decValue);
    return decryptedValue;
  }

  public static String encryptGCM(String keyValue, String nonce, String data) throws Exception {
    Key key = generateKey(keyValue.getBytes("UTF-8"));
    GCMParameterSpec spec = new GCMParameterSpec(16 * 8, nonce.getBytes("UTF-8"));
    Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
    cipher.init(Cipher.ENCRYPT_MODE, key, spec);

    byte[] encVal = cipher.doFinal(data.getBytes());
    String encryptedValue = new BASE64Encoder().encode(encVal);
    return encryptedValue;
  }

  public static String decryptGCM(String keyValue, String nonce, String data) throws Exception {
    Key key = generateKey(keyValue.getBytes("UTF-8"));
    GCMParameterSpec spec = new GCMParameterSpec(16 * 8, nonce.getBytes("UTF-8"));
    Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
    cipher.init(Cipher.DECRYPT_MODE, key, spec);

    byte[] decordedValue = new BASE64Decoder().decodeBuffer(data);
    byte[] decValue = cipher.doFinal(decordedValue);
    String decryptedValue = new String(decValue);
    return decryptedValue;
  }

  public static String encryptCBC(String keyValue, String iv, String plainText) throws Exception {
    // Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding", "SunJCE");
    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
    Key key = generateKey(keyValue.getBytes("UTF-8"));
    cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(iv.getBytes("UTF-8")));

    byte[] encVal = cipher.doFinal(plainText.getBytes("UTF-8"));
    String encryptedValue = new BASE64Encoder().encode(encVal);
    return encryptedValue;
  }

  public static String decryptCBC(String keyValue, String iv, String data) throws Exception {
    // Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding", "SunJCE");
    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
    Key key = generateKey(keyValue.getBytes("UTF-8"));
    cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(iv.getBytes("UTF-8")));

    byte[] decordedValue = new BASE64Decoder().decodeBuffer(data);
    byte[] decValue = cipher.doFinal(decordedValue);
    String decryptedValue = new String(decValue);
    return decryptedValue;
  }

  public static String encryptECBWithPKCS5Padding(byte[] keyValue, String data) throws Exception {
    Key key = generateKey(keyValue);

    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
    cipher.init(Cipher.ENCRYPT_MODE, key);

    byte[] encVal = cipher.doFinal(data.getBytes());
    String encryptedValue = new BASE64Encoder().encode(encVal);
    return encryptedValue;
  }

  public static String decryptECBWithPKCS5Padding(byte[] keyValue, String encryptedData) throws Exception {
    Key key = generateKey(keyValue);

    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
    cipher.init(Cipher.DECRYPT_MODE, key);

    byte[] decordedValue = new BASE64Decoder().decodeBuffer(encryptedData);
    byte[] decValue = cipher.doFinal(decordedValue);
    String decryptedValue = new String(decValue);
    return decryptedValue;
  }
}
