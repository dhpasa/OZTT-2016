package com.org.oztt.base.util;

import java.util.Random;

import org.apache.commons.lang.StringUtils;

/**
 * URL参数进行解密
 * 
 * author linliuan
 *
 */
public class StringDecode {
	
	private static String[] HEX_PARAM = {"a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" ,
        "i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" , "q" , "r" , "s" , "t" ,
        "u" , "v" , "w" , "x" , "y" , "z" , "0" , "1" , "2" , "3" , "4" , "5" ,
        "6" , "7" , "8" , "9" , "A" , "B" , "C" , "D" , "E" , "F" , "G" , "H" ,
        "I" , "J" , "K" , "L" , "M" , "N" , "O" , "P" , "Q" , "R" , "S" , "T" ,
        "U" , "V" , "W" , "X" , "Y" , "Z"};

	public static String paramDecode(String str) {
		if (str == null || str.length() == 0) {
			return StringUtils.EMPTY;
		}
		StringBuilder sb = new StringBuilder();
		char[] cas = str.toCharArray();
		int count = (cas.length - 1)/6;
		for(int i = 0; i <= count; i++) {
			long lc = (long)cas[i * 6];
			char rlc = (char)lc;
			sb.append(String.valueOf(rlc));
		}
		
		
		return sb.toString();
		
	}
	
	public static String paramEncode(String str) {
		if (str == null || str.length() == 0) {
			return StringUtils.EMPTY;
		}
		StringBuilder sb = new StringBuilder();
		char[] cas = str.toCharArray();
		for(int i = 0; i < cas.length; i++) {
			long lc = (long)cas[i];
			char rlc = (char)lc;
			if (i == cas.length -1 ){
				//最后一个
				sb.append(String.valueOf(rlc));
			} else {
				sb.append(String.valueOf(rlc) + getRandomInsert());
			}
		}
		
		return sb.toString();
		
	}
	
	public static String getRandomInsert(){
		String a = StringUtils.EMPTY;
		Random random = new Random();
		for(int i = 0; i < 5; i++) {
			a = a + HEX_PARAM[random.nextInt(HEX_PARAM.length - 1)];
		}
		return a;
	}
	
	public static void main(String[] args) {
	    System.out.println(paramEncode("Liuyuan19830808"));
	}
}
