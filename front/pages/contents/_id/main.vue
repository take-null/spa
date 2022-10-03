<template>
  <div>タイムラインに移動します</div>
</template>

<script>
export default {
  beforeCreate() {
    this.$router.replace('/')
  },
}
</script>
