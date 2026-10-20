package dev.journey.core;

/**
 * Практика к теме «Types and variables».
 * Конспект: 01-core/notes/01-types-and-variables.md
 */
public final class TypesAndVariablesPractice {

    private TypesAndVariablesPractice() {
    }

    /** Обычное сложение: при переполнении результат «заворачивается». */
    public static int addWithOverflowWrap(int a, int b) {
        return a + b;
    }

    /** Сложение с проверкой: при переполнении бросает ArithmeticException. */
    public static int safeAdd(int a, int b) {
        return Math.addExact(a, b);
    }

    /** Сужающее приведение int → byte: остаются младшие 8 бит. */
    public static byte narrowToByte(int value) {
        return (byte) value;
    }

    /** Сравнение дробных чисел с допустимой погрешностью. */
    public static boolean doublesAreEqual(double a, double b, double epsilon) {
        return Math.abs(a - b) < epsilon;
    }

    /** Палиндром без учёта регистра и небуквенно-цифровых символов. */
    public static boolean isPalindrome(String text) {
        int left = 0;
        int right = text.length() - 1;
        while (left < right) {
            char l = text.charAt(left);
            char r = text.charAt(right);
            if (!Character.isLetterOrDigit(l)) {
                left++;
            } else if (!Character.isLetterOrDigit(r)) {
                right--;
            } else {
                if (Character.toLowerCase(l) != Character.toLowerCase(r)) {
                    return false;
                }
                left++;
                right--;
            }
        }
        return true;
    }
}
