import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  openArchetypesTable(){
    this.archetypes_table.style.maxHeight = "400px";
  }

  get archetypes_table(){
    return this.targets.find("archetypes-table");
  }
}