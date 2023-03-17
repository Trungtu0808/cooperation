import 'dart:math';

import 'package:base_component/import_all.dart';
import 'package:flutter/material.dart';

class Dimens {

  Dimens._();

  static const EdgeInsets bottomMinimum = EdgeInsets.symmetric(vertical: pad_XS2);

  static const double rowInfoMinHeight = 44.0;
  
  static const double text_XS2 = 12.0;
  static const double text_XS = 13.0;
  static const double text_mid_XS = 14.0;
  static const double text_S = 15.0;
  static const double text_mid_S = 16.0;
  static const double text = 17.0;
  static const double text_L_mid = 18.0;
  static const double text_L = 19.0;
  static const double text_XL = 20.0;
  static const double text_XL2 = 22.0;
  static const double text_XL3 = 25.0;
  static const double text_XL4 = 28.0;

  static const double ic_XS4 = 8.0;
  static const double ic_XS3 = 12.0;
  static const double ic_XS2 = 16.0;
  static const double ic_XS = 18.0;
  static const double ic_S = 20.0;
  static const double ic = 24.0;
  static const double ic_L = 28.0;
  static const double ic_XL = 32.0;
  static const double ic_XL2 = 38.0;
  static const double ic_XL3 = 42.0;
  static const double ic_XL4 = 52.0;

  static const double pad_default = 16.0;
  static const double pad_X4 = 4.0;

  static const double pad_XS4 = 2.0;
  static const double pad_XS3 = 4.0;
  static const double pad_XS2Mid = 6.0;
  static const double pad_XS2 = 8.0;
  static const double pad_XS1 = 10.0;
  static const double pad_XS = 12.0;
  static const double pad_S = 14.0;
  static const double pad = 16.0;
  static const double pad_L = 18.0;
  static const double pad_XL = 20.0;
  static const double pad_XL2 = 24.0;
  static const double pad_XL3 = 28.0;
  static const double pad_Extra_L = 32;
  static const double pad_XXL = 30;

  static const EdgeInsets edge_btn_wide = EdgeInsets.symmetric(horizontal: 20, vertical: 4);
  static const EdgeInsets edge_btn_wide_S = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
  static const EdgeInsets edge_btn_wide_XS = EdgeInsets.symmetric(horizontal: 12, vertical: 4);

  static const EdgeInsets edge_zero = EdgeInsets.all(0);
  static const EdgeInsets edge_default = EdgeInsets.all(pad_default);
  static const EdgeInsets edge_y_default =
      EdgeInsets.symmetric(vertical: pad_default);
  static const EdgeInsets edge_x_default =
      EdgeInsets.symmetric(horizontal: pad_default);
  static const EdgeInsets edge_bottom_default =
      EdgeInsets.only(bottom: pad_default);
  static const EdgeInsets edge_top_default = EdgeInsets.only(top: pad_default);

  static const EdgeInsets edge_r_XS = EdgeInsets.only(right: pad_XS);
  static const EdgeInsets edge_r_default = EdgeInsets.only(right: pad_default);

  static const EdgeInsets edge_x_XS4 =
      EdgeInsets.symmetric(horizontal: pad_XS4);
  static const EdgeInsets edge_x_XS3 =
      EdgeInsets.symmetric(horizontal: pad_XS3);
  static const EdgeInsets edge_x_XS2 =
      EdgeInsets.symmetric(horizontal: pad_XS2);
  static const EdgeInsets edge_x_XS = EdgeInsets.symmetric(horizontal: pad_XS);
  static const EdgeInsets edge_x_S = EdgeInsets.symmetric(horizontal: pad_S);
  static const EdgeInsets edge_x = EdgeInsets.symmetric(horizontal: pad);
  static const EdgeInsets edge_x_L = EdgeInsets.symmetric(horizontal: pad_L);
  static const EdgeInsets edge_x_XL = EdgeInsets.symmetric(horizontal: pad_XL);
  static const EdgeInsets edge_x_XL2 =
      EdgeInsets.symmetric(horizontal: pad_XL2);
  static const EdgeInsets edge_x_XL3 =
      EdgeInsets.symmetric(horizontal: pad_XL3);

  static const EdgeInsets edge_XS4 = EdgeInsets.all(pad_XS4);
  static const EdgeInsets edge_XS3 = EdgeInsets.all(pad_XS3);
  static const EdgeInsets edge_XS2 = EdgeInsets.all(pad_XS2);
  static const EdgeInsets edge_XS = EdgeInsets.all(pad_XS);
  static const EdgeInsets edge_S = EdgeInsets.all(pad_S);
  static const EdgeInsets edge = EdgeInsets.all(pad);
  static const EdgeInsets edge_L = EdgeInsets.all(pad_L);
  static const EdgeInsets edge_XL = EdgeInsets.all(pad_XL);
  static const EdgeInsets edge_XL2 = EdgeInsets.all(pad_XL2);
  static const EdgeInsets edge_XL3 = EdgeInsets.all(pad_XL3);

  static const EdgeInsets edge_y_XS4 = EdgeInsets.symmetric(vertical: pad_XS4);
  static const EdgeInsets edge_y_XS3 = EdgeInsets.symmetric(vertical: pad_XS3);
  static const EdgeInsets edge_y_XS2 = EdgeInsets.symmetric(vertical: pad_XS2);
  static const EdgeInsets edge_y_XS = EdgeInsets.symmetric(vertical: pad_XS2);
  static const EdgeInsets edge_y_S = EdgeInsets.symmetric(vertical: pad_S);
  static const EdgeInsets edge_y = EdgeInsets.symmetric(vertical: pad);
  static const EdgeInsets edge_y_L = EdgeInsets.symmetric(vertical: pad_L);
  static const EdgeInsets edge_y_XL = EdgeInsets.symmetric(vertical: pad_XL);
  static const EdgeInsets edge_y_XL2 = EdgeInsets.symmetric(vertical: pad_XL2);
  static const EdgeInsets edge_y_XL3 = EdgeInsets.symmetric(vertical: pad_XL3);

  static const EdgeInsets edge_left_XS4 = EdgeInsets.only(left: pad_XS4);
  static const EdgeInsets edge_left_XS3 = EdgeInsets.only(left: pad_XS3);
  static const EdgeInsets edge_left_XS2 = EdgeInsets.only(left: pad_XS2);
  static const EdgeInsets edge_left_XS = EdgeInsets.only(left: pad_XS2);
  static const EdgeInsets edge_left_S = EdgeInsets.only(left: pad_S);
  static const EdgeInsets edge_left = EdgeInsets.only(left: pad);
  static const EdgeInsets edge_left_L = EdgeInsets.only(left: pad_L);
  static const EdgeInsets edge_left_XL = EdgeInsets.only(left: pad_XL);
  static const EdgeInsets edge_left_XL2 = EdgeInsets.only(left: pad_XL2);
  static const EdgeInsets edge_left_XL3 = EdgeInsets.only(left: pad_XL3);

  static const EdgeInsets edge_bottom_XS4 = EdgeInsets.only(bottom: pad_XS4);
  static const EdgeInsets edge_bottom_XS3 = EdgeInsets.only(bottom: pad_XS3);
  static const EdgeInsets edge_bottom_XS2 = EdgeInsets.only(bottom: pad_XS2);
  static const EdgeInsets edge_bottom_XS = EdgeInsets.only(bottom: pad_XS2);
  static const EdgeInsets edge_bottom_S = EdgeInsets.only(bottom: pad_S);
  static const EdgeInsets edge_bottom = EdgeInsets.only(bottom: pad);
  static const EdgeInsets edge_bottom_L = EdgeInsets.only(bottom: pad_L);
  static const EdgeInsets edge_bottom_XL = EdgeInsets.only(bottom: pad_XL);
  static const EdgeInsets edge_bottom_XL2 = EdgeInsets.only(bottom: pad_XL2);
  static const EdgeInsets edge_bottom_XL3 = EdgeInsets.only(bottom: pad_XL3);

  static const EdgeInsets edge_top_XS4 = EdgeInsets.only(top: pad_XS4);
  static const EdgeInsets edge_top_XS3 = EdgeInsets.only(top: pad_XS3);
  static const EdgeInsets edge_top_XS2 = EdgeInsets.only(top: pad_XS2);
  static const EdgeInsets edge_top_XS = EdgeInsets.only(top: pad_XS2);
  static const EdgeInsets edge_top_S = EdgeInsets.only(top: pad_S);
  static const EdgeInsets edge_top = EdgeInsets.only(top: pad);
  static const EdgeInsets edge_top_L = EdgeInsets.only(top: pad_L);
  static const EdgeInsets edge_top_XL = EdgeInsets.only(top: pad_XL);
  static const EdgeInsets edge_top_XL2 = EdgeInsets.only(top: pad_XL2);
  static const EdgeInsets edge_top_XL3 = EdgeInsets.only(top: pad_XL3);

  static const EdgeInsets edge_border_padding = EdgeInsets.only(left: pad_XS2,top: 4.5, right: pad_XS2, bottom: 4.5);

  static const EdgeInsets edgeAll16 = EdgeInsets.all(16.0);

  static const EdgeInsets edgeAll12 = EdgeInsets.all(12.0);

  static const EdgeInsets edgeLR16 = EdgeInsets.only(left: 16.0, right: 16.0);

  static const EdgeInsets edgeLR10 = EdgeInsets.only(left: 10.0, right: 10.0);


  static EdgeInsets edgeSafePaddingBottom(BuildContext context, {double bottom = Dimens.pad_default}) {
    return EdgeInsets.only(bottom: safePaddingBottom(context, bottom: bottom));
  }
  
  static EdgeInsets edgeSafePaddingDefault(BuildContext context) {
    return EdgeInsets.only(
      left: Dimens.pad_default,
      top: Dimens.pad_default,
      right: Dimens.pad_default,
      bottom: safePaddingBottom(
        context,
      ),
    );
  }

  static double safePaddingBottom(BuildContext context, {double bottom = Dimens.pad_default}) {
    return max(context.mediaQuery.viewPadding.bottom, bottom);
  }

  static double paddingBehindBottomNav(BuildContext context) {
    return context.mediaQuery.viewPadding.bottom + kBottomNavigationBarHeight + 44;
  }

  static EdgeInsets paddingAll16(BuildContext context) {
    return const EdgeInsets.all(16.0);
  }

  static const double rad_XS2 = 2.0;
  static const double rad_XS = 4.0;
  static const double rad_S = 6.0;
  static const double rad = 8.0;
  static const double rad_L = 10.0;
  static const double rad_XL = 12.0;
  static const double rad_XL1 = 16.0;
  static const double rad_XL2 = 20.0;
  static const double rad_semi_XL3 = 24.0;
  static const double rad_XL3 = 26.0;
  static const double rad_max = 200.0;
  static const double rad_100 =100.0;

  static const Radius rad_circular_XS = Radius.circular(rad_XS);
  static const Radius rad_circular_S = Radius.circular(rad_S);
  static const Radius rad_circular = Radius.circular(rad);
  static const Radius rad_circular_L = Radius.circular(rad_L);
  static const Radius rad_circular_XL = Radius.circular(rad_XL);
  static const Radius rad_circular_XL2 = Radius.circular(rad_XL2);
  static const Radius rad_circular_XL3 = Radius.circular(rad_XL3);

  static final BorderRadius rad_border_circular_XS2 =
      BorderRadius.circular(rad_XS2);
  static final BorderRadius rad_border_circular_XS =
      BorderRadius.circular(rad_XS);
  static final BorderRadius rad_border_circular_S =
      BorderRadius.circular(rad_S);
  static final BorderRadius rad_border_circular = BorderRadius.circular(rad);
  static final BorderRadius rad_border_circular_L =
      BorderRadius.circular(rad_L);
  static final BorderRadius rad_border_circular_XL =
      BorderRadius.circular(rad_XL);
  static final BorderRadius rad_border_circular_XL2 =
      BorderRadius.circular(rad_XL2);
  static final BorderRadius rad_border_circular_XL3 =
      BorderRadius.circular(rad_XL3);

  static const double elevation_zero = 0;
  static const double elevation_XS = 2.0;
  static const double elevation_S = 4.0;
  static const double elevation = 6.0;
  static const double elevation_L = 8.0;

  static const double font_sp10 = 10.0;
  static const double font_sp12 = 12.0;
  static const double font_sp13 = 13.0;
  static const double font_sp14 = 14.0;
  static const double font_sp15 = 15.0;
  static const double font_sp16 = 16.0;
  static const double font_sp17 = 17.0;
  static const double font_sp18 = 18.0;
  static const double font_sp20 = 20.0;
  static const double font_sp22 = 22.0;
  static const double font_sp24 = 24.0;
  static const double font_sp28 = 28.0;

  static const double gap_dp2 = 2;
  static const double gap_dp4 = 4;
  static const double gap_dp5 = 5;
  static const double gap_dp6 = 6;
  static const double gap_dp8 = 8;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp14 = 14;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp18 = 18;
  static const double gap_dp20 = 20;
  static const double gap_dp22 = 22;
  static const double gap_dp24 = 24;
  static const double gap_dp26 = 26;
  static const double gap_dp28 = 28;
  static const double gap_dp30 = 30;
  static const double gap_dp32 = 32;
  static const double gap_dp36 = 36;
  static const double gap_dp38 = 38;
  static const double gap_dp40 = 40;
  static const double gap_dp50 = 50;
  static const double gap_dp60 = 60;

  static const double layout_S = 120;

  static const VisualDensity visual_density_min_y =
      VisualDensity(vertical: VisualDensity.minimumDensity);

  static const VisualDensity visual_density_zero_y =
      VisualDensity(vertical: VisualDensity.minimumDensity, horizontal: -4);


  static double chatPadding = 8;
  static double chatItemSpacing = 4;

}