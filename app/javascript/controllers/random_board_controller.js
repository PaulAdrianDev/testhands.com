import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  open() {
    alert(this.tier);
  }

  get tier(){
    return this.targets.find("tier").value;
  }
}
