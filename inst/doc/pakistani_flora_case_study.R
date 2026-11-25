## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(taxaudit)

corpus <- ta_load_corpus()
head(corpus)

## -----------------------------------------------------------------------------
# Extract traits from the first treatment
sample_text <- corpus$text[1]
extracted_results <- ta_extract_traits(sample_text)
print(extracted_results)

## -----------------------------------------------------------------------------
annotator_1 <- data.frame(
  trait = extracted_results$trait,
  span_start = extracted_results$span_start,
  span_end = extracted_results$span_end,
  stringsAsFactors = FALSE
)

# Simulated second annotator with slightly shifted span bounds
annotator_2 <- data.frame(
  trait = extracted_results$trait,
  span_start = extracted_results$span_start + 2,
  span_end = extracted_results$span_end + 1,
  stringsAsFactors = FALSE
)

agreement <- ta_audit_agreement(annotator_1, annotator_2)
print(agreement)

## -----------------------------------------------------------------------------
eval_split <- ta_split_evaluation(corpus, holdout_type = "taxon", target_holdout = "Cedrus deodara")
cat("Training set size:", nrow(eval_split$train), "\n")
cat("Test set size (held-out taxon):", nrow(eval_split$test), "\n")

