package factory.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import factory.dao.UserDao;
import factory.entity.User;
import factory.service.RedisTestService;
@Service
public class RedisTestServiceImpl implements RedisTestService {
	@Autowired
	private UserDao userDao;
	@Cacheable("account")
	@Override
	public User getUserInfo(String username) {
		System.out.println("ͨ�����ݿ��ѯ");
		/*int id = (int) ((Math.random() * 9 + 1) * 100000);

		return new User(id, username, 20);*/
		return userDao.queryUserByUsername(username);
	}

	@CacheEvict("users")
	@Override
	public void deleteUser(String username) {
		System.out.println("ɾ��" + username);
	}

	@CachePut(value = "users", key = "#user.getUsername()")
	@Override
	public User updateUser(User user) {
		System.out.println("��ȡ");

		return user;
	}

}
