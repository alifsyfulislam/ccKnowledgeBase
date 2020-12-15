import { createRouter, createWebHistory } from 'vue-router'
//import Home from '../views/Home.vue'

import About from '../views/About.vue'
import dashboard from '../components/dashboard/dashboard.vue'
import login from '../components/login.vue'

import categoryList from '../components/category/categoryList.vue'

import articleList from '../components/article/articleList.vue'

import articleDetails from '../components/article/articleDetails.vue'

import faqList from '../components/faq/faqList.vue'
import faqDetails from '../components/faq/faqDetails.vue'

import customerList from '../components/customer/customerList.vue'

import roleList from '../components/roles/roleList.vue'
import roleEdit from '../components/roles/roleEdit.vue'
import roleAdd from '../components/roles/roleAdd.vue'

import quizFormList from '@/components/quiz-form/quizFormList.vue'

import quizList from '@/components/quiz/quizList.vue'
import quizAdd from '@/components/quiz/quizAdd.vue'
import quizEdit from '@/components/quiz/quizEdit.vue'

import quizFormFieldAdd from '@/components/quiz-form-fields/quizFormFieldAdd.vue'
import quizFormFieldList from '@/components/quiz-form-fields/quizFormFieldList.vue'
import quizFormFieldEdit from '@/components/quiz-form-fields/quizFormFieldEdit.vue'

import Display from '@/components/front/Display.vue'

let router = createRouter({
  scrollBehavior() {
    return {x: 0, y: 0};
  },
  history: createWebHistory(process.env.BASE_URL),
  routes: [
    {
      path: '/display',
      name: 'Display',
      component: Display,
      meta: {
        requiresAuth: false
      }
    },

    {
      path: '/admin/quizAdd',
      name: 'quizAdd',
      component: quizAdd,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/quizList',
      name: 'quizList',
      component: quizList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/quizEdit/:id',
      name: 'quizEdit',
      component: quizEdit,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/quiz-form-field-add/',
      name: 'quizFormFieldAdd',
      component: quizFormFieldAdd,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/quizFormFieldList/:id',
      name: 'quizFormFieldList',
      component: quizFormFieldList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/quizFormFieldEdit/:id',
      name: 'quizFormFieldEdit',
      component: quizFormFieldEdit,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/quiz-form-list',
      name: 'quizFormList',
      component: quizFormList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/roleAdd',
      name: 'roleAdd',
      component: roleAdd,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/roleList',
      name: 'roleList',
      component: roleList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/roleEdit/:id',
      name: 'roleEdit',
      component: roleEdit,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/customer-list',
      name: 'customerList',
      component: customerList,
      meta: {
        requiresAuth: true
      }
    },


    {
      path: '/admin/faq-list',
      name: 'faqList',
      component: faqList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/faq-details/:id',
      name: 'faqDetails',
      component: faqDetails,
      meta: {
        requiresAuth: true
      }
    },


    {
      path: '/admin/article-list',
      name: 'articleList',
      component: articleList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/article-details/:id',
      name: 'articleDetails',
      component: articleDetails,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/category-list',
      name: 'categoryList',
      component: categoryList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/dashboard',
      name: 'dashboard',
      component: dashboard,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/about',
      name: 'About',
      component: About

    }, {
      path: '/admin/',
      name: 'login',
      component: login
    },

  ],
  mode: `history`,
  base: "kbs",
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!localStorage.getItem('authToken')) {
      next({
        path: '/admin',
        params: {nextUrl: to.fullPath}
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

/*router.beforeEach((to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAuth)) {
    if (localStorage.getItem('authToken') == null) {
      next({
        path: '/login',
        params: { nextUrl: to.fullPath }
      })
    } else {
      let user = JSON.parse(localStorage.getItem('authToken'))
      if(to.matched.some(record => record.meta.is_admin)) {
        if(user.is_admin == 1){
          next()
        }
        else{
          next({ name: 'userboard'})
        }
      }else {
        next()
      }
    }
  }else {
    next()
  }
})*/

export default router
