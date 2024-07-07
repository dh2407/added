import { createRouter, createWebHistory } from 'vue-router'

import HomeView from '@/views/Home.vue'
import SubjectListView from '@/views/Subject/SubjectsList.vue'
import SubjectDetailsView from '@/views/Subject/SubjectDetails.vue'
import SubSubjectView from '@/views/SubSubject/SubSubject.vue'

const routes = [
  { path: '/', component: HomeView },
  {
    path:
      '/subject',
    name: "SubjectListView",
    component: SubjectListView
  },
  {
    path:
      '/subject/:id',
    name: "SubjectDetailsView",
    component: SubjectDetailsView,
    props: true,
  },
  {
    path: '/subject/:subjectId/subSubject/:subSubjectId',
    name: 'SubSubjectView',
    component: SubSubjectView,
    props: true,
  }
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach(async (to, from, next) => {
  if (to.path === '/') {
    next({ name: 'SubjectListView' })
    return;
  }

  next()
})
