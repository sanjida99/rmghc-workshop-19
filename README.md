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

1. Fork this repository so you have your own copy.  You can fork the repository by clicking on the 'fork' button in the top right of the base page for the repository on GitHub.
2. Ensure you're in your home directory: `cd ~`
3. Clone your new repository on the Google cloud instance: `git clone https://github.com/YOURUSERNAME/rmghc-workshop-19.git` *Note: We're using https cloning so we don't have to generate and add ssh keys from the cloud instance*
4. When you type `ls`, you should see a folder named for the repository


## Editing files
We've set the default editor in the compute instances to nano, so if you type something like `git commit` without specifying a commit message on the command line, nano will open.  We find that this has a smaller learning curve.  We aren't doing much editing anyhow, but you can use whatever method you like for editing files.  If you're comfortable with vim, it's available also.  If you know how to rsync/scp files to and from your laptop and you want to sync changes that way and locally edit, that's fine!  

## Interact with Singularity

First let's take a look a what the basic options of Singularity are for

```bash
$ singularity --help
```

Here you will see several of the commands we are going to use today: "run", "exec", "build", and "inspect"

Build a local image directly from a remote repository.

```bash
$ cd ~
$ singularity build VerySerious.img shub://GodloveD/lolcow
```

We now have a local Singularity image called VerySerious.img which can be executed. Use the "run" command to execute the pre-built function of the container.

```bash
$ singularity run VerySerious.img
```

In this case, creating the image wasn't totally necessary and we can execute this same command pulling directly from the Singularity hub.

```bash
$ singularity run shub://GodloveD/lolcow
```

We previously built an image from the Singularity hub, we can also do the same from the Docker hub.

```bash
$ singularity build graphtool.img docker://tiagopeixoto/graph-tool:latest
```

To help illustrate how you can execute a command that doesn't exist on your local machine, attempt to run samtools help dialog locally.

```bash
$ samtools --version
```

Now use the exec command to run the same command inside of the container

```bash
$ singularity exec /data/singularity/RinnLab_RNASeq.6.13.img samtools --version
```

Depending on how a local image is created, it will show you different outputs with the inspect command.

```bash
$ singularity inspect VerySerious.img
$ singularity inspect -d VerySerious.img
```

You will see much more information on images built from Singularity files locally.

```bash
$ singularity inspect /data/singularity/RinnLab_RNASeq.6.13.img
$ singularity inspect -d /data/singularity/RinnLab_RNASeq.6.13.img
```

## Get familiar with Nextflow

The script test.nf has a few input parameters and nothing else. Let's run it using 

```nextflow
nextflow run test.nf
```

Now, let's modify the script to include another parameter called email and add a line to log the email. Then run it again. 

We can view the output of the `reads` channel with the command `.println()`. 

Since a channel can only be consumed once, let's remove the `println` statement in order to add a process. 

Now let's create an empty process that will view the beginning of the read files. 

```nextflow
process view_reads {

  input:
  
  output:
  
  script:
  """
  
  """
}
```

The input needs to be the `reads` channel and the output will be a text file which we can specify with `*.txt`. 

Now let's add in the actual command that we wan't to run so that the script looks like this:

```nextflow
  script:
  """
  zcat ${read_files[[1]]} | head > ${sample_id}_reads.txt
  """
```

Now let's run nextflow again and view the output in the `results` directory.

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

The input channels to the process are annotation_for_de, salmon_for_de.collect(), and sample_info_for_de. The output that we care about is an html file. This can be specified to Nextflow with `file "*.html"`.

```nextflow
  script:
  """
  cp ${baseDir}/bin/*.R* .
  Rscript -e 'rmarkdown::render("differential_expression.Rmd", params = list(annotation_file = "${annotation}"))'
  """
```

## View the results of the RMarkdown script
Just like our Nextflow reports, we can just copy our RMarkdown output files (which are HTML) to the web root on the cloud instance, then type http://yourip into your web browser on your laptop.
