<template>
  <div>ログアウトしました</div>
</template>

<script>
export default {
  layout: 'logout',
  beforeCreate () {

     this.$auth.logout()
      .then(() => {
        this.$store.dispatch('logout')
        localStorage.removeItem("access-token")
        localStorage.removeItem("client")
        localStorage.removeItem("uid")
        localStorage.removeItem("token-type")
        this.$router.replace('/')
    })
    },
  
      //return res
    //} catch (error) {
      //console.log({error})
    //}
  //async middleware ({ store, redirect, from }) {
    //await store.dispatch('logout')
    //if (from.name !== 'index') { return redirect('/') }
  //},
  //layout: 'logout',
  //beforeCreate () {
    //this.$router.replace('/')
  //}
  //},
  //async middleware ({ store }) {
    //await store.dispatch('logout')
    //this.$router.replace('/')
  //},
};
</script>
