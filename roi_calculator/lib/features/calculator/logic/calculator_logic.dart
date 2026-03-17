import 'package:roi_calculator/models/calculator_state.dart';
import 'package:roi_calculator/models/roi_result_model.dart';

class RoiCalculator {
  static double channelOrders(double totalOrders, double share) {
    return totalOrders * (share / 100);
  }

  static RoiResult calculateResult(CalculatorState state) {
    final orders = state.yearlyRevenue / state.avgOrderValue;

    final phoneOrders = channelOrders(orders, state.phoneShare);
    final mailOrders = channelOrders(orders, state.mailShare);
    final personalOrders = channelOrders(orders, state.inPersonShare);
    final ecommerceOrders = channelOrders(orders, state.ecommerceShare);

    final phoneToApp = phoneOrders * (state.phoneMigration / 100);
    final mailToApp = mailOrders * (state.mailMigration / 100);
    final personalToApp = personalOrders * (state.personalMigration / 100);
    final ecommerceToApp = ecommerceOrders * (state.ecommerceMigration / 100);
    final sum = phoneToApp + mailToApp + personalToApp + ecommerceToApp;
    final mobileOrders = sum / orders * 100;
    final phoneSavings = phoneToApp * (state.phoneCost - state.mobileCost);
    final mailSavings = mailToApp * (state.mailCost - state.mobileCost);
    final inPersonSavings =
        personalToApp * (state.inPersonCost - state.mobileCost);
    final savings = phoneSavings + mailSavings + inPersonSavings;
    final RevenueIncrease = (state.salesGrowth / 100) * 500 * sum;
    final marginIncrease = RevenueIncrease * state.grossMargin / 100;
    final appRevenue = sum * 500;
    final traditionalOrders = phoneOrders + mailOrders + personalOrders;
    final errorDecrease =
        (phoneToApp + mailToApp + personalToApp) *
        (state.errorRate - state.ecommerceRate) /
        100;
    final errorSavings = errorDecrease * state.errorCost;
    final benefit =
        savings + marginIncrease + errorSavings + 10000 + 7000 + 12000;
    final cost = (state.capex + state.opex);
    final roi = (benefit - cost) / cost * 100;
    final RoiTime = state.capex / ((benefit - state.opex) / 12);
    return RoiResult(
      benefit: benefit, //
      roi: roi, //
      RoiTime: RoiTime, //
      marginIncrease: marginIncrease, //
      errorSavings: errorSavings, //
      migrationSavings: savings, //
    );
  }
}
