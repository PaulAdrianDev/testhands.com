import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close(){
    let board = this.overlay;
    board.style.pointerEvents = "none";
    board.style.opacity = "0";
  }

  open(deck){
    this.showBoard();
    console.log(deck);
    this.setTitle(deck.archetypes);
    this.setBoardTypeName("Full Combo 1");
    this.setUsername(deck.user.username);
    if(deck.advice)
      this.addAdvice(deck.advice);
    else
      this.removePreviousAdvice();
  } 


  showBoard(){
    let board = this.overlay;
    board.style.pointerEvents = "all";
    board.style.opacity = "1";
  }

  setTitle(archetypes){
    let title = "";

    archetypes.forEach((archetype) => {
      title += archetype.name;
    });

    this.title.textContent = title;
  }

  setBoardTypeName(name){
    this.board_type.textContent = name;
  }

  setUsername(username){
    this.username.textContent = "- by " + username;
  }

  addAdvice(advice){
    this.advice_title.textContent = "Creator's Advice:";
    this.advice.textContent = advice;
  }

  removePreviousAdvice(){
    this.advice_title.textContent = "";
    this.advice.textContent = "";
  }

  get overlay(){
    return this.targets.find("overlay");
  }

  get title(){
    return this.targets.find("title");
  }

  get board_type(){
    return this.targets.find("board-type");
  }

  get username(){
    return this.targets.find("username");
  }

  get advice_title(){
    return this.targets.find("advice-title");
  }
  get advice(){
    return this.targets.find("advice");
  }
}