$(function(){
  let form = $('#movie-search');

  form.submit(function(e){
    e.preventDefault();
    $.ajax({
      url: 'http://www.omdbapi.com/?',
      data: form.serialize()
    })
    .done(function(data){
      displayMovies(data);
    });
  });

  $('#movies').on('click', 'img', function(e){
    e.preventDefault();
    if ($("#myModal").length) {
      $("#myModal").remove();
    }

    let id = $(e.target).data('id');

    $.ajax({
      url: "http://www.omdbapi.com/?",
      data: {i: id, plot: "full"}
    })
    .done(function(data){
      //  console.log(data-banana);
      displayMovie(data);

    })
  });

  function displayMovie(data){

    let htmlString = "";
    let myModalLabeldata = "";
    let imageData = "";
    imageData += `  <img width="100px" src=${data["Poster"] == "N/A" ? "assets/nopicture.gif" : data["Poster"]} />`;
    myModalLabeldata += `<center>${data["Title"]}</center>`;
//  console.log(htmlString);

  //$("#modals").append(htmlString);
  $("#myModalLabel").append(myModalLabeldata);
  $("#image").append(imageData);
  $("#myModal").modal('show');

  }

  function displayMovies(data){
    let htmlString = "";
    data["Search"].forEach(function(movie){
      htmlString += `<div class="item well">
      <a href="#aboutModal"  data-target="#myModal" data-toggle="modal"><img data-banana="Banana" data-id=${movie["imdbID"]} src=${movie["Poster"] == "N/A" ? "assets/nopicture.gif" : movie["Poster"]} /></a>
                      <p> ${movie["Title"]}</p>
                      <p> ${movie["Year"]}</p>
                      </div>`;
    });
    $("#movies").append(htmlString);
  }
})
