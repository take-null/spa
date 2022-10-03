import { mount } from '@vue/test-utils'
import bookRank from '~/components/books/bookRank'

describe('bookRank.vue', () => {
  test('Display text', () => {
    const props = {
      image:
        'http://books.google.com/books/content?id=crdI253WP…=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',
      rank: '1位',
      google_books_api_id: 'gkrYzAEACAAJ',
    }
    const wrapper = mount(bookRank, {
      propsData: props,
    })
    expect(wrapper.props()).toEqual(props)
  })
})
