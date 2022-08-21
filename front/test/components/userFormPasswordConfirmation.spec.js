import { mount } from '@vue/test-utils'
import userFrormPasswordConfirmation from '~/components/user/userFrormPasswordConfirmation'

describe('userFrormPasswordConfirmation.vue', () => {
  test('Display text', () => {
    const props = {
      password_confirmation: 'samplepassword',
      noValidation: true
    }
    const wrapper = mount(userFrormPasswordConfirmation, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})