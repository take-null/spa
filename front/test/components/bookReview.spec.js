import { createLocalVue, shallowMount } from '@vue/test-utils'
import Vuex from 'vuex'
//state.current.userはデフォルトがnullなので以下はコメントアウトし、直接定義する
//import { state } from '@/store/index.js'
import bookReview from '~/components/books/bookReview'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('bookReview.vue', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store({
      state: {
        current: {
          user: {
            id: 1
          }
        }
      }
    })
  })
  it('Display text', () => {
    const props = {
      book_image: 'http://books.google.com/books/content?id=crdI253WP…=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',
      comment: 'コメント',
      created_at: '2022-08-20T13:14:17.520Z',
      google_books_api_id: 'gkrYzAEACAAJ',
      id: 1,
      rating: 5,
      title: 'オズの魔法使い',
      user_id: 1,
      user_image: '/uploads/user/image/1/thumb_ph_thumb.jpg',
      user_name: 'admin',
      tags: [
        {
          "id": 9,
          "name": "小説",
          "taggings_count": 16
        },
        {
          "id": 18,
          "name": "エッセイ",
          "taggings_count": 12
        }
      ],
      goodArray: [
        {
          "id": 42,
          "user_id": 1,
          "books_shelf_id": 67
        }
      ]
    }
    const wrapper = shallowMount(bookReview, {
      propsData: props,
      store,
      localVue
    })
    expect(wrapper.props()).toEqual(props)
  })
})