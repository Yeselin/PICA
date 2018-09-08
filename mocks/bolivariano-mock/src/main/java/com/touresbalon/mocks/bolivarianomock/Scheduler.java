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
import org.apache.commons.net.ftp.FTPFile;
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
	private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

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

			connect();

			FTPFile[] requestList = ftpClient.listFiles("request/");
			String currentFile = null;
			String targetFile = null;
			for (FTPFile ftpFile : requestList) {
				currentFile = String.format("request/%s", ftpFile.getName());
				targetFile = String.format("response/%s_%s", ftpFile.getName(),
						dateTimeFormatter.format(LocalDateTime.now()));

				logger.info("Reading file {} :: Execution Time - {}", currentFile,
						dateTimeFormatter.format(LocalDateTime.now()));

				inputStream = ftpClient.retrieveFileStream(currentFile);
				ftpClient.completePendingCommand();
				if (FTPReply.CANNOT_OPEN_DATA_CONNECTION != ftpClient.getReplyCode()
						&& FTPReply.FILE_UNAVAILABLE != ftpClient.getReplyCode()) {
					if (inputStream != null) {
						listMessageRQ = this.reader.read(inputStream);
						inputStreamRS = this.writer.write(listMessageRQ);
						boolean bool = ftpClient.storeFile(targetFile, inputStreamRS);
						if (bool) {
							logger.info("File transfered :: Execution Time - {}", targetFile,
									dateTimeFormatter.format(LocalDateTime.now()));
							ftpClient.rename(currentFile, String.format("processed/%s", ftpFile.getName()));
							logger.info("Rename file to :: Execution Time - {}",
									String.format("processed/%s", ftpFile.getName()),
									dateTimeFormatter.format(LocalDateTime.now()));
						} else {
							logger.info("File not transfered :: Execution Time - {}", targetFile,
									dateTimeFormatter.format(LocalDateTime.now()));
						}
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
