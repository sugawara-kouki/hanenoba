import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  open(event) {
    event.preventDefault()
    this.containerTarget.classList.remove("hidden")
    this.containerTarget.classList.add("flex")
    document.body.classList.add("overflow-hidden") // スクロール禁止
  }

  close(event) {
    if (event) event.preventDefault()
    this.containerTarget.classList.add("hidden")
    this.containerTarget.classList.remove("flex")
    document.body.classList.remove("overflow-hidden")
  }

  // 背景クリックで閉じる用
  closeBackground(event) {
    if (event.target === this.containerTarget) {
      this.close()
    }
  }

  // ESCキーで閉じる用（キーダウンイベントに紐付け）
  closeWithEsc(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }
}
