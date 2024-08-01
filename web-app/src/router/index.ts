import { createRouter, createWebHistory } from 'vue-router'
// import { useAuthStore } from '@/stores/useAuthModule';

import HomeView from '@/views/Home.vue'
// import SignUpView from '@/views/Auth/SignUp.vue'
// import SignInView from '@/views/Auth/SignIn.vue'
// import SubjectListView from '@/views/Subject/SubjectsList.vue'
// import SubjectDetailsView from '@/views/Subject/SubjectDetails.vue'
// import SubSubjectView from '@/views/SubSubject/SubSubject.vue'
// import StorySectionView from '@/views/Section/StorySection/StorySection.vue'
// import PageSectionView from '@/views/Section/PageSection/PageSection.vue'
import MainLayout from '@/components/Layouts/MainLayout.vue'
import SectionHandler from '@/views/Section/SectionHandler.vue'
// import { storeToRefs } from 'pinia';

const routes = [
  // {
  //     path: '/story',
  //     name: 'StorySectionView',
  //     component: StorySectionView
  // },
  // {
  //   path: '/page',
  //   name: 'PageSectionView',
  //   component: PageSectionView
  // },
  // {
  //   path: '/questions_game',
  //   name: 'QuestionsGameSectionView',
  //   component: QuestionsGameSectionView
  // },
  {
    path: '/',
    component: MainLayout,
    children: [
      {
        path: '',
        name: 'Home',
        component: HomeView
      },
      {
        path: '/subject/:subject_id/section',
        name: 'SectionHandler',
        component: SectionHandler,
        props: true,
      },
      // {
      //   path: 'signup',
      //   name: 'SignUpView',
      //   component: SignUpView,
      //   meta: {
      //     requiresAuth: false,
      //   },
      // },
      // {
      //   path: 'signin',
      //   name: 'SignInView',
      //   component: SignInView,
      //   meta: {
      //     requiresAuth: false,
      //   },
      // },
      // {
      //   path: 'subject',
      //   name: "SubjectListView",
      //   component: SubjectListView,
      //   meta: {
      //     requiresAuth: true,
      //   },
      // },
      // {
      //   path: 'subject/:id',
      //   name: "SubjectDetailsView",
      //   component: SubjectDetailsView,
      //   props: true,
      //   meta: {
      //     requiresAuth: true,
      //   },
      // },
      // {
      //   path: 'subject/:subjectId/subSubject/:subSubjectId',
      //   name: 'SubSubjectView',
      //   component: SubSubjectView,
      //   props: true,
      //   meta: {
      //     requiresAuth: true,
      //   },
      // }
    ]
  }
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach(async (to, from, next) => {
  if (to.path === '/') {
    next({ 
      name: 'SectionHandler',
      params: { subject_id: 'a7c35f87-6b99-4cf4-9f7b-4fef2d7d85e1' }
    })
    return;
  }
  next();

  // const authStore = useAuthStore();
  // const requiresAuth = to.matched.some((record) => record.meta.requiresAuth);
  // const { currentUser, isLoggedIn } = storeToRefs(useAuthStore());

  // currentUser.value ? undefined : await authStore.getCurrent();

  // if (to.path === '/') {
  //   next({ name: 'SubjectListView' })
  //   return;
  // }

  // if ((to.name === 'SignInView' || to.name === 'SignUpView') && isLoggedIn.value) {
  //   next({ name: 'SubjectListView' })
  //   return;
  // }

  // if (requiresAuth && !isLoggedIn.value) {
  //   next({ name: 'SignInView' })
  //   return;
  // }

  // next()
})
