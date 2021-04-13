import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/login'
import dashboard from '@/components/dashboard/dashboard.vue'
import customerList from '@/components/customer/customerList.vue'
import categoryList from '@/components/category/categoryList.vue'

import articleList from '@/components/article/articleList.vue'

import articleDetails from '@/components/article/articleDetails.vue'

import faqList from '@/components/faq/faqList.vue'
import faqDetails from '@/components/faq/faqDetails.vue'

import roleList from '@/components/roles/roleList.vue'

import quizFormList from '@/components/quiz-form/quizFormList.vue'

import quizList from '@/components/quiz/quizList.vue'
import quizAdd from '@/components/quiz/quizAdd.vue'
import quizEdit from '@/components/quiz/quizEdit.vue'

import quizFormFieldList from '@/components/quiz-form-fields/quizFormFieldList.vue'
import pageConfiguration from '@/components/settings/pageConfigurationNew.vue'
import emailConfiguration from '@/components/settings/emailConfiguration.vue'

import bannerList from '@/components/banner/bannerList'


Vue.use(Router)

let router =  new Router({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login,
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
      path: '/user-list',
      name: 'customerList',
      component: customerList,
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
      path: '/page-configuration',
      name: 'pageConfiguration',
      component: pageConfiguration,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/email-configuration',
      name: 'emailConfiguration',
      component: emailConfiguration,
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
      path: '/role-list',
      name: 'roleList',
      component: roleList,
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
      path: '/banner-list',
      name: 'bannerList',
      component: bannerList,
      meta: {
        requiresAuth: true
      }
    },
  ],
  mode: 'history',
  base: 'back'
});

function getRoutesList(routes, pre) {
  return routes.reduce((array, route) => {
    const path = `${pre}${route.path}`;

    if (route.path !== '*') {
      array.push(path);
    }

    if (route.children) {
      array.push(...getRoutesList(route.children, `${path}/`));
    }

    return array;
  }, []);
}

function getRoutesXML() {
  const list = getRoutesList(router.options.routes, 'http://localhost:8080/back')
      .map(route => `<url><loc>${route}</loc></url>`)
      .join('\r\n');
  return `<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
    ${list}
  </urlset>`;
}






router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!localStorage.getItem('authToken')) {
      next({
        // path: '/',
        params: {nextUrl: to.fullPath}
      })
    } else {
      next()
      console.log(getRoutesList(router.options.routes, 'http://localhost:8080/back'));
      console.log(getRoutesXML());
    }
  } else {
    next()
  }
})

export default router;
