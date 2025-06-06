/**
 * 
 */
function swap() {
    var x = document.getElementsByClassName("name1")[0];
    var y = document.getElementsByClassName("name2")[0];
    var temp = x.value;
    x.value = y.value;
    y.value = temp;
}
function no(){
    var x = document.getElementsByClassName("name1")[0];
    var y = document.getElementsByClassName("name2")[0];
    if(x.value==y.value){
        alert("Source and destination cannot be same");
        y.value="";
    }
}

