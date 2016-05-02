function get(url) {
  // Return a new promise.
  return new Promise(function(resolve, reject) {
    // Do the usual XHR stuff
    var req = new XMLHttpRequest();
    req.open('GET', url);

    req.onload = function() {
      // This is called even on 404 etc
      // so check the status
      if (req.status == 200) {
        // Resolve the promise with the response text
        resolve(req.response);
      }
      else {
        // Otherwise reject with the status text
        // which will hopefully be a meaningful error
        reject(Error(req.statusText));
      }
    };

    // Handle network errors
    req.onerror = function() {
      reject(Error("Network Error"));
    };

    // Make the request
    req.send();
  });
}

function generateSubmitUrl(arr_obj, type){
  var form = document.getElementById("form");
  var url = ""
  if (type != 'submit') {
  for (i = 0; i < form.elements.length; i++) {
    var elm = form.elements[i];
     if (typeof arr_obj == 'undefined' || arr_obj.indexOf(elm.name) > -1) {
     if ((elm.type == 'checkbox' && elm.checked) || (elm.type != 'checkbox')) {
      url += elm.id + "=" + elm.value + "&";
     }
     }
    }
  }
  url = form.action + "?" + url + 'type=' + type;
return url;
}

function get_first(url){
 get(url).then(function(response) {
     console.log("Success!", response);
     /*eraseResults('list');*/
     try { 
       var parsed_response = JSON.parse(response);
     } catch (err) {
     }
     var keys = get_keys(parsed_response['brands']);
     addToBrandNames(keys, parsed_response['brands']);
     document.getElementById('brand-count').innerHTML = parsed_response['counts'];
     
     }, function(error) {
       console.error("Failed!", error);
     });
}


var page_count = 0;

function get_more(){
  page_count += 1;
  url = window.location + ".json?page=" + page_count;
  get(url).then(function(response) {
     try { 
       var parsed_response = JSON.parse(response);
     } catch (err) {
     }
      addPhotoThroughList(parsed_response);
      }, function(error) {
      console.error("Failed!", error);
      }); 
}   

function addPhotoThroughList(obj){
obj.forEach(function(pix){
listObj.add({
  'brand-image': "<image src=\"" + pix['url'] + "\" class=\"grow\" \" />",
  'taken-at': pix['taken_at'],
  'match-quality': pix['brand_memberships'][0]['match_quality']
});
});
var ccount = document.getElementById('current_count');
ccount.innerHTML = parseInt(ccount.innerHTML) + obj.length;
var tcount = document.getElementById("total_count")
if (parseInt(tcount.innerHTML) == parseInt(ccount.innerHTML)) {
document.getElementById("getmore").classList.add("hidden");
}
}

function get_keys(h){
var keys = [];
for (var k in h)keys.push(k);
return keys;
}

//Function to clear the errors on the form & navigation
function clear_error(){
	$('#steps li').removeClass('error');
}

function eraseResults(obj){
  var myNode = document.getElementById(obj);
  while (myNode.firstChild) {
        myNode.removeChild(myNode.firstChild);
      }
}

function submitFunction(){
  url = generateSubmitUrl([],'submit');
  get_first(url);
  return false;
}

function getBrands(){
  get_first('/welcome.json?type=brands');

}

function setupNeighbors(obj){
var par = document.getElementsByClassName('neighbors')[0];
obj.forEach(function(neighbor){
var el = document.createElement("li"); 
el.style = "display: inline; padding-right: 10px";
el.innerHTML = '<a style="text-decoration: none" href="/brands/' + neighbor['id'] + '">' + neighbor['brand_name'] + '(' + neighbor['counts'] + ')</a>';
par.appendChild(el);
});
}

function setupBrand(obj){
var ccount = document.getElementById("current_count")
if (ccount.innerHTML != "") {
ccount.innerHTML = parseInt(ccount.innerHTML) + obj.length
} else {
ccount.innerHTML = obj.length
}

var tcount = document.getElementById("total_count")
if (parseInt(tcount.innerHTML) == parseInt(ccount.innerHTML)) {
document.getElementById("getmore").classList.add("hidden");
}

addPhotoToBrand(obj);
}

function addPhotoToBrand(obj){

   obj.forEach(function(pix) {
     var template = document.getElementById("brand-template").innerHTML,
         el = document.createElement('li');
         el.classList.add("li-class");

     //if(car.active_car.impression_id != undefined) {
     //  el.id = car.active_car.impression_id
     //}
     //if(car.active_car.impression_id != undefined){
     //  el.onclick = "window.open=\'//carvalues.com/click?imp_id=" +  car.active_car.impression_id + '&sid=' + car.active_car.sid + "\'";

     //}else{
     //  el.onclick = "window.location=\'//carvalues.com/click?imp_id=" +  car.active_car.impression_id + '&sid=' + car.active_car.sid + "\'";
     //}

       el.innerHTML = template;

       el.getElementsByClassName("taken-at")[0].innerHTML += pix['taken_at'];
       el.getElementsByClassName("match-quality")[0].innerHTML += pix['brand_memberships'][0]['match_quality'];
       el.getElementsByClassName("favorited")[0].innerHTML += pix['favorited']['favorited'];
       //el.getElementsByClassName("brand-image")[0].innerHTML +=  obj[name]['counts'];
       //el.getElementsByTagName("a")[0].href = "/brands/" + obj[name]['id'];
       el.getElementsByClassName("brand-image")[0].title = 'Taken At: ' + pix['taken_at'] + '\n' + 'Match Quality: ' + pix['brand_memberships'][0]['match_quality'] + '\n' + 'Instagram Favorites: ' + pix['favorited']['favorited']; 
       el.getElementsByClassName("brand-image")[0].innerHTML +=  "<image src=\"" + pix['url'] + "\"  class=\"grow\"  \" />";

       document.getElementById("list").appendChild(el);
   });
}

function addToBrandNames(names, obj){

   names.forEach(function(name) {
     var template = document.getElementById("brands-template").innerHTML,
         el = document.createElement('tr');
         el.onclick = "getBrand(this);";

     //if(car.active_car.impression_id != undefined) {
     //  el.id = car.active_car.impression_id
     //}
     //if(car.active_car.impression_id != undefined){
     //  el.onclick = "window.open=\'//carvalues.com/click?imp_id=" +  car.active_car.impression_id + '&sid=' + car.active_car.sid + "\'";

     //}else{
     //  el.onclick = "window.location=\'//carvalues.com/click?imp_id=" +  car.active_car.impression_id + '&sid=' + car.active_car.sid + "\'";
     //}

       el.innerHTML = template;

       el.getElementsByClassName("brandname")[0].innerHTML += name;
       el.getElementsByClassName("brandcounts")[0].innerHTML +=  obj[name]['counts'];
       el.getElementsByTagName("a")[0].href = "/brands/" + obj[name]['id'];
       //el.getElementsByClassName("brand-link")[0].innerHTML +=  "<image src=\"http://images.motovy.com/carimage/53684744/thumb/0.jpg\"  style=\"position:relative; min-width:auto; height:auto;  \" />";

       document.getElementsByClassName("list")[0].appendChild(el);
   });
}

var direction = "none";

function sort_children(sortby, numeric){
  var list = document.getElementsByClassName('list')[0];

  var items = list.childNodes; 
  var itemsArr = [];           
  for (var i in items) {       
    if (items[i].nodeType == 1) { // get rid of the whitespace text nodes
      itemsArr.push(items[i]); 
    }
  }
  
  if (direction == "none" || direction == "desc"){
  direction = "asc";
  front = 1;
  back = -1;
  } else {
  direction = "desc";
  front = -1;
  back = 1;
  }

  if (numeric == true) {
  itemsArr.sort(function(a, b) {  
    return +a.getElementsByClassName(sortby)[0].innerHTML == +b.getElementsByClassName(sortby)[0].innerHTML
    ? 0
    : (+a.getElementsByClassName(sortby)[0].innerHTML > +b.getElementsByClassName(sortby)[0].innerHTML ? front : back);
  });
} else {
  itemsArr.sort(function(a, b) {  
    return a.getElementsByClassName(sortby)[0].innerHTML == b.getElementsByClassName(sortby)[0].innerHTML
    ? 0
    : (a.getElementsByClassName(sortby)[0].innerHTML > b.getElementsByClassName(sortby)[0].innerHTML ? front : back);
  });
}

  for (i = 0; i < itemsArr.length; ++i) {
    list.appendChild(itemsArr[i]);  
  }
}


