# Test Credentials for AMOZIT Customer App

## Sign-In Credentials

Use these credentials to sign in and access the Shop module and the rest of the app flow.

### Primary Test Account
- **Email**: `user@amozit.com`
- **Password**: `Amozit123!`

### Alternative Test Accounts
- **Email**: `test@amozit.com`
- **Password**: `Test123!`

- **Email**: `shop@amozit.com`
- **Password**: `Shop123!`

### Legacy Test Account (for backward compatibility)
- **Email**: `test@example.com`
- **Password**: `password123`

## Registration Flow

To create a new account:

1. **Start**: Tap "Explore" button from Walkthrough or Location Access screen
2. **Location Permission**: Grant location permission (any option works for testing)
3. **Register**: Enter email or phone number
4. **OTP**: Enter any 4-digit OTP (e.g., `1234` or `0000`)
5. **Create Password**: 
   - Minimum 8 characters
   - Contains a number or symbol
   - At least one uppercase letter
   - Example: `Amozit123!`
6. **Complete**: Automatically navigates to Shop Landing

## Navigation Flow

### Explore Button Flow
```
Explore Button → Location Access Screen → Permission Request → Registration → OTP → Create Password → Shop Landing
```

### Sign-In Flow
```
Sign In → Shop Landing
```

## Notes

- All test credentials are hardcoded in `SignInController` for development purposes
- OTP verification accepts any 4-digit code for testing
- Password validation follows the requirements shown in Create Password screen
- After successful registration or sign-in, users are taken directly to Shop Landing screen

