<!-- <script setup lang="ts">
import { ref } from 'vue';
import { useAuthStore } from '@/stores/useAuthModule';
import { useRouter } from 'vue-router';

const router = useRouter();

const form = ref({
  email: '',
  password: ''
});

const authStore = useAuthStore();

const errors = ref({
  email: '',
  password: ''
});

const validateForm = () => {
  errors.value.email = !form.value.email.includes('@') ? "Invalid email." : '';
  errors.value.password = form.value.password.length < 8 ? "Password must be at least 8 characters." : '';

  return !errors.value.email && !errors.value.password;
};

const handleSubmit = async () => {
  if (!validateForm()) {
    return;
  }
  await authStore.signIn(form.value.email, form.value.password)
};

const handleRedirectSignUp = () => {
  router.push({
    name: 'SignUpView'
  })
}
</script>

<template>
  <div class="sign-in-page-container">
    <v-form @submit.prevent="handleSubmit">
      <v-text-field v-model="form.email" label="Email" :error-messages="errors.email" @input="errors.email = ''"
        required></v-text-field>

      <v-text-field v-model="form.password" label="Password" type="password" :error-messages="errors.password"
        @input="errors.password = ''" required></v-text-field>
      <div class="btns-container">
        <v-btn :loading="authStore.isLoading" color="primary" @click="handleRedirectSignUp">
          Create an account
        </v-btn>
        <v-btn :loading="authStore.isLoading" :disabled="Object.values(errors).some(e => e)" type="submit" color="primary">
          Log In
        </v-btn>
      </div>
    </v-form>

    <v-alert v-if="authStore.error" type="error">
      {{ authStore.error }}
    </v-alert>
  </div>
</template>

<style lang="scss" scoped>
.sign-in-page-container {
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
  }
}
@media (max-width: map-get($breakpoints, md)) {
  .sign-in-page-container {
    .btns-container {
      flex-direction: column;
      align-items: stretch;
      gap: 20px;
    }
  }
}
</style> -->
