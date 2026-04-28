import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "message", "confirmButton", "cancelButton"]

  connect() {
    const turbo = window.Turbo || Turbo
    if (!turbo) return

    // Turbo の確認ダイアログをこのコントローラーのメソッドに置き換える
    turbo.setConfirmMethod((message, element) => {
      let confirmButtonText = element.dataset.turboConfirmButton || "OK"
      let cancelButtonText = element.dataset.turboCancelButton || "Cancel"
      
      return this.showModal(message, confirmButtonText, cancelButtonText)
    })
  }

  showModal(message, confirmButtonText, cancelButtonText) {
    this.messageTarget.textContent = message
    this.confirmButtonTarget.textContent = confirmButtonText
    this.cancelButtonTarget.textContent = cancelButtonText
    
    // 表示開始
    this.containerTarget.classList.remove("hidden")
    this.containerTarget.classList.add("flex")
    
    // アニメーション用の微小な遅延
    requestAnimationFrame(() => {
      this.containerTarget.firstElementChild.classList.add("opacity-100")
      this.containerTarget.lastElementChild.classList.add("opacity-100", "scale-100")
      this.containerTarget.lastElementChild.classList.remove("opacity-0", "scale-95")
    })
    
    document.body.classList.add("overflow-hidden")

    return new Promise((resolve) => {
      this.resolve = resolve
    })
  }

  confirm() {
    this.closeModal(true)
  }

  cancel() {
    this.closeModal(false)
  }

  closeModal(result) {
    // 閉じるアニメーション
    this.containerTarget.firstElementChild.classList.remove("opacity-100")
    this.containerTarget.lastElementChild.classList.remove("opacity-100", "scale-100")
    this.containerTarget.lastElementChild.classList.add("opacity-0", "scale-95")
    
    setTimeout(() => {
      this.containerTarget.classList.add("hidden")
      this.containerTarget.classList.remove("flex")
      document.body.classList.remove("overflow-hidden")
      if (this.resolve) this.resolve(result)
    }, 300)
  }
}
