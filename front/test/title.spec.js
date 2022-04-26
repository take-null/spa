import { mount } from '@vue/test-utils'
import Hello from '@/pages/index'

describe('open Sesame', () => {
  test('display open Sesame', () => {
    const wrapper = mount(Hello)
    expect(wrapper.text()).toBe("hello")
  })
})