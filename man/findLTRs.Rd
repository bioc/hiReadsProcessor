% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hiReadsProcessor.R
\name{findLTRs}
\alias{findLTRs}
\title{Find the 5' LTRs and add results to SampleInfo object.}
\usage{
findLTRs(
  sampleInfo,
  showStats = FALSE,
  doRC = FALSE,
  parallel = TRUE,
  samplenames = NULL,
  bypassChecks = FALSE,
  parallel2 = FALSE,
  ...
)
}
\arguments{
\item{sampleInfo}{sample information SimpleList object outputted from 
\code{\link{findPrimers}}, which holds decoded and primed sequences for 
samples per sector/quadrant along with information of sample to LTR 
associations.}

\item{showStats}{toggle output of search statistics. Default is FALSE. 
For paired end data, stats for "pair2" is relative to decoded and/or 
primed reads.}

\item{doRC}{perform reverse complement search of the defined pattern/LTR 
sequence. Default is FALSE.}

\item{parallel}{use parallel backend to perform calculation with 
\code{\link{BiocParallel}}. Defaults to TRUE. If no parallel backend is 
registered, then a serial version is ran using 
\code{\link{SerialParam}}. Parllelization is done at sample level per 
sector.}

\item{samplenames}{a vector of samplenames to process. Default is NULL, 
which processes all samples from sampleInfo object.}

\item{bypassChecks}{skip checkpoints which detect if something was odd with 
the data? Default is FALSE.}

\item{parallel2}{perform parallelization is sequence level. Default is FALSE. 
Useful in cases where each sector has only one sample with numerous sequences.}

\item{...}{extra parameters to be passed to \code{\link{pairwiseAlignment}}.}
}
\value{
a SimpleList object similar to sampleInfo paramter supplied with new 
data added under each sector and sample. New data attributes include: LTRed
}
\description{
Given a sampleInfo object, the function finds 5' LTR following the primer for
each sample per sector and adds the results back to the object. This is a 
specialized function which depends on many other functions shown in 'see also
section' to perform specialized trimming of 5' viral LTRs found in the 
sampleInfo object. The sequence itself is never trimmed but rather 
coordinates of LTR portion is added to primer coordinates and recorded back 
to the object and used subsequently by \code{\link{extractSeqs}} function to 
perform the trimming. This function heavily relies on 
\code{\link{pairwiseAlignSeqs}}.
}
\note{
\itemize{
 \item For paired end data, qualityThreshold for pair 2 is decreased by 
 0.05 to increase chances of matching LTR sequence.
 \item If parallel=TRUE, then be sure to have a parallel backend registered 
 before running the function. One can use any of the following 
 \code{\link{MulticoreParam}} \code{\link{SnowParam}}
}
}
\examples{
 
\dontrun{
load(file.path(system.file("data", package = "hiReadsProcessor"),
"FLX_seqProps.RData"))
findLTRs(seqProps, showStats=TRUE)
}
}
\seealso{
\code{\link{pairwiseAlignSeqs}}, \code{\link{vpairwiseAlignSeqs}},
\code{\link{extractFeature}}, \code{\link{extractSeqs}}, 
\code{\link{primerIDAlignSeqs}}, \code{\link{findPrimers}}, 
\code{\link{findLinkers}}, \code{\link{findAndTrimSeq}}
}
