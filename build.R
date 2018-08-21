#! /usr/bin/env Rscript

# Check for data
if (!file.exists("data/qm_survey_ss2018_r.rds")) {
  download.file("https://data.tadaa-data.de/qm_survey_ss2018.rds",
                destfile = "data/qm_survey_ss2018_r.rds")
}

cat("\nRendering presentation...\n\n")
rmarkdown::render(input         = "presentation.Rmd",
                  output_format = "revealjs::revealjs_presentation",
                  output_file   = "presentation.html", quiet = TRUE)

cat("Rendering single page version...\n\n")
# html_document themes
# rmarkdown::render(input         = "presentation.Rmd",
#                   output_format = "html_document",
#                   output_file   = "index.html", quiet = TRUE)

cat("\nAll done.\n")
timestamp()

library(slackr)
slackr_setup(config_file = "/opt/tadaadata/.slackr")

msg <- paste0(lubridate::now(tzone = "CET"), ": Built Prüfungstutorium SoSe 18. ",
              "Clicky: https://public.tadaa-data.de/pruefungstutorien/qm2_sose_18/presentation.html")
text_slackr(msg, channel = "#tutorium", username = "tadaabot", preformatted = FALSE)
