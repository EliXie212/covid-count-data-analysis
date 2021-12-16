.PHONY: clean
# SHELL: /bin/bash

### Clean existing datasets, figures or reports generated in this Makefile for builing
clean:
	rm -f derived_data/*.csv
	rm -f figures/*.png
	rm -f covid_data_analysis_report.pdf
	rm -f derived_docs/*
	rm -f derived_objects/*

### Report Generation
covid_data_analysis_report.pdf:\
covid_data_analysis_report.tex\
figures/eda.png\
figures/eda_ratio.png\
figures/eda_log.png\
figures/eda_diff2.png\
figures/eda_diff2_ratio.png\
figures/eda_diff2_acf.png\
figures/eda_diff2_ratio_acf.png\
figures/eda_diff2_pacf.png\
figures/eda_diff2_ratio_pacf.png\
figures/model1_s.png\
figures/model1_pacf.png\
figures/model1_acf_c.png\
figures/model1_pacf_c.png\
figures/eda_35.png\
figures/model2_s.png\
figures/model2_pacf.png\
figures/model2_acf_c.png\
figures/model2_pacf_c.png\
figures/model3_s.png\
figures/model3_pacf.png\
figures/model3_acf_c.png\
figures/model3_pacf_c.png\
figures/eda_35_ratio.png\
figures/model4_s.png\
figures/model4_pacf.png\
figures/model4_acf_c.png\
figures/model4_pacf_c.png\
figures/final_pred_r.png\
figures/final_pred.png
	pdflatex covid_data_analysis_report.tex

### Data Requirements
## Generate figures for EDA
figures/eda.png\
figures/eda_ratio.png\
figures/eda_log.png\
figures/eda_diff2.png\
figures/eda_diff2_ratio.png\
figures/eda_diff2_acf.png\
figures/eda_diff2_ratio_acf.png\
figures/eda_diff2_pacf.png\
figures/eda_diff2_ratio_pacf.png:\
eda_plot_gen.R\
source_data/covid.csv
	Rscript eda_plot_gen.R

## Generate figures for model1
figures/model1_s.png\
figures/model1_pacf.png\
figures/model1_acf_c.png\
figures/model1_pacf_c.png:\
model1_fit_plot_gen.R\
source_data/covid.csv
	Rscript model1_fit_plot_gen.R

## Generate figures for model2
figures/eda_35.png\
figures/model2_s.png\
figures/model2_pacf.png\
figures/model2_acf_c.png\
figures/model2_pacf_c.png:\
model2_fit_plot_gen.R\
source_data/covid.csv
	Rscript model2_fit_plot_gen.R


## Generate figures for model3
figures/model3_s.png\
figures/model3_pacf.png\
figures/model3_acf_c.png\
figures/model3_pacf_c.png:\
model3_fit_plot_gen.R\
source_data/covid.csv
	Rscript model3_fit_plot_gen.R


## Generate figures for model4
figures/eda_35_ratio.png\
figures/model4_s.png\
figures/model4_pacf.png\
figures/model4_acf_c.png\
figures/model4_pacf_c.png:\
model4_fit_plot_gen.R\
source_data/covid.csv
	Rscript model4_fit_plot_gen.R


## Generate figures for final model
figures/final_pred_r.png\
figures/final_pred.png:\
final_model_fit_plot_gen.R\
source_data/covid.csv
	Rscript final_model_fit_plot_gen.R


source_data/covid.csv:
	mkdir -p source_data
	mkdir -p figures
	mkdir -p derived_data
	mkdir -p derived_docs
	mkdir -p derived_objects
	[ -f covid.csv ] && mv covid.csv source_data/covid.csv
