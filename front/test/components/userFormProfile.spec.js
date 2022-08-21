import { mount } from '@vue/test-utils'
import userFormProfile from '~/components/user/userFormProfile'

describe('userFormProfile.vue', () => {
  test('Display text', () => {
    const props = {
      profile: 'こんにちは'
    }
    const wrapper = mount(userFormProfile, {
      propsData: props
    })
    expect(wrapper.props()).toEqual(props)
  })
})