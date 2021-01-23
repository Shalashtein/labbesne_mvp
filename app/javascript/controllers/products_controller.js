import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "card", "name", "price", "product" ]
  connect() {
    var currentProduct = this.cardTargets[this.cardTargets.length - 1]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `USD ${currentProduct.dataset.price}`
    this.productTarget.value = currentProduct.dataset.productid
  }
  swipe() {
    var currentProduct = this.cardTargets[this.cardTargets.length - 1]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `USD ${currentProduct.dataset.price}`
    this.productTarget.value = currentProduct.dataset.productid
  }
}
