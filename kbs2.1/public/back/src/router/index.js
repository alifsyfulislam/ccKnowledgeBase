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
import commentList from '@/components/comment/commentList'
import notificationList from '@/components/notification/notificationList.vue'

import allHistoryList from '@/components/history/allHistoryList.vue'
import resultList from '@/components/result/resultList.vue'
import userQuizList from '@/components/result/userQuizList.vue'
import userQuizResultList from '@/components/result/userQuizResultList.vue'
import resultDetails from '@/components/result/resultDetails.vue'


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
      beforeEnter : guardMyroute,
      component: dashboard,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/user-list',
      name: 'customerList',
      beforeEnter : guardMyroute,
      component: customerList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/comment-list',
      name: 'commentList',
      beforeEnter : guardMyroute,
      component: commentList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/category-list',
      name: 'categoryList',
      beforeEnter : guardMyroute,
      component: categoryList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/page-configuration',
      name: 'pageConfiguration',
      beforeEnter : guardMyroute,
      component: pageConfiguration,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/email-configuration',
      name: 'emailConfiguration',
      beforeEnter : guardMyroute,
      component: emailConfiguration,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/quiz-add',
      name: 'quizAdd',
      beforeEnter : guardMyroute,
      component: quizAdd,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/quiz-list',
      name: 'quizList',
      beforeEnter : guardMyroute,
      component: quizList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/quiz-edit/:id',
      name: 'quizEdit',
      beforeEnter : guardMyroute,
      component: quizEdit,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/quiz-form-field-list/',
      name: 'quizFormFieldList',
      beforeEnter : guardMyroute,
      component: quizFormFieldList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/quiz-form-list',
      name: 'quizFormList',
      beforeEnter : guardMyroute,
      component: quizFormList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/role-list',
      name: 'roleList',
      beforeEnter : guardMyroute,
      component: roleList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/faq-list',
      name: 'faqList',
      beforeEnter : guardMyroute,
      component: faqList,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/faq-details/:id/:slug',
      name: 'faqDetails',
      beforeEnter : guardMyroute,
      component: faqDetails,
      meta: {
        requiresAuth: true
      }
    },


    {
      path: '/article-list',
      name: 'articleList',
      beforeEnter : guardMyroute,
      component: articleList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/article-details/:id/:slug',
      name: 'articleDetails',
      beforeEnter : guardMyroute,
      component: articleDetails,
      meta: {
        requiresAuth: true
      }
    },

    {
      path: '/banner-list',
      name: 'bannerList',
      beforeEnter : guardMyroute,
      component: bannerList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/notification-list',
      name: 'notificationList',
      component: notificationList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/history-list',
      name: 'allHistoryList',
      component: allHistoryList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/result-list',
      name: 'resultList',
      component: resultList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/user-quiz-list/:userId',
      name: 'userQuizList',
      component: userQuizList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/user-quiz-result-list/:userId/:quizId',
      name: 'userQuizResultList',
      component: userQuizResultList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/result-details/:userId/:quizId/:attempt',
      name: 'resultDetails',
      component: resultDetails,
      meta: {
        requiresAuth: true
      }
    }
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

function guardMyroute(to, from, next)
{
  var isAuthenticated= false;
//this is just an example. You will have to find a better or
// centralised way to handle you localstorage data handling
  if(localStorage.getItem('authToken'))
    isAuthenticated = true;
  else
    isAuthenticated= false;
  if(isAuthenticated)
  {
    next(); // allow to enter route
  }
  else
  {
    next('/'); // go to '/login';
  }
}

export default router;
