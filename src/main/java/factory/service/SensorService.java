package factory.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import factory.entity.Sensor;
import factory.entity.SensorType;
import factory.entity.SensorValue;

public interface SensorService {

	public List<SensorType> queryAllSensorType();

	public List<Sensor> queryAllSensor();
	
	public int addSensor(Map<String, String> sensorInfo);
	
	public SensorType querySensorTypeByType(String type);
	
	public void deleteSensor(Map<String, Integer> deleteSensorInfo);
	
	public List<Sensor> conditionQuery(Map<String, String> condition);
	
	public List<Sensor> querySensorTypeByIdSet(String idSet);
	
	public void setSiteIdSetNull(String idSet);
	
	public List<Sensor> querySensorDetail(int id,int locationId);
	
	public List<Float> queryHistoryDataOfUltrasonicBySensorId(Map<String, Object> map);
	
	public List<Float> queryHistoryDataOfSingleValueBySensorId(Map<String, Object> map);
	
	public SensorValue queryRealTimeValueBySensorId(int sensorId);
	
	public List<Sensor> querySensorsByDriverId(int driverId);
	
	public List<Sensor> querySensorsByCarId(int carId);
	
	

}
