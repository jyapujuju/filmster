// document.getElementById("myFrame").onload = function() {myFunction()};

$(function(){
  let form = $('#movie-search');

  form.submit(function(e){
    e.preventDefault();
    $.ajax({
      url: 'http://www.omdbapi.com/?',
      data: form.serialize()
    })
    .done(function(data){
      $("#intro").remove();
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
      data: {i: id, plot: "full",tomatoes: "true"}
    })
    .done(function(data){
       console.log(data);
      displayMovie(data);

    })
  });

  function displayMovie(data){
    let htmlString = "";
    htmlString += `<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title" id="myModalLabel"><center></center></h4>
                </div>

                <div class="modal-body">
                  <center><h3 class="media-heading"> ${data["Title"]}</h3></center>

                  <div class="col-md-3">
                    <img width="100px" src=${data["Poster"] == "N/A" ? "assets/nopicture.gif" : data["Poster"]} />
                  </div>

                <div class="col-md-9">
                  <div class="col-md-2">
                    <span style>Year: </span>
                    <span style>Year: </span>
                    <span style>Year: </span>
                    <span style>Year: </span>
                  </div>
                  <div class="col-md-10">
                    <span class="label label-info">${data["Year"]}</span><br>
                    <span class="label label-info">${data["imdbID"]}</span><br>
                    <span class="label label-info">${data["tomatoRotten"]}</span><br>
                    <span class="label label-info">${data["Awards"]}</span><br>
                    <span class="label label-info">${data["Director"]}</span><br>
                    <span class="label label-info">${data["Runtime"]}</span><br>
                    <span class="label label-info">${data["imdbRating"]}</span><br>
                    <span class="label label-info">${data["Genre"]}</span><br>
                    <span class="label label-info">${data["Rated"]}</span><br>
                  </div>
                  </div>
                  <div>
                    <hr>
                    <center>
                    <p class="text-left"><strong>Bio: </strong><br>
                    ${data["Plot"]};
                    </center>
                  </div>
                  <form id="rating-form" action="/reviews" method="POST">
                  <input type="hidden" name="authenticity_token" value=${window._token} />
                  <input type="hidden" name="imdbid" value=${data["imdbID"]} />
                  <textarea name="review[comment]" class="form-control" placeholder="your review goes here...." />
                  <br />
                  <input type="submit" class="btn btn-success" />
                  </form>

                <div class="modal-footer">
                    <center>
                    <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                    </center>
                </div>
            </div>
        </div>`;
//  console.log(htmlString);

  $("#modals").append(htmlString);
  // $("#myModalLabel").append(myModalLabeldata);
  // $("#image").append(imageData);
  $("#myModal").modal('show');

  }

  function displayMovies(data){
    $("#movies").empty();
    let htmlString = "";
    data["Search"].forEach(function(movie){
      htmlString += `<div class="item well">
       <a href="#" data-toggle="modal" data-target="#myModal"><img data-id=${movie["imdbID"]} src=${movie["Poster"] == "N/A" ? "assets/nopicture.gif" : movie["Poster"]} /></a>
                      <p> ${movie["Title"]}</p>
                      <p> ${movie["Year"]}</p>
                      </div>`;
    });
    $("#movies").append(htmlString);
  }
})
