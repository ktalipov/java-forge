package dev.journey.core;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import org.junit.jupiter.api.Test;

class TypesAndVariablesPracticeTest {

    @Test
    void addWrapsAroundOnOverflow() {
        assertThat(TypesAndVariablesPractice.addWithOverflowWrap(Integer.MAX_VALUE, 1))
                .isEqualTo(Integer.MIN_VALUE);
    }

    @Test
    void safeAddThrowsOnOverflow() {
        assertThatThrownBy(() -> TypesAndVariablesPractice.safeAdd(Integer.MAX_VALUE, 1))
                .isInstanceOf(ArithmeticException.class);
    }

    @Test
    void narrowingKeepsLowEightBits() {
        assertThat(TypesAndVariablesPractice.narrowToByte(130)).isEqualTo((byte) -126);
        assertThat(TypesAndVariablesPractice.narrowToByte(200)).isEqualTo((byte) -56);
    }

    @Test
    void doublesNeedEpsilon() {
        assertThat(0.1 + 0.2).isNotEqualTo(0.3);
        assertThat(TypesAndVariablesPractice.doublesAreEqual(0.1 + 0.2, 0.3, 1e-9)).isTrue();
    }

    @Test
    void palindromeIgnoresCaseAndPunctuation() {
        assertThat(TypesAndVariablesPractice.isPalindrome("A man, a plan, a canal: Panama")).isTrue();
        assertThat(TypesAndVariablesPractice.isPalindrome("java")).isFalse();
        assertThat(TypesAndVariablesPractice.isPalindrome("")).isTrue();
    }
}
