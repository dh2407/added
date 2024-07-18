<template>
  <div class="main-layout">
    <main>
      <router-view />
    </main>
  </div>
</template>

<script setup>
</script>

<style scoped>
.main-layout {
  display: flex;
  flex-direction: column;
  height: 100vh;
  max-width: 100vw;
  overflow-x: hidden;
}

main {
  flex-grow: 1;
  overflow-y: auto;
  background: #fff;
  padding: 1rem;
}
</style>
