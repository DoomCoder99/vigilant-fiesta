import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/routes/app_routes.dart';
import 'modules/shop/services/cart_service.dart';
import 'modules/shop/services/favorites_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/auth_guard.dart';
import 'core/services/localization_service.dart';
import 'modules/profile/controller/localization_controller.dart';
import 'modules/create_password/view/create_password_screen.dart';
import 'modules/explore/view/explore_screen.dart';
import 'modules/forgot_password/view/forgot_password_screen.dart';
import 'modules/location_access/view/location_access_screen.dart';
import 'modules/otp/view/otp_screen.dart';
import 'modules/registration/view/registration_screen.dart';
import 'modules/shop/view/amozit_landing_confirmed_screen.dart';
import 'modules/shop/view/cancellation_confirmation_dialog.dart';
import 'modules/shop/view/cart_screen.dart';
import 'modules/shop/view/category_listing_screen.dart';
import 'modules/shop/view/menu_all_categories_screen.dart';
import 'modules/shop/view/menu_all_sub_categories_screen.dart';
import 'modules/shop/view/my_orders_screen.dart';
import 'modules/shop/view/order_detail_screen.dart';
import 'modules/shop/view/payment_method_screen.dart';
import 'modules/shop/view/payment_success_screen.dart';
import 'modules/shop/view/product_detail_screen.dart';
import 'modules/shop/view/shop_landing_screen.dart';
import 'modules/shop/view/tracking_screen.dart';
import 'modules/shop/view/wishlist_screen.dart';
import 'modules/shop/view/invoice_screen.dart';
import 'modules/shop/view/service_order_detail_screen.dart';
import 'modules/shop/view/service_review_screen.dart';
import 'modules/shop/view/service_call_screen.dart';
import 'modules/shop/view/service_cancellation_confirmation_dialog.dart';
import 'modules/shop/view/product_cancellation_confirmation_screen.dart';
import 'modules/shop/view/cancel_order_screen.dart';
import 'modules/shop/models/service_order_status.dart';
import 'modules/sign_in/view/sign_in_screen.dart';
import 'modules/splash/view/splash_screen.dart';
import 'modules/walkthrough/view/walkthrough_1_screen.dart';
import 'modules/service_booking/view/electrical_services_screen.dart';
import 'modules/service_booking/view/service_detail_screen.dart';
import 'modules/service_booking/view/addons_screen.dart';
import 'modules/service_booking/view/slot_selection_screen.dart';
import 'modules/service_booking/view/add_location_screen.dart';
import 'modules/service_booking/view/add_address_screen.dart';
// Module 10: Profile & More
import 'modules/profile/view/profile_and_more_screen.dart';
import 'modules/profile/view/profile_edit_screen.dart';
import 'modules/profile/view/account_delete_confirmation_screen.dart';
import 'modules/profile/view/addresses_screen.dart';
import 'modules/profile/view/wallet_screen.dart';
import 'modules/profile/view/payment_methods_screen.dart';
import 'modules/profile/view/documents_screen.dart';
import 'modules/profile/view/notifications_screen.dart';
import 'modules/profile/view/notification_settings_screen.dart';
import 'modules/profile/view/language_selection_screen.dart';
import 'modules/profile/view/theme_selection_screen.dart';
import 'modules/profile/view/coupons_screen.dart';
import 'modules/profile/view/help_faq_screen.dart';
import 'modules/profile/view/help_policies_screen.dart';
import 'modules/profile/view/help_contact_screen.dart';
import 'modules/profile/view/policy_detail_popup.dart';
// Module 11: Search
import 'modules/search/view/search_screen.dart';
// Module 15: Support Chat
import 'modules/support_chat/view/support_initial_screen.dart';
import 'modules/support_chat/view/support_chat_screen.dart';
// Module 16: Subscription
import 'modules/subscription/view/sports_fitness_category_screen.dart';
import 'modules/subscription/view/turf_detail_screen.dart';
import 'modules/subscription/view/subscription_cart_screen.dart';
import 'modules/subscription/view/subscription_payment_method_screen.dart';
import 'modules/subscription/view/subscription_payment_success_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize services
  await CartService.instance.init();
  await FavoritesService.instance.init();
  
  // Initialize localization
  await LocalizationService.init();
  
  // Initialize localization controller
  final localizationController = Get.put(LocalizationController());
  
  // Load saved language preference
  await localizationController.loadSavedLanguage();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationController = Get.find<LocalizationController>();
    
    return Obx(() {
      final currentLocale = localizationController.currentLocale.value;
      
      return GetMaterialApp(
        title: 'AMOZIT Customer',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        
        // Localization setup
        translations: LocalizationService(),
        locale: currentLocale,
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'SA'),
        ],
        
        // RTL Support - GetMaterialApp automatically handles text direction
        // based on locale, but we ensure it's explicitly set
        builder: (context, child) {
          return Directionality(
            textDirection: currentLocale.languageCode == 'ar' 
                ? TextDirection.rtl 
                : TextDirection.ltr,
            child: child ?? const SizedBox.shrink(),
          );
        },
        
        initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.walkthrough1: (context) => const Walkthrough1Screen(),
        AppRoutes.locationAccess: (context) => const LocationAccessScreen(),
        AppRoutes.register: (context) => const RegistrationScreen(),
        AppRoutes.registerOtp: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String?;
          return OtpScreen(emailOrPhone: args ?? '');
        },
        AppRoutes.createPassword: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String?;
          return CreatePasswordScreen(emailOrPhone: args ?? '');
        },
        AppRoutes.signIn: (context) => const SignInScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
        AppRoutes.forgotPasswordOtp: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String?;
          return OtpScreen(emailOrPhone: args ?? '');
        },
        AppRoutes.explore: (context) => const ExploreScreen(),
        AppRoutes.amozitLandingConfirmed: (context) => const AuthGuard(
              child: AmozitLandingConfirmedScreen(),
            ),
        // Shop Module Routes (Protected with AuthGuard)
        AppRoutes.shopLanding: (context) => const AuthGuard(
              child: ShopLandingScreen(),
            ),
        AppRoutes.categoryListing: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: CategoryListingScreen(categoryName: args?['categoryName']),
          );
        },
        AppRoutes.productDetail: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: ProductDetailScreen(productId: args?['productId']),
          );
        },
        AppRoutes.cart: (context) => const AuthGuard(
              child: CartScreen(),
            ),
        AppRoutes.paymentMethod: (context) => const AuthGuard(
              child: PaymentMethodScreen(),
            ),
        AppRoutes.paymentSuccess: (context) => const AuthGuard(
              child: PaymentSuccessScreen(),
            ),
        AppRoutes.myOrders: (context) => const AuthGuard(
              child: MyOrdersScreen(),
            ),
        AppRoutes.orderDetail: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: OrderDetailScreen(orderId: args?['orderId']),
          );
        },
        AppRoutes.tracking: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: TrackingScreen(orderId: args?['orderId']),
          );
        },
        AppRoutes.invoice: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: InvoiceScreen(orderId: args?['orderId']),
          );
        },
        AppRoutes.cancellationConfirmation: (context) => const AuthGuard(
              child: CancellationConfirmationDialog(),
            ),
        AppRoutes.menuAllCategories: (context) => const AuthGuard(
              child: MenuAllCategoriesScreen(),
            ),
        AppRoutes.menuAllSubCategories: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: MenuAllSubCategoriesScreen(categoryName: args?['categoryName']),
          );
        },
        // Service Booking Module Routes (Module 3) - Protected with AuthGuard
        AppRoutes.homeServicesElectrical: (context) => const AuthGuard(
          child: ElectricalServicesScreen(),
        ),
        AppRoutes.serviceDetail: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: ServiceDetailScreen(
              serviceName: args?['serviceName'] ?? 'Switch & Sockets',
              serviceCategory: args?['serviceCategory'] ?? 'Electrical',
            ),
          );
        },
        AppRoutes.serviceAddons: (context) => const AuthGuard(
          child: AddonsScreen(),
        ),
        AppRoutes.slotSelection: (context) => const AuthGuard(
          child: SlotSelectionScreen(),
        ),
        AppRoutes.addLocation: (context) => const AuthGuard(
          child: AddLocationScreen(),
        ),
        AppRoutes.addAddress: (context) => const AuthGuard(
          child: AddAddressScreen(),
        ),
        // Module 6: Service Order Actions Routes
        AppRoutes.serviceOrderDetail: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: ServiceOrderDetailScreen(
              orderId: args?['orderId'],
              orderStatus: args?['orderStatus'] != null
                  ? ServiceOrderStatus.values.firstWhere(
                      (e) => e.toString() == args!['orderStatus'],
                      orElse: () => ServiceOrderStatus.upcoming,
                    )
                  : null,
            ),
          );
        },
        AppRoutes.serviceReview: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: ServiceReviewScreen(orderId: args?['orderId']),
          );
        },
        AppRoutes.serviceCall: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: ServiceCallScreen(
              orderId: args?['orderId'],
              callType: args?['callType'],
              callState: args?['callState'],
              agentName: args?['agentName'],
            ),
          );
        },
        AppRoutes.serviceCancellationConfirmation: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: ServiceCancellationConfirmationDialog(orderId: args?['orderId']),
          );
        },
        // Module 8: Product Order Cancellation Routes
        AppRoutes.cancelOrder: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: CancelOrderScreen(orderId: args?['orderId']),
          );
        },
        AppRoutes.productCancellationConfirmation: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: ProductCancellationConfirmationScreen(orderId: args?['orderId']),
          );
        },
        // Module 10: Profile & More Routes
        AppRoutes.profileAndMore: (context) => const AuthGuard(
          child: ProfileAndMoreScreen(),
        ),
        AppRoutes.profileEdit: (context) => const AuthGuard(
          child: ProfileEditScreen(),
        ),
        AppRoutes.accountDeleteConfirmation: (context) => const AuthGuard(
          child: AccountDeleteConfirmationScreen(),
        ),
        AppRoutes.addresses: (context) => const AuthGuard(
          child: AddressesScreen(),
        ),
        AppRoutes.wallet: (context) => const AuthGuard(
          child: WalletScreen(),
        ),
        AppRoutes.paymentMethods: (context) => const AuthGuard(
          child: PaymentMethodsScreen(),
        ),
        AppRoutes.documents: (context) => const AuthGuard(
          child: DocumentsScreen(),
        ),
        AppRoutes.notifications: (context) => const AuthGuard(
          child: NotificationsScreen(),
        ),
        AppRoutes.notificationSettings: (context) => const AuthGuard(
          child: NotificationSettingsScreen(),
        ),
        AppRoutes.languageSelection: (context) {
          return const AuthGuard(
            child: Scaffold(
              body: Center(
                child: LanguageSelectionScreen(),
              ),
            ),
          );
        },
        AppRoutes.themeSelection: (context) {
          return const AuthGuard(
            child: Scaffold(
              body: Center(
                child: ThemeSelectionScreen(),
              ),
            ),
          );
        },
        AppRoutes.coupons: (context) => const AuthGuard(
          child: CouponsScreen(),
        ),
        AppRoutes.wishlist: (context) => const AuthGuard(
          child: WishlistScreen(),
        ),
        AppRoutes.helpFaq: (context) => const AuthGuard(
          child: HelpFaqScreen(),
        ),
        AppRoutes.helpPolicies: (context) => const AuthGuard(
          child: HelpPoliciesScreen(),
        ),
        AppRoutes.helpContact: (context) => const AuthGuard(
          child: HelpContactScreen(),
        ),
        AppRoutes.policyDetail: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: PolicyDetailPopup(policyName: args?['policy'] ?? 'Policy'),
          );
        },
        AppRoutes.search: (context) => const AuthGuard(
          child: SearchScreen(),
        ),
        AppRoutes.supportInitial: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return AuthGuard(
            child: SupportInitialScreen(
              orderId: args?['orderId'] as String?,
              productName: args?['productName'] as String?,
            ),
          );
        },
        AppRoutes.supportChat: (context) => const AuthGuard(
          child: SupportChatScreen(),
        ),
        // Module 16: Subscription Routes
        AppRoutes.sportsFitnessCategory: (context) => const AuthGuard(
          child: SportsFitnessCategoryScreen(),
        ),
        AppRoutes.subscriptionVenueDetail: (context) => const AuthGuard(
          child: TurfDetailScreen(),
        ),
        AppRoutes.subscriptionCart: (context) => const AuthGuard(
          child: SubscriptionCartScreen(),
        ),
        AppRoutes.subscriptionPaymentMethod: (context) => const AuthGuard(
          child: SubscriptionPaymentMethodScreen(),
        ),
        AppRoutes.subscriptionPaymentSuccess: (context) => const AuthGuard(
          child: SubscriptionPaymentSuccessScreen(),
        ),
      },
      );
    });
  }
}
