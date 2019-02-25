package factory.config;

import java.beans.PropertyVetoException;
import java.io.IOException;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
public class DaoConfig {

	@Bean
	public ComboPooledDataSource getComboPooledDataSource() throws PropertyVetoException {
		ComboPooledDataSource pool=new ComboPooledDataSource();
		pool.setDriverClass(JDBC.DRIVERCLASS);
		pool.setJdbcUrl(JDBC.URL);
		pool.setUser(JDBC.USERNAME);
		pool.setPassword(JDBC.PASSWORD);
		pool.setMaxPoolSize(JDBC.MAXPOOLSIZE);
		pool.setMinPoolSize(JDBC.MINPOOLSIZE);
		pool.setAutoCommitOnClose(JDBC.AUTOCOMMITONCLOSE);
		pool.setCheckoutTimeout(JDBC.CHECKOUTTIMEOUT);
		pool.setAcquireRetryAttempts(JDBC.ACQUIRERETRYATTEMPTS);
		return pool;
	}
	
	@Bean
	public DataSourceTransactionManager getTransactionManager(ComboPooledDataSource jdbcDataSource) {
		DataSourceTransactionManager dataSourceTransactionManager=new DataSourceTransactionManager();
		dataSourceTransactionManager.setDataSource(jdbcDataSource);
		return dataSourceTransactionManager;
	}
	
	@Bean(name="sqlSessionFactory")
	public SqlSessionFactoryBean getSqlSessionFactoryBean(ComboPooledDataSource jdbcDataSource) throws IOException {
		SqlSessionFactoryBean factoryBean=new SqlSessionFactoryBean();
		//ע�����ݿ����ӳ�
		factoryBean.setDataSource(jdbcDataSource);
		//����MyBatiesȫ�������ļ�:mybatis-config.xml
		factoryBean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
		//ɨ��entityʹ�ñ���
		factoryBean.setTypeAliasesPackage("factory.entity");
		//ɨ��sql�����ļ�:mapper��Ҫ��Ҫ��xml�ļ�
		Resource[] resources=new PathMatchingResourcePatternResolver().getResources("classpath:mapper/*.xml");
		//factoryBean.setMapperLocations(new ClassPathResource[] {new ClassPathResource("mapper/EventDao.xml"),new ClassPathResource("mapper/ImageDao.xml")});
		factoryBean.setMapperLocations(resources);
		return factoryBean;
	}
	
	@Bean
	public MapperScannerConfigurer getMapperScannerConfigurer(SqlSessionFactoryBean factoryBean) {
		MapperScannerConfigurer mapperScannerConfigurer=new MapperScannerConfigurer();
		//ע��sqlSessionFactory
		mapperScannerConfigurer.setSqlSessionFactoryBeanName("sqlSessionFactory");
		//����Ҫɨ���Dao�ӿ�
		mapperScannerConfigurer.setBasePackage("factory.dao");
		return mapperScannerConfigurer;
	}
}

