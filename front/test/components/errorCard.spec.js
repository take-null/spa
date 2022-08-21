import { mount } from '@vue/test-utils'
import errorCard from '~/components/errorCard'

describe('errorCard.vue', () => {
  test('Display text', () => {
    const props = {
      display: true,
      title: 'title',
      message: 'message'
    }
    const wrapper = mount(errorCard, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})