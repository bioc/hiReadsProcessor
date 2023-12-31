% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hiReadsProcessor.R
\name{getSonicAbund}
\alias{getSonicAbund}
\title{Calculate breakpoint/sonic abundance of integration sites in a population}
\usage{
getSonicAbund(
  posID = NULL,
  fragLen = NULL,
  grouping = NULL,
  replicateNum = NULL,
  psl.rd = NULL,
  parallel = TRUE
)
}
\arguments{
\item{posID}{a vector of discrete positions, i.e. Chr,strand,Position.
Required if psl.rd parameter is not defined.}

\item{fragLen}{a vector of fragment length per posID. Required if 
psl.rd parameter is not defined.}

\item{grouping}{additional vector of grouping of length posID or psl.rd by 
which to pool the rows (i.e. samplenames). Default is NULL.}

\item{replicateNum}{an optional vector of the replicate number per grouping 
and posID. Default is NULL.}

\item{psl.rd}{a GRanges object returned from \code{\link{getIntegrationSites}} 
Default is NULL.}

\item{parallel}{use parallel backend to perform calculation with 
\code{\link{BiocParallel}}. Defaults to TRUE. If no parallel backend is 
registered, then a serial version is ran using \code{\link{SerialParam}}. 
Process is split by the grouping the column.}
}
\value{
a data frame with estimated sonic abundance shown alongside with the
original input. If psl.rd parameter is defined then a GRanges object is 
returned with a new column 'estAbund'.
}
\description{
Given distinct fragment lengths per integration, the function calculates
sonic abundance as described in \code{\link{sonicLength}}. This function is 
called by \code{\link{clusterSites}} and needs all individual fragments 
lengths per position to properly estimate the clonal abundance of an 
integration sites in a given population.
}
\note{
For samples isolated using traditional restriction digest method, 
the abundance will be inaccurate as it is designed for sonicated or sheared
sample preparation method.
}
\examples{
data("A1",package='sonicLength')
A1 <- droplevels(A1[1:1000,])
bore <- with(A1, getSonicAbund(locations, lengths, "A", replicates))
head(bore)
}
\seealso{
\code{\link{clusterSites}}, \code{\link{otuSites}}, 
\code{\link{findIntegrations}}, \code{\link{getIntegrationSites}}, 
\code{\link{pslToRangedObject}}
}
