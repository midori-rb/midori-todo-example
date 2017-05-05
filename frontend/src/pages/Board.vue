<template lang="pug">
#board
  router-link#logout(to="/login")
    | Logout
  div(v-for="task in tasks")
    task(:id="task.id", :title="task.title", :status="task.status", v-on:toggle="toggle", v-on:remove="remove")
  input#new-task(@keydown.enter="submit", v-model="text")
</template>

<script>
import request from '@/utils/request';
import Task from '@/components/Task';

export default {
  name: 'Board',
  components: {
    Task,
  },
  data() {
    return {
      tasks: [],
      text: '',
    };
  },
  mounted() {
    const token = localStorage.getItem('token');
    if (token === null) {
      this.$router.push('/login');
    }
    this.refresh();
  },
  methods: {
    refresh() {
      const token = localStorage.getItem('token');
      (async () => {
        const res = await request('GET', '/task',
          {},
          { token },
        );
        this.tasks.splice(0, this.tasks.length);
        this.tasks.push(...res);
      })();
    },
    submit() {
      const token = localStorage.getItem('token');
      (async () => {
        await request('POST', '/task',
          { title: this.text },
          { token },
        );
      })();
      this.refresh();
      this.text = '';
    },
    toggle(data) {
      const token = localStorage.getItem('token');
      (async () => {
        await request('PUT', `/task/${data.id}`,
          { status: data.status },
          { token },
        );
      })();
      this.tasks.forEach((task) => {
        if (task.id === data.id) {
          task.status = data.status;
        }
      });
    },
    remove(data) {
      const token = localStorage.getItem('token');
      (async () => {
        await request('DELETE', `/task/${data.id}`,
          {},
          { token },
        );
      })();
      // Someone said that my JavaScipt code is not lispy enough, so I have to made it this way.
      const map = obj => f => obj.map(f);
      const filter = obj => f => obj.filter(f);
      const splice = obj => index => num => obj.splice(index, num);
      const self = obj => this[obj];
      const get = obj => element => obj[element];
      const eq = t1 => t2 => t1 === t2;
      const pop = obj => obj.pop();
      splice(self('tasks'))(get(pop(filter(
        map(self('tasks'))((task, index) =>
          (item => i => ([get(item)('id'), i]))(task)(index)))(item =>
            eq(get(item)(0))(get(data)('id')))))(1))(1);
      // which is equivalent to
      // this.tasks.splice(this.tasks.map((task, index) => ({
      //   id: task.id,
      //   index: index,
      // })).filter(item => item.id === data.id).pop().index, 1)
    },
  },
};
</script>

<style lang="stylus" scoped>
#logout
  color: #000
  display: inherit
  text-decoration: none
  text-align: right
  font-weight: 800
  cursor: pointer
  margin: 20px
#new-task
  width: 80%
  margin: 12px 12px 12px 12px
  padding: 16px
  text-align: center
  font-size: 20px
</style>
