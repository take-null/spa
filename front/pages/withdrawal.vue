<template>
  <loggedInFormCard>
    <template 
      #form-card-content
    >
      <v-card
        class="mx-auto"
        max-width="600"
        elevation="0"
      >
        <v-row 
          justify="center"
        >
          <v-icon
            x-large
          >
            mdi-emoticon-cry-outline
          </v-icon>
        </v-row>
        <v-card-text>  
        <p 
          class="text-h5 text--primary text-center"
        >
          退会手続きの前にご確認下さい！
        </p>
        <div 
          class="text-subtitle-1 text--primary"
        >
          ・下部の【退会する】ボタンをダブルクリックすると退会手続きが行われます。<br>
          ・投稿されたレビュー、チャットログを含むユーザー情報は全て抹消され、復元が出来なくなります。<br>
          ・再び当サイトをご利用される際は、再度ユーザー情報を登録して頂く必要があります。<br>
        </div>
        </v-card-text>
        <v-card-text>
          {{error}}
        </v-card-text>
        <v-card-actions>
          <v-btn
            :loading="loading"
            block
            color="error"
            class="white--text"
            @dblclick="deleteUser()"
          >
            退会する
          </v-btn>
        </v-card-actions>
      </v-card>    
    </template>
  </loggedInFormCard>
</template>
  
<script>
import loggedInFormCard from '~/components/loggedIn/loggedInFormCard.vue'
export default {
  components: { 
    loggedInFormCard 
  },
  data () {
    return {
      loading: false,
      error: null,
      message: null
    }
  },
  methods: {
    async deleteUser () {
      if ( this.$store.state.current.user.id === 1 ) {
        this.error = 'ゲストユーザーは退会手続きができません。'
        } else {
        try {
          this.loading = true
          await this.$axios.$delete(`/api/v1/users/${this.$store.state.current.user.id}`)
          .then(
          (res) => {
          this.loading = false
          this.$nxauth.removeStorage()
          this.$router.replace('/')
          return res
        })
        } catch (error) {
          console.log({error})
          this.loading = false
          this.error = 'エラーが発生しました。ブラウザを更新後、再度お試しください。'
        }
      }  
    }
  }
};
</script>