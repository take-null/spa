const storage = window.localStorage
export default async ({ $nxauth, $axios, store }) => {
  if ($nxauth.isAuthenticated()) {
    const who = storage.getItem('id')
    await $axios.$get(`/api/v1/users/${who}`)
    .then((res) => {
      const user = res
      store.dispatch('getCurrentUser', user)
      .catch(() => $nxauth.removeStorage())}
    )
  }
}