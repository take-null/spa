import { mount } from '@vue/test-utils'
import userFormPassword from '~/components/user/userFormPassword'

describe('userFormPassword.vue', () => {
  test('Display text', () => {
    const props = {
      password: 'samplepassword',
      noValidation: true
    }
    const wrapper = mount(userFormPassword, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})