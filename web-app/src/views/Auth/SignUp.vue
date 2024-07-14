<script setup lang="ts">
import { ref } from 'vue';
import { useAuthStore } from '@/stores/useAuthModule';
import { useRouter } from 'vue-router';

const router = useRouter();

const form = ref({
  email: '',
  password: '',
  confirmPassword: ''
});

const authStore = useAuthStore();

const errors = ref({
  email: '',
  password: '',
  confirmPassword: ''
});

const validateForm = () => {
  errors.value.email = !form.value.email.includes('@') ? "Invalid email." : '';
  errors.value.password = form.value.password.length < 8 ? "Password must be at least 8 characters." : '';
  errors.value.confirmPassword = form.value.confirmPassword !== form.value.password
    ? "Passwords do not match."
    : '';

  return !errors.value.email && !errors.value.password && !errors.value.confirmPassword;
};

const handleSubmit = async () => {
  if (!validateForm()) {
    return;
  }

  await authStore.signUp(form.value.email, form.value.password).then((res: boolean) => {
    if (res) {
      handleRedirectSignIn()
    }
  });
};

const handleRedirectSignIn = () => {
  router.push({
    name: 'SignInView'
  })
}
</script>

<template>
  <div class="sign-up-page-container">
    <v-form @submit.prevent="handleSubmit">
      <v-text-field v-model="form.email" label="Email" :error-messages="errors.email" @input="errors.email = ''"
        required></v-text-field>

      <v-text-field v-model="form.password" label="Password" type="password" :error-messages="errors.password"
        @input="errors.password = ''" required></v-text-field>

      <v-text-field v-model="form.confirmPassword" label="Confirm Password" type="password"
        :error-messages="errors.confirmPassword" @input="errors.confirmPassword = ''" required></v-text-field>
      <div class="btns-container">
        <div class="have-account-container">
          Have an account ?
          <v-btn :loading="authStore.isLoading" color="primary" @click="handleRedirectSignIn">
            Login
          </v-btn>
        </div>
        <v-btn :loading="authStore.isLoading" :disabled="Object.values(errors).some(e => e)" type="submit"
          color="primary">
          Sign Up
        </v-btn>

      </div>

    </v-form>

    <v-alert v-if="authStore.error" type="error">
      {{ authStore.error }}
    </v-alert>
  </div>
</template>

<style lang="scss" scoped>
.sign-up-page-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  justify-content: center;
  padding: 0 40px 0 40px;

  .btns-container {
    display: flex;
    align-items: center;
    justify-content: space-between;

    .have-account-container {
      display: flex;
      align-items: center;
      gap: 20px;
    }
  }
}
</style>
