package controller;

public class Patient {
	
	int id;
	String name;
	String email;
	String city;
	String gender;
	int age;
	
	
	
	
	@Override
	public String toString() {
		return "Patient [id=" + id + ", name=" + name + ", email=" + email + ", city=" + city + ", gender=" + gender
				+ ", age=" + age + "]";
	}

	public Patient(String name, String email, String city, String gender, int age) {
		super();
		this.name = name;
		this.email = email;
		this.city = city;
		this.gender = gender;
		this.age = age;
	}
	
	public Patient() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Patient(int id, String name, String email, String city, String gender, int age) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.city = city;
		this.gender = gender;
		this.age = age;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}

	
}
