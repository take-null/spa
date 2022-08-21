import { mount } from '@vue/test-utils'
import userFormLocate from '~/components/user/userFormLocate'

describe('userFormLocate.vue', () => {
  test('Display text', () => {
    const props = {
      locate: '北海道'
    }
    const wrapper = mount(userFormLocate, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})