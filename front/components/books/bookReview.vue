<template>
  <v-sheet
    class="mx-auto"
    max-width="768"
    color="blue-grey lighten-5"
    title
    rounded-0
    elevation="1"
  >
  <v-container
    fluid
  >
  <div>
    {{created_at}}前
  </div>
    <v-row
      no-gutters
    >
      <v-col>
        <v-list-item 
          class="px-2"
        >
          <v-list-item-avatar 
            size="45"
          >
            <v-btn 
              icon 
              outlined 
              rounded @click.stop="toShowChild(user_id)"
            >
              <template 
                v-if="user_image === null"
              >
                <v-icon 
                  x-large
                >
                  mdi-account-circle
                </v-icon>
              </template>
              <template 
                v-else
              >
                <v-img 
                  :src="`${$config.defaultUrl}${user_image}`" 
                  alt="avatar" 
                />
              </template>
            </v-btn>
          </v-list-item-avatar>
          <v-list-item-title 
            class="text-body-2 text--primary"
          >
            {{user_name}}
          </v-list-item-title>
          </v-list-item>
      </v-col> 
    </v-row>
  </v-container>
  <v-container
    fluid
    mt-n2 pt-0
  >
    <v-list-item
      class="text-body-2  text--primary wrap-text justify-content-center"
    >
      【{{title}}】
    </v-list-item>
    <v-list-item 
      class="justify-content-center"
    >
      <template 
        v-if="book_image === null"
      >
        <v-img
          max-height="160"
          max-width="120"
          :src="require('@/assets/img/20200505_noimage.jpg')"
        />
      </template>
      <template 
        v-else
      >
        <v-img
          max-heigth="160"
          max-width="120"
          :src="book_image"
        />
      </template>
    </v-list-item>
    <v-list-item 
      class="justify-content-center"
    >
      <v-rating
        v-model="rating"
        background-color="orange lighten-3"
        color="orange"
        x-small
      ></v-rating>
    </v-list-item>
    <v-list-item-content>
      <v-list
        class="list overflow-y-auto text-body-2 text--primary wrap-text mt-n5"
        style="max-height: 150px"
      >
        {{comment}}
      </v-list>
    </v-list-item-content>
    </v-container>
    <v-container
      fluid
      mt-n2 pt-0
    >
      <v-row
        no-gutters
      >
        <v-col
          v-for="tag in tags" :key="tag.id"
        >
          <v-btn
            text
            small
            @click.stop="searchTagChild(tag.name)"
          >
            <p
              class="text-overline text--cyan"
            >
              #{{tag.name}}
            </p>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
    <v-container  
      mt-n2 pt-0 
      v-if="isGood" 
    >
      <v-row
        dense
      >
        <v-col>
          <v-btn
            icon
            @click="deleteGood()"
          >
            <v-icon
              color="cyan"
            >
              mdi-thumb-up
            </v-icon>
            <p
              class="text-caption"
            >
              {{ count }}
            </p>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
    <v-container 
      mt-n2 pt-0 
      v-else
    >
      <v-row
        dense
      >
        <v-col>
          <v-btn
            icon
            @click="createGood()"
          >
            <v-icon
              dark
            >
              mdi-thumb-up-outline
            </v-icon>
            <p
              class="text-caption"
            >
              {{ count }}
            </p>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
    <v-divider></v-divider>
  </v-sheet>
</template>

<script>

export default {
  components: {},
  props: {
    book_image: {
      type: String
    },
    comment: {
      type: String
    },
    created_at: {
      type: String
    },
    google_books_api_id: {
      type: String
    },
    id: {
      type: Number
    },
    rating: {
      type: Number
    },
    title: {
      type: String
    },
    user_id: {
        type: Number
    },
    user_image: {
      type: String
    },
    user_name: {
      type: String
    },
    tags: {
      type:Array
    },
    goodArray: {
      type:Array
    }
  },
  data () {
    return {
      dialog: false,
      goodList: this.goodArray
    }
  },
  computed: {
    count() {
      return this.goodList.length
    },
    isGood() {
      if (this.goodList.lenght === 0) { return false }
        return Boolean(this.findGoodId())
    }
  },
  methods: {
    toShowChild() {
      this.$emit(
        'toShowParent', 
        this.user_id,
      )
    },
    searchTagChild(tag) {
      this.$emit(
        'searchTagParent', 
        tag,
      )
    },
    fetchGoodByBooksShelfId: async function() {
      const res = await this.$axios.get(`/api/v1/goods/?books_shelf_id=${this.id}`)
      if (res.status !== 200) {
      }
      return res.data
    },
    createGood: async function() {
      const res = await this.$axios.$post('/api/v1/goods', { books_shelf_id: this.id })
      if (res.status !== 201) {
      }
      this.fetchGoodByBooksShelfId().then(result => {
        this.goodList = result
      })
    },
    deleteGood: async function() {
      const goodId = this.findGoodId()
      const res = await this.$axios.$delete(`/api/v1/goods/${goodId}`)
      if (res.status !== 200) {
      }
      this.goodList = this.goodList.filter(n => n.id !== goodId)
    },
    findGoodId: function() {
      const good = this.goodList.find((good) => {
        return (good.user_id === this.$store.state.current.user.id)
      })
      if (good) { return good.id }
    }
  }
}
</script>

<style>
.wrap-text {
  word-break: break-all;
  white-space: pre-line;
}
.list::-webkit-scrollbar { 
  display: none;
}

.list {
  scrollbar-width: none;
  position: relative;
  z-index: 0;
}
.chip {
  position: absolute;
  z-index: 1;
}
</style>