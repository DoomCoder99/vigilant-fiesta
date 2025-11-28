import 'package:flutter/material.dart';

/// Asset Helper Utility
/// 
/// Provides helper methods for loading assets with fallbacks.
/// When assets are not available, falls back to Material Icons or placeholders.
class AssetHelper {
  AssetHelper._();

  /// Load an image asset with fallback to Material Icon
  /// 
  /// [assetPath] - Path to the asset (e.g., 'assets/images/icon_home.png')
  /// [fallbackIcon] - Material Icon to use if asset is not found
  /// [size] - Size of the icon/image
  /// [color] - Color for the fallback icon
  static Widget loadImageOrIcon({
    required String assetPath,
    required IconData fallbackIcon,
    double? size,
    Color? color,
  }) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to Material Icon if asset not found
        return Icon(
          fallbackIcon,
          size: size,
          color: color,
        );
      },
    );
  }

  /// Load an image asset with fallback to placeholder
  /// 
  /// [assetPath] - Path to the asset
  /// [width] - Width of the image
  /// [height] - Height of the image
  /// [fit] - BoxFit for the image
  static Widget loadImageOrPlaceholder({
    required String assetPath,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to placeholder container
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            assetPath,
            // size: 40,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  /// Check if an asset exists (synchronous check)
  /// Note: This is a simple check. For production, consider using AssetBundle.
  static bool assetExists(String assetPath) {
    // In Flutter, we can't easily check asset existence synchronously
    // This is a placeholder for future implementation
    // For now, rely on errorBuilder in loadImageOrIcon
    return false;
  }
}

/// Asset Paths Constants
/// 
/// Centralized asset path definitions for easy maintenance.
class AssetPaths {
  AssetPaths._();

  // Navigation Icons (Downloaded from Figma)
  static const String iconHome = 'assets/images/icon_home.png';
  static const String iconShop = 'assets/images/icon_shop.png';
  static const String iconOrders = 'assets/images/icon_orders.png';
  static const String iconCart = 'assets/images/icon_cart.png';

  // App Bar Icons (Downloaded from Figma)
  static const String iconBackArrow = 'assets/images/icon_back_arrow.png';
  static const String iconApps = 'assets/images/icon_apps.png';
  static const String iconSearch = 'assets/images/icon_search.png';
  static const String iconFavorite = 'assets/images/icon_favorite.png';
  static const String iconShare = 'assets/images/icon_share.png';
  static const String iconContentCopy = 'assets/images/icon_content_copy.png';
  static const String iconMic = 'assets/images/icon_mic.png';

  // Product Images (Downloaded from Figma)
  static const String productImage9 = 'assets/images/product_image_9.png';
  static const String productImage10 = 'assets/images/product_image_10.png';
  static const String productImage11 = 'assets/images/product_image_11.png';
  static const String productImage12 = 'assets/images/product_image_12.png';
  static const String productImage13 = 'assets/images/product_image_13.png';
  static const String productImage14 = 'assets/images/product_image_14.png';
  static const String productImage15 = 'assets/images/product_image_15.png';
  static const String productImage16 = 'assets/images/product_image_16.png';

  // Promotional Images (Downloaded from Figma)
  static const String promoFemaleLawyer = 'assets/images/promo_female_lawyer.png';
  static const String promoRectangle26 = 'assets/images/promo_rectangle_26.png';
  static const String promoImageRemovebg = 'assets/images/promo_image_removebg.png';

  // UI Elements (Downloaded from Figma)
  static const String star1 = 'assets/images/star_1.png';

  // Category Icons
  static const String categoryPersonalCare = 'assets/images/category_personal_care.png';
  static const String categoryElectronicDevices = 'assets/images/category_electronic_devices.png';
  static const String categoryHomeAppliances = 'assets/images/category_home_appliances.png';
  static const String categoryClothing = 'assets/images/category_clothing.png';
  static const String categoryMobilesComputers = 'assets/images/category_mobiles_computers.png';
  static const String categorySportsGames = 'assets/images/category_sports_games.png';
  static const String categoryBeautyGrooming = 'assets/images/category_beauty_grooming.png';
  static const String categoryCleaningProducts = 'assets/images/category_cleaning_products.png';
  static const String categoryBathHygiene = 'assets/images/category_bath_hygiene.png';

  // Service Icons
  static const String serviceHomeMaintenance = 'assets/images/service_home_maintenance.png';
  static const String serviceCleaningPest = 'assets/images/service_cleaning_pest.png';
  static const String serviceSportsFitness = 'assets/images/service_sports_fitness.png';
  static const String serviceRentVehicle = 'assets/images/service_rent_vehicle.png';
  static const String serviceDrivingInstructor = 'assets/images/service_driving_instructor.png';
  static const String serviceWomenSalon = 'assets/images/service_women_salon.png';
  static const String serviceGasCylinder = 'assets/images/service_gas_cylinder.png';
  static const String servicePainting = 'assets/images/service_painting.png';

  // Product Images
  static const String productPlaceholder = 'assets/images/product_placeholder.png';
  static const String productBoseHeadphones = 'assets/images/product_bose_headphones.png';

  // Promotional Banners
  static const String bannerCarCare = 'assets/images/banner_car_care.png';
  static const String bannerMusicSpeaker = 'assets/images/banner_music_speaker.png';
  static const String bannerSibert = 'assets/images/banner_sibert.png';
  static const String bannerRefresh = 'assets/images/banner_refresh.png';
  static const String bannerBose = 'assets/images/banner_bose.png';

  // Payment & Cart Icons
  static const String iconChevronForward = 'assets/images/icon_chevron_forward.png';
  static const String iconRadioChecked = 'assets/images/icon_radio_checked.png';
  static const String iconRadioUnchecked = 'assets/images/icon_radio_unchecked.png';
  static const String iconHomeAddress = 'assets/images/icon_home_address.png';
  static const String iconWorkAddress = 'assets/images/icon_work_address.png';
  static const String iconAdd = 'assets/images/icon_add.png';

  // Payment Method Icons
  static const String iconMastercard = 'assets/images/icon_mastercard.png';
  static const String iconAmazonPay = 'assets/images/icon_amazon_pay.png';
  static const String iconCreditCard = 'assets/images/icon_credit_card.png';
  static const String iconWallet = 'assets/images/icon_wallet.png';
  static const String iconBank = 'assets/images/icon_bank.png';
  static const String iconCash = 'assets/images/icon_cash.png';

  // Success & Status
  static const String illustrationPaymentSuccess = 'assets/images/illustration_payment_success.png';
  static const String iconCheckSuccess = 'assets/images/icon_check_success.png';

  // Social Login
  static const String iconGoogle = 'assets/images/icon_google.png';
  static const String iconApple = 'assets/images/icon_apple.png';

  // Service Booking Module Assets (Module 3)
  // Category Icons
  static const String categoryElectrical = 'assets/service_booking/category_electrical.png';
  static const String categoryPlumbing = 'assets/service_booking/category_plumbing.png';
  static const String categoryCarpentry = 'assets/service_booking/category_carpentry.png';
  static const String categoryLightFan = 'assets/service_booking/category_light_fan.png';

  // Service Icons
  static const String serviceSwitchSockets = 'assets/service_booking/service_switch_sockets.png';
  static const String serviceDoorbellSecurity = 'assets/service_booking/service_doorbell_security.png';
  static const String serviceWiring = 'assets/service_booking/service_wiring.png';
  static const String serviceLightFan = 'assets/service_booking/service_light_fan.png';
  static const String serviceMcbFuse = 'assets/service_booking/service_mcb_fuse.png';
  static const String serviceApplianceInstallation = 'assets/service_booking/service_appliance_installation.png';
  static const String serviceOtherConsultation = 'assets/service_booking/service_other_consultation.png';

  // UI Icons (Service Booking)
  static const String iconCloseSmall = 'assets/service_booking/icon_close_small.png';
  static const String iconArrowUp = 'assets/service_booking/icon_arrow_up.png';
  static const String iconMenu = 'assets/service_booking/icon_menu.png';
  static const String iconFilter = 'assets/service_booking/icon_filter.png';
  // Note: iconChevronForward already exists in images, reuse it

    // Banner Images
    static const String bannerElectricalServices = 'assets/service_booking/banner_electrical_services.png';

    // Service Item Images (Module 3 - Service Detail)
    static const String serviceItem1 = 'assets/service_booking/service_item_1_switch.png';
    static const String serviceItem2 = 'assets/service_booking/service_item_2_switches.png';
    static const String serviceItem3 = 'assets/service_booking/service_item_more_switches.png';
    static const String serviceItem4 = 'assets/service_booking/service_item_power_switch.png';

    // Add-on Product Images (Module 3 - Add-ons)
    static const String addonLegrandSinglePole = 'assets/service_booking/addon_legrand_single_pole.png';
    static const String addonLegrandDoublePole = 'assets/service_booking/addon_legrand_double_pole.png';
    static const String addonLegrandMylinc = 'assets/service_booking/addon_legrand_mylinc.png';

    // Location & Address Screen Assets (Module 3)
    static const String mapFarwaniyah = 'assets/service_booking/maps/map_farwaniyah.png';
    static const String iconMyLocation = 'assets/service_booking/icon_my_location.png';
    static const String iconSearchLocation = 'assets/service_booking/icon_search.png';
    static const String iconLocationPin = 'assets/service_booking/icon_location_pin.png';
    static const String pinEllipseOuter = 'assets/service_booking/pin_ellipse_outer.png';
    static const String pinEllipseInner = 'assets/service_booking/pin_ellipse_inner.png';
    static const String pinSubtract = 'assets/service_booking/pin_subtract.png';
    static const String iconLocationOn = 'assets/service_booking/icon_location_on.png';
    static const String iconHomeServiceBooking = 'assets/service_booking/icon_home.png';
    static const String iconBusinessCenter = 'assets/service_booking/icon_business_center.png';
    static const String iconGroups = 'assets/service_booking/icon_groups.png';
    static const String iconAddLocationAlt = 'assets/service_booking/icon_add_location_alt.png';
    static const String iconArrowLeft = 'assets/service_booking/icon_arrow_left.png';
    static const String iconDiscoverTune = 'assets/service_booking/icon_discover_tune.png';
}

