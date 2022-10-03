import { createLocalVue, shallowMount } from '@vue/test-utils'
import Vuex from 'vuex'
import bookDetail from '~/components/books/bookDetail'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('bookDetail.vue', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store({
      state: {
        current: {
          user: {
            id: 1,
          },
        },
      },
    })
  })
  it('Display text', () => {
    const props = {
      user_id: 1,
      book_image:
        'http://books.google.com/books/content?id=crdI253WP…=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',
      comment: 'コメント',
      created_at: '2022-08-20T13:14:17.520Z',
      google_books_api_id: 'gkrYzAEACAAJ',
      id: 1,
      rating: 5,
      title: 'オズの魔法使い',
      tags: [],
      goodArray: [],
      authors: {
        id: 58,
        book_id: 49,
        name: '三村晴子',
        is_representative: true,
        created_at: '2022-08-20T13:14:17.520Z',
        updated_at: '2022-08-20T13:14:17.520Z',
      },
      publisher: 'KADOKAWA',
      published_at: '2017-07-03',
    }
    const wrapper = shallowMount(bookDetail, {
      propsData: props,
      store,
      localVue,
    })
    expect(wrapper.props()).toEqual(props)
  })
})
