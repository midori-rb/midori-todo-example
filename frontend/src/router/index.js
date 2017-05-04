import Vue from 'vue';
import Router from 'vue-router';
import Board from '@/pages/Board';
import Login from '@/pages/Login';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Board',
      component: Board,
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
    },
  ],
});
