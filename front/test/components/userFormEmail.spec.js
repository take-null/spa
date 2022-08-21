import { mount } from '@vue/test-utils'
import userFormEmail from '~/components/user/userFormEmail'

describe('userFormEmail.vue', () => {
  test('Display text', () => {
    const props = {
      email: 'admin@email.com',
      noValidation: true
    }
    const wrapper = mount(userFormEmail, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})