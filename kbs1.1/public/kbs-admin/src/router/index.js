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

import quizFormFieldList from '@/components/quiz-form-fields/quizFormFieldList.vue'
import pageConfiguration from '@/components/settings/pageConfigurationNew.vue'


let router = createRouter({
    scrollBehavior() {
        return {x: 0, y: 0};
    },
    history: createWebHistory(process.env.BASE_URL),
    routes: [

        {
            path: '/page-configuration',
            name: 'pageConfiguration',
            component: pageConfiguration,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/quiz-add',
            name: 'quizAdd',
            component: quizAdd,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/quiz-list',
            name: 'quizList',
            component: quizList,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/quiz-edit/:id',
            name: 'quizEdit',
            component: quizEdit,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/quiz-form-field-list/',
            name: 'quizFormFieldList',
            component: quizFormFieldList,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/quiz-form-list',
            name: 'quizFormList',
            component: quizFormList,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/role-add',
            name: 'roleAdd',
            component: roleAdd,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/role-list',
            name: 'roleList',
            component: roleList,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/role-edit/:id',
            name: 'roleEdit',
            component: roleEdit,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/user-list',
            name: 'customerList',
            component: customerList,
            meta: {
                requiresAuth: true
            }
        },


        {
            path: '/faq-list',
            name: 'faqList',
            component: faqList,
            meta: {
                requiresAuth: true
            }
        },

        {
            path: '/faq-details/:id',
            name: 'faqDetails',
            component: faqDetails,
            meta: {
                requiresAuth: true
            }
        },


        {
            path: '/article-list',
            name: 'articleList',
            component: articleList,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/article-details/:id',
            name: 'articleDetails',
            component: articleDetails,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/category-list',
            name: 'categoryList',
            component: categoryList,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/dashboard',
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
            path: '/',
            name: 'login',
            component: login
        },

    ],
    mode: `history`,
    base: "kbs-admin",
});

router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (!localStorage.getItem('authToken')) {
            next({
                path: '/',
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