<template lang="pug">
.task
  .title(@click="done", :class="{ done: status }")
    | {{ title }}
  .delete(@click="remove")
    | x
</template>

<script>
export default {
  name: 'Task',
  props: {
    id: {
      type: Number,
    },
    title: {
      type: String,
    },
    status: {
      type: Number,
    },
  },
  methods: {
    done() {
      this.$emit('toggle', {
        id: this.id,
        status: 1 - this.status,
      });
    },
    remove() {
      this.$emit('remove', {
        id: this.id,
      });
    },
  },
};
</script>

<style lang="stylus" scoped>
.done
  text-decoration: line-through
  color: grey
.task
  width: 80%
  margin: 12px 12px 12px 12px
  padding: 16px
  display: inline-flex
  user-select: none
  box-shadow: 0 1px 3px rgba(0,0,0,.2), 0 1px 1px rgba(0,0,0,.14), 0 2px 1px -1px rgba(0,0,0,.12)
  .title
    flex: 15
    font-size: 20px
    cursor: pointer
  .delete
    flex: 1
    padding-left: 10px
    cursor: pointer
</style>
