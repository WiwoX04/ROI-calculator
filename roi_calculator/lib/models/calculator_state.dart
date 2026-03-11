class CalculatorState {
  double yearlyRevenue;
  double avgOrderValue;

  double phoneShare;
  double mailShare;
  double inPersonShare;
  double ecommerceShare;

  double phoneCost;
  double mailCost;
  double inPersonCost;
  double ecommerceCost;
  double mobileCost;

  double phoneMigration;
  double mailMigration;
  double personalMigration;
  double ecommerceMigration;

  double salesGrowth;
  double grossMargin;

  double errorRate;
  double ecommerceRate;
  double errorCost;

  double capex;
  double opex;

  CalculatorState({
    this.yearlyRevenue = 100000000,
    this.avgOrderValue = 1000,
    this.phoneShare = 35,
    this.mailShare = 25,
    this.inPersonShare = 40,
    this.ecommerceShare = 10,
    this.phoneCost = 35,
    this.mailCost = 25,
    this.inPersonCost = 40,
    this.ecommerceCost = 10,
    this.mobileCost = 10,
    this.phoneMigration = 10,
    this.mailMigration = 20,
    this.personalMigration = 10,
    this.ecommerceMigration = 25,
    this.salesGrowth = 5,
    this.grossMargin = 20,
    this.errorRate = 2,
    this.ecommerceRate = 0.7,
    this.errorCost = 200,
    this.capex = 120000,
    this.opex = 30000,
  });
}
