<template>
  <v-container fluid>
    <v-row align="center">
      <v-col cols="6">
        <v-subheader> 年齢 </v-subheader>
      </v-col>

      <v-col cols="6">
        <v-select
          v-model="setAge"
          :items="items"
          label="選択する"
          single-line
        ></v-select>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
const maxAge = 117
const ageRange = [...Array(maxAge).keys()].map(String)
export default {
  props: {
    age: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      items: ageRange,
    }
  },
  computed: {
    setAge: {
      get() {
        return this.age
      },
      set(newVal) {
        return this.$emit('update:age', newVal)
      },
    },
  },
}
</script>
