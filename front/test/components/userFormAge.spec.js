import { mount } from '@vue/test-utils'
import userFormAge from '~/components/user/userFormAge'

describe('userFormAge.vue', () => {
  test('Display text', () => {
    const props = {
      age: '1'
    }
    const wrapper = mount(userFormAge, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})