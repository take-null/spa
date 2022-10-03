<template>
  <loggedInFormCard>
    <template #form-card-content>
      <v-card-text>
        <p class="text-h6 text--primary text-center">
          ご利用いただきありがとうございます！
        </p>
        <p class="text-subtitle-1 text--primary">
          機能改善のため、ユーザーの皆様からのアンケートを募集しております！<br />
          サイトの見た目、あったら嬉しい機能、使いやすい(使いにくい)部分等、皆様のご意見をお寄せください。<br />
        </p>
        <p class="text-caption text--primary">
          ※頂いたご意見には必ず目を通し、サイトの改善に活用させて頂きます。
        </p>
      </v-card-text>
      <v-form ref="form" v-model="isValid">
        <user-form-survey-title :title.sync="params.title" />
        <user-form-survey-content :content.sync="params.content" />
        <div>
          {{ error }}
        </div>
        <v-btn
          block
          dark
          class="white--text"
          @click.stop="confirmSurvey = true"
        >
          内容を確認する
        </v-btn>
      </v-form>

      <v-dialog v-model="confirmSurvey" max-width="600">
        <v-card color="blue-grey lighten-5" class="mx-auto">
          <b-container class="d-flex justify-content-end">
            <v-btn text @click="confirmSurvey = false"> ✕ </v-btn>
          </b-container>
          <v-card-text>
            <p class="text-h6 text--primary text-center">
              以下の内容を送信してよろしいですか？
            </p>
            <p>【タイトル】</p>
            <div class="text--primary">
              {{ params.title }}
            </div>
            <v-divider />
            <p>【本文】</p>
            <div class="text--primary">
              {{ params.content }}
            </div>
          </v-card-text>
          <v-card-actions>
            <v-btn
              :loading="loading"
              block
              dark
              class="white--text"
              @click="sendSurvey()"
            >
              send
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="successSurvey" max-width="600">
        <v-card color="cyan lighten-4" class="mx-auto">
          <v-list-item-content>
            <v-list-item-title class="text-h5 mb-1 cyan--text">
              <v-icon> mdi-checkbox-marked-circle-plus-outline </v-icon>
              ご協力ありがとうございます！
            </v-list-item-title>
            <v-list-item-subtitle class="cyan--text">
              アンケートの送信が完了しました！<br />
              タイムラインへ移動します。
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-card>
      </v-dialog>
    </template>
  </loggedInFormCard>
</template>

<script>
import loggedInFormCard from '~/components/loggedIn/loggedInFormCard.vue'
export default {
  components: {
    loggedInFormCard,
  },
  data() {
    return {
      isValid: false,
      loading: false,
      confirmSurvey: false,
      successSurvey: false,
      params: { title: '', content: '' },
      error: null,
    }
  },
  methods: {
    async sendSurvey() {
      try {
        this.loading = true
        await this.$axios.$post('/api/v1/surveys', this.params).then((res) => {
          this.loading = false
          this.confirmSurvey = false
          this.successSurvey = true
          setTimeout(() => {
            this.formReset()
            this.$router.replace('/')
          }, 4000)
          return res
        })
      } catch (error) {
        console.log({ error })
        this.loading = false
        this.error = '送信に失敗しました。'
        this.formReset()
      }
    },
    formReset() {
      this.$refs.form.reset()
      this.params = { title: '', content: '' }
    },
  },
}
</script>
