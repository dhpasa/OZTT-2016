package com.org.oztt.base.common;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.org.oztt.base.util.StringDecode;

public class MailUtil {
	private static String mailServer;
	private static String mailAddress;
	private static String password;

	static {
		mailServer = getApplicationMessage("mailServer");
		//mailServer = "mail.oztuantuan.com.au";
		mailAddress = getApplicationMessage("mailAddress");
		//mailAddress = "info@oztuantuan.com.au";
		password = StringDecode.paramDecode(getApplicationMessage("password"));
		//password = "liuyuan19830808";
	}

	public static void sendMail(SendMailDto sendMailDto, List<String> paramList) throws Exception {
		try {
			Properties props = new Properties();
			//props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", mailServer);
			//props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			Session session = Session.getInstance(props);

			Transport transport = session.getTransport("smtp");
			transport.connect(mailServer, mailAddress, password);

			// 发送人
			MimeMessage message = new MimeMessage(session);
			InternetAddress mailFrom = new InternetAddress(mailAddress,
					mailAddress);
			message.setFrom(mailFrom);

			InternetAddress replyTo[] = { new InternetAddress(mailAddress) };

			message.setReplyTo(replyTo);

			// 接收地址
			InternetAddress[] mailAdresses = new InternetAddress[sendMailDto
					.getTo().size()];
			Iterator<?> it = sendMailDto.getTo().iterator();
			int times = 0;
			while (it.hasNext()) {
				String mailAdressTo = (String) it.next();
				InternetAddress mailTo = new InternetAddress(mailAdressTo);
				mailAdresses[times] = mailTo;
				times++;
			}
			message.addRecipients(Message.RecipientType.TO, mailAdresses);

			// 编码
			String title = sendMailDto.getTitle();
			message.setSubject(title, "utf-8");
			message.setSentDate(new Date());

			BodyPart mbp = new MimeBodyPart();
			String content = sendMailDto.getContent();
			if (paramList != null && paramList.size() > 0) {
				for (int i = 0; i < paramList.size(); i++) {
					content = content.replace("{" + i + "}", paramList.get(i));
				}
			}
			mbp.setContent(content, "text/html;charset=utf-8");
			Multipart mPart = new MimeMultipart();
			// mPart.addBodyPart(mbp);

			mPart.addBodyPart(mbp);
			if (!sendMailDto.getFile().isEmpty()) {
				Enumeration<String> efile = sendMailDto.getFile().elements();
				while (efile.hasMoreElements()) {
					mbp = new MimeBodyPart();
					String filename = efile.nextElement().toString();
					FileDataSource fds = new FileDataSource(filename);
					mbp.setDataHandler(new DataHandler(fds));
					mbp.setFileName(fds.getName());
					mPart.addBodyPart(mbp);
				}
				sendMailDto.getFile().removeAllElements();
			}
			message.setContent(mPart);

			// 送信
			message.saveChanges();

			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
		} catch (Exception e) {
			throw e;
		}
	}
	
	public static String getApplicationMessage(String key) {
		try {
			
			String langCou = Locale.getDefault().getLanguage() + "_" + Locale.getDefault().getCountry();
			FileInputStream messageStream;
			String s = MailUtil.class.getClassLoader().getResource("/").getPath();
			Properties properties = new Properties();
			if("zh_CN".equals(langCou)) {
				messageStream = new FileInputStream(s+"/application_zh_CN.properties");
			}
			else if("en_US".equals(langCou)) {
				messageStream = new FileInputStream(s+"/application_en_US.properties");
			}
			else {
				messageStream = new FileInputStream(s+"/application_zh_CN.properties");
			}
			properties.load(messageStream);
			if (properties.containsKey(key)) {
				String value = new String(properties.getProperty(key));
				return value;
			}
			else {
				return key;
			}
		}
		catch (FileNotFoundException ex) {
			return key;
		}
		catch (IOException ex) {
			return key;
		}
		catch (Exception e) {
			return "session超时处理";
		}
	}
	
	@SuppressWarnings("static-access")
	public static void main(String[] args) throws Exception {
		MailUtil mailUtil = new MailUtil();
		SendMailDto sendMailDto = new SendMailDto();
		sendMailDto.setContent("test");
		sendMailDto.setTitle("06281111222233333");
		List<String> mailTo = new ArrayList<String>();
		mailTo.add("liuyuan1983@gmail.com");

		sendMailDto.setTo(mailTo);
		mailUtil.sendMail(sendMailDto, null);
	}
	
}
