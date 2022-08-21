import { mount } from '@vue/test-utils'
import userFormName from '~/components/user/userFormName'

describe('userFormName.vue', () => {
  test('Display text', () => {
    const props = {
      name: 'admin'
    }
    const wrapper = mount(userFormName, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})