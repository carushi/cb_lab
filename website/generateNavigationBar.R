# generate before_body.html

local({
  before_body <- "include/before_body.html"

  cat('
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="./index.html">Title</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li><a href="./index.html">Home</a></li>
        <li><a href="https://github.com/yutannihilation/rmarkdown-website-template">Github</a></li>
        <li class="dropdown">
          <a href="authoring" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Pages<span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">', file = before_body)

  index <- jsonlite::fromJSON("index.json")
  page_list  <- sort(sprintf('          <li><a href="%s">%s</a></li>', index$url, index$title))
  cat(paste0(page_list, collapse = "\n"),
      file = before_body, append = TRUE)

  cat('
          </ul>
        </li>
      </ul>
    </div><!--/.nav-collapse -->
  </div><!--/.container -->
</div><!--/.navbar -->
', file = before_body, append = TRUE)
})
