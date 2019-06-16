# Rocky Mountain Genomics Hackcon Workshop 2019

An introduction to tools for reproducible analysis pipelines.

## Prerequisites
- a terminal/ssh client ([Git Bash](https://gitforwindows.org/) for windows; terminal macOS (already installed on macOS!))
- a GitHub account

## Connect to your Google Cloud Compute Instance
We will be giving everyone a Google Compute Engine instance to work with during the workshop.  IPs will be announced at the beginning of the workshop, and any SSH keys associated with your GitHub account will allow you to login!

We login using secure shell, a protocol for connecting to remote servers `ssh yourGitHubUsername@yourcloudIP`


## Copy the data that we'll be using during the workshop
We setup an external mount for everyone to pull data from (mounted at /data).  The first thing you'll need to do is get a copy of this data to work with.  To keep things tidy, we'll make a new folder to put it in, first. *Note, the ~ is a shortcut for our home directory on unix-like systems*
1. First, ensure you're in your home directory: `cd ~`
2. Then, make a new directory called workshop to put the data in: `mkdir workshop`
3. Lastly, copy the data from the mount: `cp -pr /data/* ~/workshop`

## Set up your git repository

Fork this repository so you have your own copy

Clone your new repository on the google cloud instance
```bash
git clone https://github.com/YOURUSERNAME/rmghc-workshop-19.git
```


## Edit files two ways

Use your file manager to edit a file on your compute instance on your local machine.

Use nano or vim on the command line to edit the same file. 

Commit your changes and push to GitHub

## Interact with singularity

Let's inspect the singularity container. What software is loaded on it?

*Run something on singularity with singularity exec*

## Run the RNA-seq analysis pipeline with nextflow

```bash
nextflow run main.nf \
  -resume \
  -with-report nextflow_report.html \
  -with-dag flowchart.html
```

## View the pipeline reports in your browser

## Add a process to run the differential expression RScript

## View the results of the RMarkdown script
