package factory.config;
@SuppressWarnings("unused")
public class JDBC {
	
	public static final String DRIVERCLASS="com.mysql.jdbc.Driver";
	
	public static final String URL="jdbc:mysql://kaihuoguodian.xin/disposalsludgesystem?useUnicode=true&characterEncoding=utf8";
	
	public static final String USERNAME="root";
	
	public static final String PASSWORD="123456";
	
	 /*c3p0���ӳص�˽������ */
	/*��������߳���*/
	public static final int MAXPOOLSIZE=30;
	/*��С���������߳���*/
	public static final int MINPOOLSIZE=10;
	/*�ر����Ӻ��Զ�commit*/
	public static final boolean AUTOCOMMITONCLOSE=false;
	/*��ȡ���ӳ�ʱʱ��*/
	public static final int CHECKOUTTIMEOUT=10000;
	/*����ȡ����ʧ�����Դ���*/
	public static final int ACQUIRERETRYATTEMPTS=2;
	
	
	
}
