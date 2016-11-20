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
    htmlString += `<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title" id="myModalLabel"><center>${data["Title"]}</center></h4>
                    </div>
                <div class="modal-body">
                    <center>
                    <img width="100px" src=${data["Poster"] == "N/A" ? "assets/nopicture.gif" : data["Poster"]} />
                    <h3 class="media-heading">Joe Sixpack <small>USA</small></h3>
                    <span><strong>Skills: </strong></span>
                        <span class="label label-warning">HTML5/CSS</span>
                        <span class="label label-info">Adobe CS 5.5</span>
                        <span class="label label-info">Microsoft Office</span>
                        <span class="label label-success">Windows XP, Vista, 7</span>
                    </center>
                    <hr>
                    <center>
                    <p class="text-left"><strong>Bio: </strong><br>
                    ${data["Plot"]};
                    </center>
                </div>
                <div class="modal-footer">
                    <center>
                    <button type="button" class="btn btn-default" data-dismiss="modal">I've heard enough about Joe</button>
                    </center>
                </div>
            </div>
        </div>
    </div>


                    <p> </p>
                    <p> ${data["Year"]}</p>`;
  console.log(htmlString);

  $("#modals").append(htmlString);
  $("#myModal").modal('show');

  }

  function displayMovies(data){
    let htmlString = "";
    data["Search"].forEach(function(movie){
      htmlString += `<a href="#aboutModal"  data-target="#myModal" data-toggle="modal"><img data-banana="Banana" data-id=${movie["imdbID"]} src=${movie["Poster"] == "N/A" ? "assets/nopicture.gif" : movie["Poster"]} /></a>
                      <p> ${movie["Title"]}</p>
                      <p> ${movie["Year"]}</p>`;
    });
    $("#movies").append(htmlString);
  }
})
