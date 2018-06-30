
# Coursera's "Getting and Cleaning Data" course project

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis (and not to perform analysis itself).

## Background

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 

## Data set

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

 * [Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
 * [Data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Contents

This project is composed of 3 core files:

 * This README
 * `run_analysis.R`, an R script used to download, extract and transform the data set
 * A CodeBook, describing the operations performed on the data set

## Getting started

 * Clone this repository
 * If you wish to perform the analysis in a particular directory, update `run_analysis.R`'s init function (more details are provided in the script's header)
 * Run `run_analysis.R`

## Dependencies

The analysis was performed with the following specifications:
 * R - base: 3.5.0
 * R - data.table: 1.11.4
 * R - dplyr: 0.7.5

It's not to say it won't work with a different configuration but do keep this in mind.
