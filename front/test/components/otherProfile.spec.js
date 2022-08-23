import { createLocalVue, shallowMount } from '@vue/test-utils'
import Vuex from 'vuex'
import myProfile from '~/components/profile/myProfile'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('myProfile.vue', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store({
      state: {
        current: {
          user: {
            id: 2,
            following: [],
            followers: []
          }
        }
      }
    })
  })
  it('Display text', () => {
    const props = {
      name: 'admin',
      profile: 'サンプルユーザーです',
      age: 1,
      locate: '北海道',
      following: [
        {
          "id": 11,
          "provider": "email",
          "allow_password_change": false,
          "name": "sample4",
          "image": {
            "url": null,
            "thumb": {
                "url": null
              }
          },
          "profile": null,
          "age": null,
          "locate": null,
          "created_at": "2022-07-07T18:54:41.264Z",
          "updated_at": "2022-08-15T16:11:23.522Z"
        }
      ],
      followers: [
        {
          "id": 8,
          "provider": "email",
          "allow_password_change": false,
          "name": "sample1",
          "image": {
            "url": "/uploads/user/image/8/vertical-portrait-display-wallpaper-preview.jpg",
            "thumb": {
                "url": "/uploads/user/image/8/thumb_vertical-portrait-display-wallpaper-preview.jpg"
            }
          },
          "profile": "サンプルユーザーです",
          "age": "1",
          "locate": "福井県",
          "created_at": "2022-07-07T18:52:48.413Z",
          "updated_at": "2022-08-15T16:26:09.865Z"
        },
        {
          "id": 15,
          "provider": "email",
          "allow_password_change": false,
          "name": "sample8",
          "image": {
            "url": null,
            "thumb": {
              "url": null
            }
          },
          "profile": null,
          "age": null,
          "locate": null,
          "created_at": "2022-07-07T18:57:36.656Z",
          "updated_at": "2022-07-28T14:05:57.378Z"
        },
      ],
      image: '/uploads/user/image/1/ph_thumb.jpg',
      good: [
        {
          "id": 42,
          "user_id": 1,
          "books_shelf_id": 67,
          "created_at": "2022-08-21T14:05:37.871Z",
          "updated_at": "2022-08-21T14:05:37.871Z"
        }
      ],
      review: '1'
    }
    const wrapper = shallowMount(myProfile, {
      propsData: props,
      store,
      localVue
    })
    expect(wrapper.props()).toEqual(props)
  })
})