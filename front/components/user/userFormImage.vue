<template>
  <v-form 
    ref="form" 
    lazy-validation 
    class="ma-16"
  >
    <v-icon> 
      mdi-account-box 
    </v-icon>
    <span>
      ユーザーイメージ
    </span>
    <v-row 
      justify="center" 
      class="pt-6"
    >
      <template 
        v-if="img !== null"
      >
        <v-avatar 
          v-if="input_image === null" 
          size="100"
        >
          <v-img  
            :src="`http://localhost:3000/${img}`" 
          />
        </v-avatar>
        <v-avatar 
          v-else 
          size="100"
        >
          <v-img 
            :src="input_image" 
          />
        </v-avatar>
      </template>
      <template v-else>
        <v-avatar 
          size="100"
        >
          <v-img 
            v-if="input_image" 
            :src="input_image" 
          />
      </v-avatar>
    </template>
  </v-row>
  <v-file-input
    v-model="editImage"
    accept="image/png, image/jpeg, image/bmp image/gif"
    prepend-icon="mdi-account-box"
    label="左のアイコンをクリック"
    class="pt-14"
    @change="setImage"
  />
    <b-container 
      class="d-flex justify-content-center"
    >
      <v-btn
        @click.stop="changeUserAvatar"
        dark
        class="white--text"
        :loading="loading"
      >
        イメージを更新
      </v-btn>
    </b-container>
  </v-form>
</template>

<script>
export default {
  data() {
    return {
      img: this.$store.state.current.user.image.url,
      editImage: {},
      input_image: null,
      loading: false
    }
  },
  methods: {
    setImage(file) {
      this.editImage = file
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener('load', () => {
          this.input_image = fr.result
        })
      } else {
        this.input_image = null
      }
    },
    async changeUserAvatar() {
      try {
      this.loading = true
      const formData = new FormData()
      if (this.editImage !== null) {
        formData.append('image', this.editImage)
      }
      await this.$axios
        .put('api/v1/auth', formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        })
        .then(
          (res) => {
          this.$router.go({path: this.$router.currentRoute.path, force: true})
          this.loading = false
          }
        )
        } catch (error) {
          console.log({error})
      }
    },
  }
};
</script>