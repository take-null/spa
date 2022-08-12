<template>
  <before-login-form-card>
    <template 
      #form-card-content
    >
      <v-form
        ref="form"
        v-model="isValid"
      >
        <user-form-email 
          :email.sync="params.email"
          no-validation
        />
        <v-card-text 
          class="px-0"
        >
          <div>
            {{error}}
          </div>
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              dark
              class="white--text"
              @click="check"
              >
                送信する
            </v-btn>
          </v-card-text>
        </v-form>
    </template>
  </before-login-form-card>
</template>

<script>
export default {
  layout: 'beforeLogin',
  data () {
    return {
      isValid: false,
      loading: false,
      params: { email: '' }, 
      error: null
    }
  },
  methods: {
    async check () {
      try {
        this.loading = true
        await this.$axios.$post('/api/v1/auth/password/',{
            email: this.params.email,
            redirect_url: `http://localhost:8080/passwordReset`
        })
        .then(
          (res) => {
          this.loading = false
          return res
        }
      )
      } catch (error) {
        console.log({error})
        this.loading = false
        this.error = '入力内容が間違っています'
        this.formReset()
      }
    },
    formReset () {
      this.$refs.form.reset()
      this.params = { email: '' }
    }
  },
};
</script>