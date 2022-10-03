<template>
  <div>ログアウトしました</div>
</template>

<script>
export default {
  layout: 'logout',
  beforeCreate() {
    this.$auth.logout().then(() => {
      this.$router.replace('/')
      this.$nxauth.deleteData()
    })
  },
}
</script>
