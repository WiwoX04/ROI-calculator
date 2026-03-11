import 'package:roi_calculator/models/calculator_state.dart';

class RoiCalculator {
  static double Orders(CalculatorState state) {
    return state.yearlyRevenue / state.avgOrderValue;
  }

  static double channelOrders(double totalOrders, double share) {
    return totalOrders * (share / 100);
  }

  static double migrationSavings(CalculatorState state) {
    final totalOrders = Orders(state);

    final phoneOrders = channelOrders(totalOrders, state.phoneShare);
    final mailOrders = channelOrders(totalOrders, state.mailShare);
    final personalOrders = channelOrders(totalOrders, state.inPersonShare);
    final ecommerceOrders = channelOrders(totalOrders, state.ecommerceShare);

    final phoneToApp = phoneOrders * (state.phoneMigration / 100);
    final mailToApp = mailOrders * (state.mailMigration / 100);
    final personalToApp = personalOrders * (state.personalMigration / 100);
    final ecommerceToApp = ecommerceOrders * (state.ecommerceMigration / 100);

    final savings =
        phoneToApp * state.phoneCost +
        mailToApp * state.mailCost +
        personalToApp * state.inPersonCost +
        ecommerceToApp * state.ecommerceCost -
        (phoneToApp + mailToApp + personalToApp + ecommerceToApp) *
            state.mobileCost;
    return savings;
  }

  static double errorSavings(CalculatorState state) {
    final totalOrders = Orders(state);

    final errors =
        totalOrders * (state.errorRate / 100) * (state.ecommerceRate / 100);

    return errors * state.errorCost;
  }

  static double salesGrowthProfit(CalculatorState state) {
    final growth = state.yearlyRevenue * (state.salesGrowth / 100);
    return growth * (state.grossMargin / 100);
  }

  static double totalBenefit(CalculatorState state) {
    return migrationSavings(state) +
        errorSavings(state) +
        salesGrowthProfit(state);
  }

  static double roi(CalculatorState state) {
    final benefit = totalBenefit(state);

    final cost = state.capex + (state.opex * 12);

    return (benefit - cost) / cost * 100;
  }
}
