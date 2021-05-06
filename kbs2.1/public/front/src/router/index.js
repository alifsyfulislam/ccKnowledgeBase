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

export default router;


