import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    window.decks_table = this.decks_table;
  }
  
  search_decks(){
    let query = this.query

    for(let i = 0; i < decks_table.children.length; i++){
      let deck = decks_table.children[i];

      if(!deck.innerHTML.toLowerCase().includes(query))
        deck.style.display = "none";
      else
        deck.style.display = "inline-block";
    }
  }

  open(event){
    alert(event.currentTarget.value);
  }

  get query() {
    return this.targets.find("query").value;
  }

  get decks_table() {
    return this.targets.find("decks_table");
  }
}
