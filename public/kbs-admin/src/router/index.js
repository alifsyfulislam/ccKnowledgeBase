import { createRouter, createWebHistory } from 'vue-router'
//import Home from '../views/Home.vue'

import About from '../views/About.vue'
import dashboard from '../components/dashboard/dashboard.vue'
import login from '../components/login.vue'
import categoryList from '../components/category/categoryList.vue'
import categoryAdd from '../components/category/categoryAdd.vue'
import articleList from '../components/article/articleList.vue'
import articleAdd from '../components/article/articleAdd.vue'
import articleDetails from '../components/article/articleDetails.vue'
import articleEdit from '../components/article/articleEdit.vue'
import faqList from '../components/faq/faqList.vue'
import faqAdd from '../components/faq/faqAdd.vue'
import faqDetails from '../components/faq/faqDetails.vue'
import faqEdit from '../components/faq/faqEdit.vue'


import customerList from '../components/customer/customerList.vue'
import customerAdd from '../components/customer/customerAdd.vue'
import customerEdit from '../components/customer/customerEdit.vue'

import roleList from '../components/roles/roleList.vue'
import roleEdit from '../components/roles/roleEdit.vue'
import roleAdd from '../components/roles/roleAdd.vue'

import quizFormList from '@/components/quiz-form/quizFormList.vue'
import quizFormAdd from '@/components/quiz-form/quizFormAdd.vue'
import quizFormEdit from '@/components/quiz-form/quizFormEdit.vue'

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
      path: '/admin/quizFormFieldAdd/:id',
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
      path: '/admin/quizFormEdit/:id',
      name: 'quizFormEdit',
      component: quizFormEdit,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/quizFormAdd',
      name: 'quizFormAdd',
      component: quizFormAdd,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin/quizFormList',
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
      path: '/admin/customer-edit/:id',
      name: 'customerEdit',
      component: customerEdit,
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
      path: '/admin/customer-add',
      name: 'customerAdd',
      component: customerAdd,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/faqAdd',
      name: 'faqAdd',
      component: faqAdd,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/faqList',
      name: 'faqList',
      component: faqList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/faqDetails/:id',
      name: 'faqDetails',
      component: faqDetails,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/faqEdit/:id',
      name: 'faqEdit',
      component: faqEdit,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/articleList',
      name: 'articleList',
      component: articleList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/articleAdd',
      name: 'articleAdd',
      component: articleAdd,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/articleDetails/:id',
      name: 'articleDetails',
      component: articleDetails,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/articleEdit/:id',
      name: 'articleEdit',
      component: articleEdit,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/categoryList',
      name: 'categoryList',
      component: categoryList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/admin/categoryAdd',
      name: 'categoryAdd',
      component: categoryAdd,
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
