public class Product {

  private java.lang.String name;
  public java.lang.String getName() {
      return this.name;
  }
  public void setName(java.lang.String name) {
      this.name = name;
  }

  private java.util.Currency price;
  public java.util.Currency getPrice() {
      return this.price;
  }
  public void setPrice(java.util.Currency price) {
      this.price = price;
  }

  public java.util.Currency getVat() {
      return (0.19 * this.price);
  }

  public java.util.Currency getVat2() {
      return tax.utils.VAT.computeVAT(this);
  }

}