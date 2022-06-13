<template>
  <v-text-field 
    :value="name"  
    label="名前" 
    prepend-icon="mdi-account-circle"
    @input="$emit('update:name', $event)"
  >
  </v-text-field>
</template>
<script>
export default {
  props: { 
    name: {
      type: String,
      default: "",
      required: true,
    },    
  },
};
</script>