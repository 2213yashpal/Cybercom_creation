<template>
    <div v-html="tag"></div>
    <h5 :class="{green:colorfull}">home components</h5>
    <button @mouseover="handleMouseOver" v-on:click="colorfull=!colorfull">apply style</button> <br/>
    <input type="text" @keydown="handleKeyDown">
    <user/>


    <child name="yashpal" :user="user" :getdata="getdata" />
    <iterate/>
  </template>
  
  <script>
  import child from './child.vue'
  import iterate from './iterate.vue'
  import user from './user.vue';
  export default {
    name: "home",
    components: {
      child,
      iterate,
      user
    },
    data() {
      return {
        user: [{ name: "sumit", email: "sumit@example.com" },
        { name: "yashpal", email: "yashpal@example.com" }],
        tag:"<h1>hello from html binding</h1>",
        colorfull:false,
      };
    },
    methods: {
      getdata() {
        console.log("parent compo called");
      },
      handleKeyDown(event) {
      console.log('Key pressed:', event.key);
    },
    handleMouseOver() {
      console.log('Mouse over the element');
    }
    }
  };
  </script>

  <style scoped>
  .green{
    background-color:green;
    width:100%;
    padding: 10px;
  }
</style>
  