/// AMOZIT Customer App Routes
/// 
/// Route names mapping Figma frame names to Flutter route identifiers.
/// Following WDI Flutter Coding Standards.
class AppRoutes {
  AppRoutes._();

  // Onboarding Routes
  static const String splash = '/splash';
  static const String walkthrough1 = '/walkthrough-1';
  static const String locationAccess = '/location-access';
  
  // Authentication Routes
  static const String register = '/register';
  static const String registerOtp = '/register-otp';
  static const String createPassword = '/create-password';
  static const String signIn = '/sign-in';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordOtp = '/forgot-password-otp';
  
  // Main App Routes
  static const String explore = '/explore';
  static const String amozitLandingConfirmed = '/amozit-landing-confirmed';
  
  // Shop Module Routes
  static const String shopLanding = '/shop-landing';
  static const String categoryListing = '/category-listing';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String paymentMethod = '/payment-method';
  static const String paymentSuccess = '/payment-success';
  static const String myOrders = '/my-orders';
  static const String orderDetail = '/order-detail';
  static const String tracking = '/tracking';
  static const String cancellationConfirmation = '/cancellation-confirmation';
  static const String menuAllCategories = '/menu-all-categories';
  static const String menuAllSubCategories = '/menu-all-sub-categories';
  
  // Service Booking Module Routes (Module 3)
  static const String homeMaintenanceCategories = '/home-maintenance-categories';
  static const String homeServicesElectrical = '/home-services-electrical';
  static const String quickMenuElectrical = '/quick-menu-electrical';
  static const String serviceDetail = '/service-detail';
  static const String serviceAddons = '/service-addons';
  static const String slotSelection = '/slot-selection';
  static const String addLocation = '/add-location';
  static const String addAddress = '/add-address';
  
  // Rent Vehicle Module Routes (Module 4)
  static const String rentVehicleHome = '/rent-vehicle-home';
  static const String sedansListing = '/sedans-listing';
  static const String vehicleDetail = '/vehicle-detail';
  static const String selectDurationPickup = '/select-duration-pickup';
  static const String rentalDuration = '/rental-duration';
  static const String rentCart = '/rent-cart';
  static const String rentPaymentMethod = '/rent-payment-method';
  static const String rentPaymentSuccess = '/rent-payment-success';
  
  // Module 6: Service Order Actions Routes
  static const String serviceOrderDetail = '/service-order-detail';
  static const String serviceReview = '/service-review';
  static const String serviceCall = '/service-call';
  static const String serviceCancellationConfirmation = '/service-cancellation-confirmation';
  
  // Module 8: Product Order Cancellation Routes
  static const String cancelOrder = '/cancel-order';
  static const String productCancellationConfirmation = '/product-cancellation-confirmation';
  
  // Module 9: Track Order & Invoice Routes
  static const String invoice = '/invoice';
  
  // Module 10: Profile & More Routes
  static const String profileAndMore = '/profile-and-more';
  static const String profileEdit = '/profile-edit';
  static const String accountDeleteConfirmation = '/account-delete-confirmation';
  static const String addresses = '/addresses';
  static const String wallet = '/wallet';
  static const String paymentMethods = '/payment-methods';
  static const String documents = '/documents';
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notification-settings';
  static const String languageSelection = '/language-selection';
  static const String themeSelection = '/theme-selection';
  static const String coupons = '/coupons';
  static const String helpFaq = '/help-faq';
  static const String helpPolicies = '/help-policies';
  static const String helpContact = '/help-contact';
  static const String policyDetail = '/policy-detail';
  
  // Module 11: Search Routes
  static const String search = '/search';
  
  // Module 14: Wishlist Routes
  static const String wishlist = '/wishlist';
  
  // Module 15: Support Chat Routes
  static const String supportInitial = '/support-initial';
  static const String supportChat = '/support-chat';
  
  // Module 16: Subscription Routes
  static const String sportsFitnessCategory = '/sports-fitness-category';
  static const String subscriptionVenueDetail = '/subscription-venue-detail';
  static const String subscriptionCart = '/subscription-cart';
  static const String subscriptionPaymentMethod = '/subscription-payment-method';
  static const String subscriptionPaymentSuccess = '/subscription-payment-success';
}

