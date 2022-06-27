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
};
</script>
