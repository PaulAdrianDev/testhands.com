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

    this.addBoardsAndOptions(deck.boards);
  } 

  addBoardsAndOptions(boards){
    let type;
    let options = this.options;
    options.innerHTML = ""; // clear past children
    
    boards.forEach((board) =>{
      type = board.board_type.name;

      let newOption = document.createElement("input");
      newOption.type = "radio";
      newOption.id = "board" + board.id;
      newOption.value = board.id;
      newOption.name = "board_select";
      newOption.classList.add("me-2");
      newOption.style.cursor = "pointer";
      newOption.style.transform = "scale(1.3)";
      if(type == "Full Combo 1")
        newOption.checked = true;

      let newOptionLabel = document.createElement("label");
      newOptionLabel.for = newOption.id;
      newOptionLabel.textContent = board.board_type.name;

      let div = document.createElement("div");
      div.appendChild(newOption);
      div.appendChild(newOptionLabel);

      options.appendChild(div);
    });
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

  flip(){
    let outerDiv = this.targets.find("board-outer-div");

    if(outerDiv.style.transform == "scaleY(-1)")
      outerDiv.style.transform = "scaleY(1)";
    else
      outerDiv.style.transform = "scaleY(-1)";
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

  get options(){
    return this.targets.find("options");
  }

  get board(){
    return this.targets.find("board");
  }

}