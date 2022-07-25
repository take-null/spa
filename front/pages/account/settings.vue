<template>
  <div>マイページに移動します</div>
</template>

<script>
export default {
  beforeCreate () {
      this.$router.replace('/contents/1/account')
  }
};
</script>