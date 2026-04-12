import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bulk-booking"
export default class extends Controller {
  static targets = ["checkbox", "floatingBar", "countLabel"]

  connect() {
    this.updateUI()
  }

  toggle() {
    this.updateUI()
  }

  updateUI() {
    const selectedCount = this.checkboxTargets.filter(checkbox => checkbox.checked).length
    
    if (selectedCount > 0) {
      this.floatingBarTarget.classList.remove("translate-y-32", "opacity-0")
      this.floatingBarTarget.classList.add("translate-y-0", "opacity-100")
      this.countLabelTarget.textContent = selectedCount
    } else {
      this.floatingBarTarget.classList.add("translate-y-32", "opacity-0")
      this.floatingBarTarget.classList.remove("translate-y-0", "opacity-100")
    }
  }

  // 「すべて選択」ボタンなどがあればここに実装可能
}
