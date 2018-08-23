package com.touresbalon.mocks.bolivarianomock;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Scheduler {

	private static final Logger logger = LoggerFactory.getLogger(Scheduler.class);
	private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");

	@Value("${app.ftp.hostname}")
	private String hostname;

	@Value("${app.ftp.port}")
	private Integer serverPort;

	@Value("${app.ftp.username}")
	private String userName;

	@Value("${app.ftp.password}")
	private String password;

	private FTPClient ftpClient;

	@PostConstruct
	public void init() {
		ftpClient = new FTPClient();
		ftpClient.addProtocolCommandListener(new PrintCommandListener(new PrintWriter(System.out)));
	}

	@PreDestroy
	public void destroy() {
		try {
			if (ftpClient.isConnected()) {
				ftpClient.logout();
				ftpClient.disconnect();
			}
		} catch (IOException ex) {
			logger.error("destroy", ex);
		}
	}

	@Scheduled(fixedRateString = "${app.fixedRate}")
	public void scheduleTaskWithFixedRate() {
		logger.info("Fixed Rate Task :: Execution Time - {}", dateTimeFormatter.format(LocalDateTime.now()));
		InputStream inputStream = null;
		BufferedReader reader = null;
		try {

			if (!ftpClient.isConnected()) {
				connect();
			}

			inputStream = ftpClient.retrieveFileStream("archivo1.csv");
			if (FTPReply.CANNOT_OPEN_DATA_CONNECTION != ftpClient.getReplyCode()
					&& FTPReply.FILE_UNAVAILABLE != ftpClient.getReplyCode()) {
				if (inputStream != null) {
					reader = new BufferedReader(new InputStreamReader(inputStream));
					String line = null;
					while ((line = reader.readLine()) != null) {
						logger.info(line);
					}
					reader.close();
					ftpClient.completePendingCommand();
				}
			}
		} catch (IOException ex) {
			logger.error("error", ex);
		} finally {
			try {
				if (null != reader) {
					reader.close();
				}
				if (null != inputStream) {
					inputStream.close();
				}
			} catch (IOException ex) {
				logger.error("finally", ex);
			}
		}
	}

	public void connect() throws IOException {
		ftpClient.connect(hostname, serverPort);
		if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
			ftpClient.disconnect();
			throw new IOException("Exception in connecting to FTP Server");
		}
		
		ftpClient.login(userName, password);
		ftpClient.enterLocalPassiveMode();
		ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
		
	}
}
