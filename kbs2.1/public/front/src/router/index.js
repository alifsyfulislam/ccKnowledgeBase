import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/Home'
import CategoryList from "@/views/CategoryList";
import ArticleDetail from "@/views/ArticleDetail";
import Faq from "@/views/Faq";
import Contact from "@/views/Contact";
import NotFound from "@/views/NotFound";
import Search from "../views/Search";

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
      path: '/category-list/:categoryID',
      name: 'CategoryList',
      component: CategoryList
    },
    {
      path: '/article-detail/:articleID',
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

