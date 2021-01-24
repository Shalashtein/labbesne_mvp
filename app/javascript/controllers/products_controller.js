import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "card", "name", "price" ]
  connect() {
    var currentProduct = $('#products-swipe-card-stack li:last-child')[0]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `LBP ${currentProduct.dataset.price}`
  }
  swipe() {
    var currentProduct = $('#products-swipe-card-stack li:last-child')[0]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `LBP ${currentProduct.dataset.price}`
  }
}
