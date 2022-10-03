class MyInject {
  constructor(app) {
    this.app = app
  }
  pageTitle(routeName) {
    const jsonPath = `pages.${routeName.replace(/-/g, '.')}`
    const title = this.app.i18n.t(jsonPath)
    return typeof title === 'object' ? title.index : title
  }
  contentsLinkTo(id, name = 'contents-id-dashboard') {
    return { name, params: { id } }
  }
}

export default ({ app }, inject) => {
  inject('my', new MyInject(app))
}
