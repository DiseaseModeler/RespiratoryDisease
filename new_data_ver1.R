#rm(list = ls(all.names = TRUE))

library(openxlsx)

the_file <- "C:/Users/david/Dropbox/CCHMC/SALT/RespiratoryDisease/WEEKLY_Output_to_CCHMC_SALT/toy_Output_to_CCHMC_SALT-Weekly-LabResults_202511_v01.xlsx"
the_sheet <- "SALT-Weekly-Labs-Aggregate"
df_lab <- read.xlsx(the_file, sheet = the_sheet)

df_lab$WEEK_ENDING_DATE <- as.Date(df_lab$WEEK_ENDING_DATE, origin = "1899-12-30")
df_lab$WEEK_ENDING_DATE <- format(df_lab$WEEK_ENDING_DATE, "%m/%d/%Y")

df_lab[df_lab == "redacted"] <- NA

df_lab$TOTAL_LAB_TESTS_POSITIVE_COVID <- as.numeric(df_lab$TOTAL_LAB_TESTS_POSITIVE_COVID)
df_lab$TOTAL_LAB_TESTS_ADMINISTERED_COVID <- as.numeric(df_lab$TOTAL_LAB_TESTS_ADMINISTERED_COVID)
df_lab$TOTAL_LAB_TESTS_UNRESULTED_COVID <- as.numeric(df_lab$TOTAL_LAB_TESTS_UNRESULTED_COVID)

covid_proportion <- df_lab$TOTAL_LAB_TESTS_POSITIVE_COVID/
  (df_lab$TOTAL_LAB_TESTS_ADMINISTERED_COVID - df_lab$TOTAL_LAB_TESTS_UNRESULTED_COVID)

df_lab$TOTAL_LAB_TESTS_POSITIVE_INFLUENZA <- as.numeric(df_lab$TOTAL_LAB_TESTS_POSITIVE_INFLUENZA)
df_lab$TOTAL_LAB_TESTS_ADMINISTERED_INFLUENZA <- as.numeric(df_lab$TOTAL_LAB_TESTS_ADMINISTERED_INFLUENZA)
df_lab$TOTAL_LAB_TESTS_UNRESULTED_INFLUENZA <- as.numeric(df_lab$TOTAL_LAB_TESTS_UNRESULTED_INFLUENZA)

influenza_proportion <- df_lab$TOTAL_LAB_TESTS_POSITIVE_INFLUENZA/
  (df_lab$TOTAL_LAB_TESTS_ADMINISTERED_INFLUENZA - df_lab$TOTAL_LAB_TESTS_UNRESULTED_INFLUENZA)

the_df <- data.frame(covid_prop = covid_proportion, flu_prop=influenza_proportion, date=df_lab$WEEK_ENDING_DATE)



