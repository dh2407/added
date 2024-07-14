import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/useAuthModule';

import HomeView from '@/views/Home.vue'
import SignUpView from '@/views/Auth/SignUp.vue'
import SignInView from '@/views/Auth/SignIn.vue'
import SubjectListView from '@/views/Subject/SubjectsList.vue'
import SubjectDetailsView from '@/views/Subject/SubjectDetails.vue'
import SubSubjectView from '@/views/SubSubject/SubSubject.vue'
import { storeToRefs } from 'pinia';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView
  },
  {
    path: '/signup',
    name: 'SignUpView',
    component: SignUpView,
    meta: {
      requiresAuth: false,
    },
  },
  {
    path: '/signin',
    name: 'SignInView',
    component: SignInView,
    meta: {
      requiresAuth: false,
    },
  },
  {
    path:
      '/subject',
    name: "SubjectListView",
    component: SubjectListView,
    meta: {
      requiresAuth: true,
    },
  },
  {
    path:
      '/subject/:id',
    name: "SubjectDetailsView",
    component: SubjectDetailsView,
    props: true,
    meta: {
      requiresAuth: true,
    },
  },
  {
    path: '/subject/:subjectId/subSubject/:subSubjectId',
    name: 'SubSubjectView',
    component: SubSubjectView,
    props: true,
    meta: {
      requiresAuth: true,
    },
  }
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach(async (to, from, next) => {
  const authStore = useAuthStore();
  const requiresAuth = to.matched.some((record) => record.meta.requiresAuth);
  const { currentUser, isLoggedIn } = storeToRefs(useAuthStore());

  currentUser.value ? undefined : await authStore.getCurrent();

  if (to.path === '/') {
    next({ name: 'SubjectListView' })
    return;
  }

  if ((to.name === 'SignInView' || to.name === 'SignUpView') && isLoggedIn.value) {
    next({ name: 'SubjectListView' })
    return;
  }
  console.log('to', to)
  console.log('requiresAuth', requiresAuth)
  console.log('isLoggedIn', isLoggedIn.value)
  console.log('currentUser', currentUser.value)

  // if (userTokenFromStorage && !isLoggedIn) {

  // }

  if (requiresAuth && !isLoggedIn.value) {
    next({ name: 'SignInView' })
    return;
  }

  next()
})
