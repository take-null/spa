import { mount } from '@vue/test-utils'
import bookCard from '~/components/books/bookCard'

describe('bookCard.vue', () => {
  test('Display text', () => {
    const props = {
      publisher: 'KADOKAWA',
      title: 'オズの魔法使い',
      authors: 'ライマン・フランク・ボーム',
      published_at: '2017-07-03',
      image:
        'http://books.google.com/books/content?id=crdI253WP…=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',
    }
    const wrapper = mount(bookCard, {
      propsData: props,
    })
    expect(wrapper.props()).toEqual(props)
  })
})
