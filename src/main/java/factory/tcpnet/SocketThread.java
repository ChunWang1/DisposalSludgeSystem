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
 * @description:�Ż��汾
 *
 */
public class SocketThread implements Runnable {

	private Socket socket;

	private SensorDao sensorDao;

	private SimpleDateFormat dateFormat;
	private static Map<String, Integer> sensorMap;// ��������,key=���������,value=������id

	public SocketThread(Socket socket, SensorDao sensorDao) {
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
				PrintWriter pout = new PrintWriter(socket.getOutputStream(), true);
				// ��ȡsocket��Ϣ
				String line = bufr.readLine();
				String datas[]=line.split(";");
				for(int i=0;i<datas.length;i++) {
					char headInfo = datas[i].charAt(0);
					// �������Ч��Ϣ
					if (headInfo == 'S' || headInfo == 'A' || headInfo == 'H' || headInfo == 'G') {
						System.out.println("From client:" + datas[i]);
						// ʱ���
						String time = dateFormat.format(new Date());
						// ��������Ϣ����','�ָ�
						String info[] = datas[i].split(",");
						// sensorMap������������������������Ϣ������ȥ���ݿ��в�ѯ
						if (!sensorMap.containsKey(info[0])) {
							Sensor sensor = sensorDao.querySensorIdBySerialNumber(info[0]); // ��ѯ
							if (sensor != null) { // �������
								sensorMap.put(info[0], sensor.getId()); // ���뻺��
							} else { // ������ݿ��ж�û�У��򲻴���
								System.out.println("���ݿ��в�����");
								continue;
							}
						}
						int sensorId = sensorMap.get(info[0]); // ȡ�ô�����id
						// ������Ϣ���󣬵����������ʹ�������value2��0���
						SensorValue sensorValue = new SensorValue(sensorId, time, Double.valueOf(info[1]), 0, headInfo);
						if (headInfo == 'G' || headInfo == 'H') { // gps����ʪ�ȶ�������������
							sensorValue.setValue2(Double.valueOf(info[2]));
							if (headInfo == 'G') { // gps������״̬�޸Ĺ���
								
							}
						}
						//���뵽��������Ӧ�����ݿ��У�ͨ��sensorValue�е�headInfoѡ���Ӧ��sql���
						sensorDao.addSensorRecord(sensorValue);
						//���뵽ʵʱ���ݱ���
						sensorDao.updateSensorRealTimeValue(sensorValue);
						pout.println("server receive success");
					}
					else {
						System.out.println("��Ч��Ϣ:"+line);
						pout.println("server receive success");
					}
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
