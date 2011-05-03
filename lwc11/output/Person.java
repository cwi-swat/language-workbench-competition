public class Person {

  private java.lang.String name;
  public java.lang.String getName() {
      return this.name;
  }
  public void setName(java.lang.String name) {
      this.name = name;
  }

  private java.lang.String firstName;
  public java.lang.String getFirstName() {
      return this.firstName;
  }
  public void setFirstName(java.lang.String firstName) {
      this.firstName = firstName;
  }

  private java.util.Date birthDate;
  public java.util.Date getBirthDate() {
      return this.birthDate;
  }
  public void setBirthDate(java.util.Date birthDate) {
      this.birthDate = birthDate;
  }

  private Car2 ownedCar;
  public Car2 getOwnedCar() {
      return this.ownedCar;
  }
  public void setOwnedCar(Car2 ownedCar) {
      this.ownedCar = ownedCar;
  }

}