# Rocky Mountain Genomics Hackcon Workshop 2019

An introduction to tools for reproducible analysis pipelines including Git, Singularity, and Nextflow.

## Prerequisites
- a terminal/ssh client - we recommend [Git Bash](https://gitforwindows.org/) for windows; terminal for macOS (terminal comes with macOS, so no installation is necessary!)
- a GitHub account, with an SSH key added from the laptop you're bringing to the workshop

## Connect to your Google Cloud Compute Instance
We will be giving everyone a Google Compute Engine instance to work with during the workshop.  IPs will be announced at the beginning of the workshop, and any SSH keys associated with your GitHub account will allow you to login!

We login using secure shell, a protocol for connecting to remote servers `ssh yourGitHubUsername@yourcloudIP`


## Copy the data that we'll be using during the workshop
We setup an external mount for everyone to pull data from (mounted at /data).  The first thing you'll need to do is get a copy of this data to work with.  To keep things tidy, we'll make a new folder to put it in, first. *Note: the ~ is a shortcut for your home directory on unix-like systems*
1. First, ensure you're in your home directory: `cd ~`
2. Then, make a new directory called workshop to put the data in: `mkdir workshop`
3. Lastly, copy the data from the mount: `cp -pr /data/* ~/workshop`

## Set up your git repository

Fork this repository so you have your own copy

Clone your new repository on the google cloud instance
```bash
git clone https://github.com/YOURUSERNAME/rmghc-workshop-19.git
```


## Editing files
We've set the default editor in the compute instances to nano, so if you type something like `git commit` without specifying a commit message on the command line, nano will open.  We find that this has a smaller learning curve.  We aren't doing much editing anyhow, but you can use whatever method you like for editing files.  If you're comfortable with vim, it's available also.  If you know how to rsync/scp files to and from your laptop and you want to sync changes that way and locally edit, that's fine!  

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
The cloud instances supplied for the workshop have a web server that's already up and running, so we don't have to waste time copying files between the cloud instance and our laptops to view them!  Simply copy any pertinent HTML files you want to view to /srv/http and then type http://yourip into your web browser on your laptop!  

## Add a process to run the differential expression RScript

## View the results of the RMarkdown script
