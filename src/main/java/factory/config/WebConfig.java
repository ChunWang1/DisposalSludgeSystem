package factory.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Import;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import factory.controller.UserController;
import factory.serviceimpl.UserServiceImpl;
import redis.clients.jedis.JedisPoolConfig;


@SuppressWarnings("deprecation")
@Configurable
@EnableCaching
/*��������֧�� ��ͬ��xml���÷�ʽ�� <tx:annotation-driven />*/
@EnableTransactionManagement
/*����spring mvc����*/
@EnableWebMvc
//ɨ����controller��serviceimpl������
@ComponentScan(basePackageClasses= {UserController.class,UserServiceImpl.class})
public class WebConfig extends WebMvcConfigurerAdapter{
	@Bean
	public ViewResolver viewResolver() { //����JSP��ͼ����
		InternalResourceViewResolver resolver=new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/jsp/");
		resolver.setSuffix(".jsp");
		resolver.setExposeContextBeansAsAttributes(true);
		return resolver;
	}
	@Override     //���þ�̬��Դ�Ĵ���
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

}
