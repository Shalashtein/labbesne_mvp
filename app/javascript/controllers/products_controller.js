import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "card", "name", "price" ]
  connect() {
    var currentProduct = $('#products-swipe-card-stack li:last-child')[0]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `LBP ${currentProduct.dataset.price}`
    $('#variant_id').val(currentProduct.dataset.variant)
  }
  swipe() {
    var currentProduct = $('#products-swipe-card-stack li:last-child')[0]
    this.nameTarget.innerHTML = currentProduct.dataset.name
    this.priceTarget.innerHTML = `LBP ${currentProduct.dataset.price}`
    $('#variant_id').val(currentProduct.dataset.variant)
  }
}
