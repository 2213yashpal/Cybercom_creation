<!-- App.vue -->

<template>
    
   <div class="container">
    <!-- <postlist/> -->
    <Teleport to="#footer">
      <Footer/>
    </Teleport>
    <button @click="showpopup=true">show popup</button>
    <Popup v-show="showpopup" @close="closepopup"/>
     <!-- <Popover @custom-event="handleEvent"></Popover> -->
     <Excompo :id="elementId" :message="message" :age="age" />
     <objectprop  :myObject="objectProp"/>
     <Parent/>
     <templateref/>
     
   </div>
 </template>
 
 <script>
 import Excompo from './excompo.vue';
 import Objectprop from './objectprop.vue';
 import Popup from './popup.vue';
 import Parent from './parent.vue';
 import Footer from './footer.vue';
 import Postlist from './postlist.vue';
 import templateref from './templateref.vue';

 
 export default {
   name: 'home',
   components: {
     Excompo,
     Objectprop,
     Parent,    
     Popup,
     Footer,
     Postlist,
     templateref
 },
 data(){
   return {
     message: 'Hello Vue',
     age: 25,
     objectProp: { name: 'John', age: 30, city: 'New York' },
     elementId:'my-id',
     showpopup:false

 
 
   }
 },
 methods: {
   handleEvent(data) {
       console.log('Received data:', data.message);
     },
     closepopup(name){
        this.showpopup=false
        // console.log('name : ' ,name);
     }
   }
 }
 </script>

<style scoped>
.container{
  margin-top: 90px;
}
</style>
 
 
 