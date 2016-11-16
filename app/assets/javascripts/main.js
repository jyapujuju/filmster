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
  function displayMovies(data){
    $("#movies").empty();
    let htmlString = "";

    data["Search"].forEach(function(movie){
      htmlString += `<img src=${movie["Poster"] == "N/A" ? "/images/nopicture.gif" : movie["Poster"]} />
                      <p> ${movie["Title"]}</p>
                      <p> ${movie["Year"]}</p>`;
    });
    $("#movies").append(htmlString);
  }
});
