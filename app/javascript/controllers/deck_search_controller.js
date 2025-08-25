import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    window.decks_table = this.decks_table;
    console.log(decks_table);
  }
  
  search_decks(){
    let query = this.query
    
    for(let i = 0; i < decks_table.children.length; i++){
      let deck = decks_table.children[i];
      let search_target = deck;
      if(deck.firstChild)
        search_target = deck.querySelector(".search_target");
      
      console.log(search_target.innerHTML.toLowerCase().includes(query.toLowerCase()));
      console.log(search_target.innerHTML.toLowerCase());
      console.log(query.toLowerCase()); 
      if(search_target.innerHTML.toLowerCase().includes(query.toLowerCase()))
        deck.style.display = "inline-block";
      else
        deck.style.display = "none";
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
