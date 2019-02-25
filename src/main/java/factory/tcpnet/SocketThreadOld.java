package factory.tcpnet;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import factory.dao.SensorDao;
import factory.entity.DoubleValueSensorRecord;
import factory.entity.Sensor;
import factory.entity.SensorValue;
import factory.entity.SingleValueSensorRecord;
import factory.service.SensorService;

/**
 * 
 * @author ����
 * @description:�����������Ż�
 *
 */
public class SocketThreadOld implements Runnable {

	private Socket socket;

	private SensorDao sensorDao;

	private SimpleDateFormat dateFormat;
	private static Map<String, Integer> sensorMap;//��������,key=���������,value=������id

	public SocketThreadOld(Socket socket, SensorDao sensorDao) {
		this.socket = socket;
		this.sensorDao = sensorDao;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		sensorMap = new HashMap<>();
	}

	@Override
	public void run() {
		try {
			while (true) {
				BufferedReader bufr = new BufferedReader(new InputStreamReader(socket.getInputStream()));
				// System.out.println("Thread: "+Thread.currentThread()+" "+"receive...from.re"
				// + bufr.toString());
				// ��ȡ����¼����Ϣ
				// BufferedReader bufIn =
				// new BufferedReader(new InputStreamReader(System.in));

				// ����������뵽Socket�У����͸�Client
				PrintWriter pout = new PrintWriter(socket.getOutputStream(), true);
				// ��ȡsocket��Ϣ
				String line = bufr.readLine();
				//ʱ���
				String time = dateFormat.format(new Date());
				//��������Ϣ����,�ָ�
				String info[] = line.split(",");
				// �����GPS��������������Ϣ
				if (info[0].startsWith("G")) {  
					if (sensorMap.containsKey(info[0])) {  //���map�л����˴���������Ϣ
						sensorDao.addGPSRecord((new DoubleValueSensorRecord(sensorMap.get(info[0]), time,
								Double.valueOf(info[1]), Double.valueOf(info[2]))));
					} else {  //���mapû�л��洫��������Ϣ������Ҫȥ���ݿ����Ȳ�ѯ����������Ϣ
						Sensor GPSSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (GPSSensor != null) { // ����������������
							sensorMap.put(info[0], GPSSensor.getId());
							sensorDao.addGPSRecord((new DoubleValueSensorRecord(GPSSensor.getId(), time,
									Double.valueOf(info[1]), Double.valueOf(info[2]))));
						}
					}
					//�޸Ĵ�������ʵʱ���ݱ� sensor_value_realtime
					sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),Double.valueOf(info[2])));
				}
				// ����ǰ���������
				else if (info[0].startsWith("A")) {
					if (sensorMap.containsKey(info[0])) {
						sensorDao.addAmmniaGasRecord(
								new SingleValueSensorRecord(sensorMap.get(info[0]), time, Double.valueOf(info[1])));
					} else {
						Sensor ammoniaGasSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (ammoniaGasSensor != null) { // ����������������
							sensorMap.put(info[0], ammoniaGasSensor.getId());
							sensorDao.addAmmniaGasRecord(new SingleValueSensorRecord(ammoniaGasSensor.getId(), time,
									Double.valueOf(info[1])));
						}
						sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),0));
					}
				} else if (info[0].startsWith("S")) {  //S��ͷ��ʾ���⴫����
					if (sensorMap.containsKey(info[0])) {
						sensorDao.addShydrothionRecord(
								new SingleValueSensorRecord(sensorMap.get(info[0]), time, Double.valueOf(info[1])));
					} else {
						Sensor shydrothionSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (shydrothionSensor != null) { // ����������������
							sensorMap.put(info[0], shydrothionSensor.getId());
							sensorDao.addShydrothionRecord(new SingleValueSensorRecord(shydrothionSensor.getId(), time,
									Double.valueOf(info[1])));
						}
						sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),0));
					}
				} else if (info[0].startsWith("H")) { //H��ͷ��ʾ��ʪ�ȴ�����
					if (sensorMap.containsKey(info[0])) {
						sensorDao.addHumitureRecord((new DoubleValueSensorRecord(sensorMap.get(info[0]), time,
								Double.valueOf(info[1]), Double.valueOf(info[2]))));
					} else {
						Sensor humitureSensor = sensorDao.querySensorBySerialNumber(info[0]);
						if (humitureSensor != null) { // ����������������
							sensorMap.put(info[0],humitureSensor.getId());
							sensorDao.addHumitureRecord((new DoubleValueSensorRecord(humitureSensor.getId(), time,
									Double.valueOf(info[1]), Double.valueOf(info[2]))));
						}
					}
					sensorDao.updateSensorRealTimeValue(new SensorValue(sensorMap.get(info[0]),Double.valueOf(info[1]),Double.valueOf(info[2])));
				}
				System.out.println("From client:" + line);
				pout.println("server receive success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}


}
