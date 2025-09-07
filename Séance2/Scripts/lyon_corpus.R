# Build a corpus focused on Lyon in ProQuest 


library(histtext)
library(tidyverse)

list_corpora()


lyon1 <- search_documents('"lyon"', corpus="proquest") # 7117
lyon2 <- search_documents('"lyons"', corpus="proquest") # 27,173

lyon2 %>% group_by(Source) %>% count(sort = TRUE)

lyon2_scmp <- lyon2 %>% filter(Source == "South China Morning Post Ltd.") # 15,271
lyon2_no_scmp <- lyon2 %>% filter(!Source == "South China Morning Post Ltd.") ## 11,902

lyon_all <- search_documents('"lyon"|"lyons"', corpus="proquest") # 33,685 results


lyon1_meta <- get_search_fields_content(lyon1, corpus="proquest", 
                                        search_fields=c(list_search_fields("proquest"),
                                                        list_filter_fields("proquest"))) 

lyon1_concordance <- search_concordance('"lyon"', corpus="proquest", context_size = 100) # 8784
lyon2_concordance <- search_concordance('"lyons"', corpus="proquest", context_size = 100) # 


# there are many false positive (people who are named Lyon) 

# to remove false positive, we extract named entities and we filter articles in which lyon or Lyons is recognized as a named entity

lyon_ner1 <- ner_on_corpus(lyon1, "proquest", only_precomputed = TRUE)

lyon_ner1 %>% group_by(Type) %>% count(sort = TRUE)

## filter place names (location and GPE entity types) 

lyon_ner1_place <- lyon_ner1 %>% filter(Type %in% c("LOC", "GPE"))

## filter lyon in place names using fuzzy matching

lyon_ner1_place_filtered <- lyon_ner1_place %>%
  filter(str_detect(Text, regex("lyon", ignore_case = TRUE))) # 2257

## filter lyon in place names without using fuzzy matching but not strict matching 

filtered1 <- lyon_ner1_place %>%
  filter(str_detect(Text, regex("(?<![a-zA-Z])lyon(?![a-zA-Z])", ignore_case = TRUE)))

# unique articles 

filtered1_unique <- filtered1 %>% distinct(DocId) # 1575 articles

# Lyons, all papers except SMCP 

lyon2_no_scmp_ner <- ner_on_corpus(lyon2_no_scmp, "proquest", only_precomputed = TRUE)

## filter place names (location and GPE entity types) 

lyon2_no_scmp_place <- lyon2_no_scmp_ner %>% filter(Type %in% c("LOC", "GPE")) 

## filter lyons in place names using fuzzy matching

lyon2_no_scmp_place_filtered <- lyon2_no_scmp_place %>%
  filter(str_detect(Text, regex("lyons", ignore_case = TRUE))) # 10355

## filter lyons in place names without using fuzzy matching but not strict matching 

filtered2 <- lyon2_no_scmp_place %>%
  filter(str_detect(Text, regex("(?<![a-zA-Z])lyons(?![a-zA-Z])", ignore_case = TRUE))) 

filtered2_unique <- filtered2 %>% distinct(DocId) # 7538

# Lyons, SMCP only 

lyon2_scmp_ner <- ner_on_corpus(lyon2_scmp, "proquest", only_precomputed = TRUE)

## filter place names (location and GPE entity types) 

lyon2_scmp_place <- lyon2_scmp_ner %>% filter(Type %in% c("LOC", "GPE")) 

## filter lyons in place names using fuzzy matching

lyon2_scmp_place_filtered <- lyon2_scmp_place %>%
  filter(str_detect(Text, regex("lyons", ignore_case = TRUE))) # 12634

## filter lyons in place names without using fuzzy matching but not strict matching 

filtered3 <- lyon2_scmp_place %>%
  filter(str_detect(Text, regex("(?<![a-zA-Z])lyons(?![a-zA-Z])", ignore_case = TRUE))) # 12,621

filtered3_unique <- filtered3 %>% distinct(DocId) # 10,203

# unique id 

lyon_corpus_id <- bind_rows(filtered1_unique, filtered2_unique)
lyon_corpus_id <- bind_rows(lyon_corpus_id, filtered3_unique)
lyon_corpus_id <- lyon_corpus_id %>% distinct(DocId)