
HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd)) \
              $(patsubst %.md, %.html ,$(wildcard *.md))

CACHE_DIRS := $(patsubst %.Rmd, %_cache ,$(wildcard *.Rmd))

FIGURE_DIR := figures/

all: index generateNavigationBar html generateIndexPage

html: $(HTML_FILES)

%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<', encoding = 'UTF-8')"

%.html: %.md
	R --slave -e "set.seed(100);rmarkdown::render('$<', encoding = 'UTF-8')"

.PHONY: clean index generateNavigationBar generateIndexPage
clean:
	$(RM) $(HTML_FILES) index.html
	$(RM) -r $(CACHE_DIRS) $(FIGURE_DIR)

index:
	Rscript index.R

generateNavigationBar:
	Rscript generateNavigationBar.R

generateIndexPage:
	Rscript generateIndexPage.R

