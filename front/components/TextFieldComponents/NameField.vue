<template>
  <v-text-field
    v-model="setName"
    :value="name"  
    label="名前" 
    prepend-icon="mdi-account-circle"
    placeholder="あなたの名前"
    outlined
  >
  </v-text-field>
</template>
<script>
export default {
  props: { 
    name: {
      type: String,
      default: "",
      required: true
    }    
  },
  computed: {
    setName: {
      get () { return this.name },
      set (newVal) { return this.$emit('update:name', newVal) }
    }
  }
}
</script>