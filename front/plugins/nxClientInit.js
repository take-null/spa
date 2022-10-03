const storage = window.localStorage
export default async ({ $nxauth, $axios, store }) => {
  if ($nxauth.isAuthenticated()) {
    const who = storage.getItem('uid')
    await $axios.$get(`/api/v1/users/search?email=${who}`).then((res) => {
      //console.log(res)
      const user = res
      store
        .dispatch('getCurrentUser', user)
        .catch(() => $nxauth.removeStorage())
    })
  }
}
