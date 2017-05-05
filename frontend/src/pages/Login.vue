<template lang="pug">
#login
  input.input(placeholder="Username", v-model="username")
  input.input(placeholder="Password", v-model="password", type="password")
  button.button(@click="login")
    | Log in
  button.button(@click="signup")
    | Sign up
</template>

<script>
import request from '@/utils/request';

export default {
  name: 'Login',
  mounted() {
    localStorage.removeItem('token');
  },
  methods: {
    login() {
      (async () => {
        const res = await request('POST', '/user/login',
          {
            username: this.username,
            password: this.password,
          },
        );
        localStorage.setItem('token', res.token);
        this.$router.push('/');
      })();
    },
    signup() {
      (async () => {
        await request('POST', '/user/register',
          {
            username: this.username,
            password: this.password,
          },
        );
        alert('Register Successfully');
      })();
    },
  },
};
</script>

<style lang="stylus" scoped>
.input
  width: 80%
  margin: 12px 12px 12px 12px
  padding: 16px
  text-align: center
  font-size: 20px
.button
  width: 80%
  margin: 12px 12px 12px 12px
  box-sizing: content-box
  background: #66ccff
  border: none
  color: #fff
  padding: 16px
  text-align: center
  font-size: 20px
</style>
