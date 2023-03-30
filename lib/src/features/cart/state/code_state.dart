import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/cart/model/promocode_model.dart';
import 'package:finesse/src/features/cart/model/refferralcode_model.dart';
import 'package:finesse/src/features/cart/model/vouchercode_model.dart';

class PromoCodeSuccessState extends SuccessState {
  final PromoCodeModel? promoCodeModel;

  const PromoCodeSuccessState(this.promoCodeModel);
}

class PromoCodeEmptyState extends SuccessState {
 }


class ReferralCodeSuccessState extends SuccessState {
  final ReferralCodeModel? referralCodeModel;

  const ReferralCodeSuccessState(this.referralCodeModel);
}

class ReferralCodeEmptyState extends SuccessState {
}

class VoucherCodeSuccessState extends SuccessState {
  final VoucherCodeModel? voucherCodeModel;

  const VoucherCodeSuccessState(this.voucherCodeModel);
}
class VoucherCodeEmptyState extends SuccessState {
}