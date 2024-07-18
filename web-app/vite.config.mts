import { defineConfig } from 'vite'
import { fileURLToPath, URL } from 'node:url'
import Components from 'unplugin-vue-components/vite'
import Vue from '@vitejs/plugin-vue'
import Vuetify, { transformAssetUrls } from 'vite-plugin-vuetify'
import ViteFonts from 'unplugin-fonts/vite'
import svgLoader from 'vite-svg-loader'

export default defineConfig({
  plugins: [
    Vue({
      template: { transformAssetUrls },
    }),
    Vuetify(),
    Components(),
    ViteFonts({
      google: {
        families: [{
          name: 'Roboto',
          styles: 'wght@100;300;400;500;700;900',
        }],
      },
    }),
    svgLoader()
  ],
  define: { 'process.env': {} },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
    extensions: [
      '.js',
      '.json',
      '.jsx',
      '.mjs',
      '.ts',
      '.tsx',
      '.vue',
    ],
  },
  server: {
    port: 3000,
    host: true,
    strictPort: true,
    hmr: process.env.GITPOD_WORKSPACE_URL_APP
      ? {
          clientPort: 443,
        }
      : true,
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `@import "@/styles/main.scss";`,
      },
    },
  },
})
