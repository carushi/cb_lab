# generate index.html
#
# 1) If index.md exists, knit it.
# 2) Otherwise, generate index.html from an index file which contains the list of pages.

local({
  if(file.exists("index.md")) {
    rmarkdown::render("index.md", output_file = "index.html")
    return()
  }

  md_tmp <- tempfile(tmpdir = ".", fileext = ".md")
  on.exit(file.remove(md_tmp))

  cat('---
title: "Index"
output: html_document
---
', file = md_tmp)

  index <- jsonlite::fromJSON("index.json")
  page_list  <- sort(sprintf("* %s [%s](%s)", index$date, index$title, index$url))
  cat(paste0(page_list, collapse = "\n"),
      file = md_tmp, append = TRUE)

  rmarkdown::render(md_tmp, output_file = "index.html")
})
