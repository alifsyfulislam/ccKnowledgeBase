import { createRouter,createWebHistory } from 'vue-router'

import Display from '../views/Display'
import ArticleDetail from '../views/ArticleDetail'
import CategoryList from '../views/CategoryList'
import Contact from '../views/Contact'
import Faq from '../views/Faq.vue'
import Search from '../views/Search'
import NotFound from '../views/NotFound'
import Quiz from '../views/Quiz'


let router = createRouter({
    scrollBehavior() {
        return {x: 0, y: 0};
    },
    history: createWebHistory(process.env.BASE_URL),
    routes: [
        {
            path: '/',
            name: 'Display',
            component: Display
        },
        {
            path: '/contact',
            name: 'Contact',
            component: Contact
        },
        {
            path: '/faq',
            name: 'Faq',
            component: Faq
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
            path: '/search',
            name: 'Search',
            component: Search
        },
        {
            path: '/quiz',
            name: 'Quiz',
            component: Quiz
        },
        {
            path: "/:catchAll(.*)",
            name: 'NotFound',
            component: NotFound
        },
    ],
    mode: 'history',
    base:'kbs'
});

export default router
