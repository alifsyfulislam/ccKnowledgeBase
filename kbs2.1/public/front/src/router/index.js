import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/Home'
import CategoryList from "@/views/CategoryList";
import ArticleDetail from "@/views/ArticleDetail";
import Registration from "@/views/Registration";
import Faq from "@/views/Faq";
import Contact from "@/views/Contact";
import NotFound from "@/views/NotFound";
import Search from "../views/Search";
import Quiz from "../views/Quiz";
import StartExam from "../views/StartExam";
import Sitemap from "../views/Sitemap";
import quizHistory from "../views/quizHistory/UserQuizHistory";
import quizResultList from "../views/quizHistory/UserQuizResultList";
import detailsResult from "../views/quizHistory/DetailsResult";


const originalPush = Router.prototype.push;
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
};

Vue.use(Router)


let router =  new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/quiz',
      name: 'Quiz',
      component: Quiz
    },
    {
      path: '/registration',
      name: 'Registration',
      component: Registration
    },
    {
      path: '/start-exam',
      name: 'StartExam',
      component: StartExam
    },
    {
      path: '/category-list/:categoryID',
      name: 'CategoryList',
      component: CategoryList
    },
    {
      path: '/article-detail/:articleID/:articleSlug',
      name: 'ArticleDetail',
      component: ArticleDetail
    },
    {
      path: '/faq',
      name: 'Faq',
      component: Faq
    },
    {
      path: '/contact',
      name: 'Contact',
      component: Contact
    },
    {
      path: '/search',
      name: 'Search',
      component: Search
    },{
      path: '/sitemap',
      name: 'Sitemap',
      component: Sitemap
    },
    {
      path: '/quiz-history',
      name: 'quizHistory',
      beforeEnter : guardMyroute,
      component: quizHistory,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/quiz-result-list/:quiz_id',
      name: 'quizResultList',
      beforeEnter : guardMyroute,
      component: quizResultList,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/details-result/:quiz_id/:attempt',
      name: 'detailsResult',
      beforeEnter : guardMyroute,
      component: detailsResult,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/:catchAll(.*)",
      name: 'NotFound',
      component: NotFound
    }
    
  ],
  mode : 'history',
  base : 'kbs'
})

router.beforeEach((to, from, next) => {
  // to top
  window.scrollTo(0, 0);
  next();
});

function guardMyroute(to, from, next)
{
  var isAuthenticated= false;
//this is just an example. You will have to find a better or
// centralised way to handle you localstorage data handling
  if(sessionStorage.getItem('userToken'))
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


