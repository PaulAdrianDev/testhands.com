import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  openArchetypesTable(event){
    let table = this.archetypes_table;
    if(table.style.maxHeight == "400px"){
      table.style.maxHeight = "0px";
      event.target.textContent = "+ Add Archetype";
    }
    else{
      table.style.maxHeight = "400px";
      event.target.textContent = "X Close Archetype Table";
      table.scrollTo(0,0);
    }
  }

  get archetypes_table(){
    return this.targets.find("archetypes-table");
  }
}