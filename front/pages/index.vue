<template>
  <div>
    index.vue
  </div>
</template>

<script>
export default {
  layout ({ $nxauth }) {
    return $nxauth.loggedIn ? 'loggedIn' : 'welcome'
    //return store.state.loggedIn ? 'default' : 'welcome'
  },  
};
</script>