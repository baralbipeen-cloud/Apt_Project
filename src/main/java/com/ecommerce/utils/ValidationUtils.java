package com.ecommerce.utils;

import java.util.regex.Pattern;

public class ValidationUtils {

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String PHONE_REGEX = "^\\+?[0-9. ()-]{7,25}$";
    private static final String PRICE_REGEX = "^[0-9]+(\\.[0-9]{1,2})?$";

    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        return Pattern.compile(EMAIL_REGEX).matcher(email).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) return true; // Optional field
        return Pattern.compile(PHONE_REGEX).matcher(phone).matches();
    }

    public static boolean isStrongPassword(String password) {
        // Minimum 6 characters
        if (password == null || password.length() < 6) return false;
        return true;
    }

    public static boolean isValidPrice(String price) {
        if (price == null || price.trim().isEmpty()) return false;
        return Pattern.compile(PRICE_REGEX).matcher(price).matches();
    }

    public static boolean isValidQuantity(String quantity) {
        if (quantity == null || quantity.trim().isEmpty()) return false;
        try {
            int q = Integer.parseInt(quantity);
            return q >= 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
