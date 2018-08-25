package com.touresbalon.mocks.bolivarianomock;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

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

import com.touresbalon.mocks.bolivarianomock.actor.Reader;
import com.touresbalon.mocks.bolivarianomock.actor.Writer;
import com.touresbalon.mocks.bolivarianomock.message.MessageRQ;

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

	private Reader reader;
	private Writer writer;

	@PostConstruct
	public void init() {
		reader = new Reader();
		writer = new Writer();
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
		InputStream inputStreamRS = null;
		List<MessageRQ> listMessageRQ = null;
		try {

			if (!ftpClient.isConnected()) {
				connect();
			}

			inputStream = ftpClient.retrieveFileStream("request.csv");
			ftpClient.completePendingCommand();
			if (FTPReply.CANNOT_OPEN_DATA_CONNECTION != ftpClient.getReplyCode()
					&& FTPReply.FILE_UNAVAILABLE != ftpClient.getReplyCode()) {
				if (inputStream != null) {
					listMessageRQ = this.reader.read(inputStream);
					inputStreamRS = this.writer.write(listMessageRQ);					
					boolean bool = ftpClient.storeFile("nombre.csv", inputStreamRS);
					if(bool) {
						logger.info("Archivo transferido con éxito");
					}else {
						logger.error("No se logró transferir el archivo");
					}
				}
			}
			ftpClient.completePendingCommand();
		} catch (Exception ex) {
			logger.error("error", ex);
		} finally {
			try {				
				if (null != inputStream) {
					inputStream.close();
				}
				if (null != inputStreamRS) {
					inputStreamRS.close();
				}
			} catch (IOException ex) {
				logger.error("finally", ex);
			}
		}
		logger.info("FINISHED :: Execution Time - {}", dateTimeFormatter.format(LocalDateTime.now()));
	}

	private void connect() throws IOException {
		ftpClient.connect(hostname, serverPort);
		if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
			ftpClient.disconnect();
			throw new IOException("Exception in connecting to FTP Server");
		}

		ftpClient.login(userName, password);
		ftpClient.enterLocalPassiveMode();
		ftpClient.setFileType(FTP.BINARY_FILE_TYPE, FTP.BINARY_FILE_TYPE);
		ftpClient.setFileTransferMode(FTP.BINARY_FILE_TYPE);
	}

}
