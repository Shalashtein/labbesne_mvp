import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "card", "name", "price" ]
  connect() {
    var currentProduct = this.cardTargets[this.cardTargets.length - 1]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `USD ${currentProduct.dataset.price}`
  }
  swipe() {
    var currentProduct = this.cardTargets[this.cardTargets.length - 1]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `USD ${currentProduct.dataset.price}`
    console.log `current ${currentProduct.dataset.name}`
  }
}
