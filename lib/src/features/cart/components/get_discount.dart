import 'package:finesse/components/card/discount_card.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/cart/controller/discount_controller.dart';
import 'package:finesse/src/features/cart/model/promocode_model.dart';
import 'package:finesse/src/features/cart/model/refferralcode_model.dart';
import 'package:finesse/src/features/cart/model/vouchercode_model.dart';
import 'package:finesse/src/features/cart/state/code_state.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetDiscount extends StatefulWidget {
  const GetDiscount({Key? key}) : super(key: key);

  @override
  State<GetDiscount> createState() => _GetDiscountState();
}

class _GetDiscountState extends State<GetDiscount> {
  TextEditingController promoCodeController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController giftCodeController = TextEditingController();
  bool promoCodeClear = false;
  bool referralCodeClear = false;
  bool giftCodeClear = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final codeState = ref.watch(discountProvider);
        final PromoCodeModel? promoCodeData = codeState is PromoCodeSuccessState
            ? codeState.promoCodeModel
            : null;
        final ReferralCodeModel? referralCodeData =
            codeState is ReferralCodeSuccessState
                ? codeState.referralCodeModel
                : null;
        final VoucherCodeModel? voucherCodeData =
            codeState is VoucherCodeSuccessState
                ? codeState.voucherCodeModel
                : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            referralCodeData?.success == true &&
                    referralCodeController.text.isNotEmpty
                ? Container()
                : CouponCodeCard(
                    controller: promoCodeController,
                    readOnly: promoCodeData?.success == true &&
                            promoCodeController.text.isNotEmpty
                        ? true
                        : false,
                    title: 'Promo Code',
                    hintText: 'Promo Code',
                    buttonText: promoCodeData?.success == true &&
                            promoCodeController.text.isNotEmpty
                        ? 'Clear'
                        : 'Apply Code',
                    tap: () {
                     
                        if (codeState is! LoadingState) {
                          ref
                              .read(discountProvider.notifier)
                              .sendPromoCode(code: promoCodeController.text,clear : promoCodeClear );
                          setState(() {
                            promoCodeClear = !promoCodeClear;
                          });
                        }
                      
                      if (promoCodeClear == false) {
                        promoCodeController.clear();
                      }
                    },
                  ),
            const SizedBox(height: 17),
            promoCodeData?.success == true &&
                    promoCodeController.text.isNotEmpty
                ? Container()
                : CouponCodeCard(
                    controller: referralCodeController,
                    readOnly: referralCodeData?.success == true &&
                            referralCodeController.text.isNotEmpty
                        ? true
                        : false,
                    title: 'Referral Code',
                    hintText: 'Referral Code',
                    buttonText: referralCodeData?.success == true &&
                            referralCodeController.text.isNotEmpty
                        ? 'Clear'
                        : 'Apply Code',
                    tap: () {
                      if (codeState is! LoadingState) {
                        ref.read(discountProvider.notifier).sendCReferralCode(
                            barCode: referralCodeController.text,clear : referralCodeClear );
                        setState(() {
                          referralCodeClear = !referralCodeClear;
                        });
                      }
                      if (referralCodeClear == false) {
                        referralCodeController.clear();
                      }
                    },
                  ),
            const SizedBox(height: 17),
            if (codeState is ReferralCodeSuccessState) ...[
              Text(
                codeState.referralCodeModel!.message.toString(),
                style: KTextStyle.subtitle2.copyWith(color: KColor.blackbg),
              ),
              const SizedBox(height: 15),
            ],
            CouponCodeCard(
              controller: giftCodeController,
              readOnly: voucherCodeData?.success == true &&
                      giftCodeController.text.isNotEmpty
                  ? true
                  : false,
              title: 'Gift Voucher',
              hintText: 'Gift Voucher',
              buttonText: voucherCodeData?.success == true &&
                      giftCodeController.text.isNotEmpty
                  ? 'Clear'
                  : 'Apply Code',
              tap: () {
                if (codeState is! LoadingState) {
                  ref
                      .read(discountProvider.notifier)
                      .sendGiftVoucher(code: giftCodeController.text, clear : giftCodeClear);
                  setState(() {
                    giftCodeClear = !giftCodeClear;
                  });
                }
                if (giftCodeClear == false) {
                  giftCodeController.clear();

                }
              },
            ),
          ],
        );
      },
    );
  }
}
