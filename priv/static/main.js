document.body.onclick = addElement;
function addElement() {
    var currentElement = document.getElementById("formBtn");
    var newNameInput = document.createElement("input").setAttribute("type", "text").placeholder = "Enter name here!!!";
    document.body.insertBefore(newNameInput, currentElement);
}