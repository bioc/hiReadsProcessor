% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hiReadsProcessor.R
\name{otuSites}
\alias{otuSites}
\title{Bin values or make OTUs by assigning a unique ID to them within discrete factors.}
\usage{
otuSites(
  posID = NULL,
  value = NULL,
  readID = NULL,
  grouping = NULL,
  psl.rd = NULL,
  maxgap = 5,
  parallel = TRUE
)
}
\arguments{
\item{posID}{a vector of groupings for the value parameter (i.e. Chr,strand).
Required if psl.rd parameter is not defined.}

\item{value}{a vector of integer locations/positions that needs to be binned, 
i.e. genomic location. Required if psl.rd parameter is not defined.}

\item{readID}{a vector of read/clone names which is unique to each row, 
i.e. deflines.}

\item{grouping}{additional vector of grouping of length posID or psl.rd by 
which to pool the rows (i.e. samplenames). Default is NULL.}

\item{psl.rd}{a GRanges object returned from \code{\link{clusterSites}}. 
Default is NULL.}

\item{maxgap}{max distance allowed between two non-overlapping position to 
trigger the merging. Default is 5.}

\item{parallel}{use parallel backend to perform calculation with 
\code{\link{BiocParallel}}. Defaults to TRUE. If no parallel backend is 
registered, then a serial version is ran using \code{\link{SerialParam}}. 
Process is split by the grouping the column.}
}
\value{
a data frame with binned values and otuID shown alongside the 
original input. If psl.rd parameter is defined, then a GRanges object.
}
\description{
Given a group of values or genomic positions per read/clone, the function 
tries to yield a unique OTU (operation taxinomical unit) ID for the 
collection based on overlap of locations to other reads/clones by grouping. 
This is mainly useful when each read has many locations which needs to be 
considered as one single group of sites.
}
\note{
The algorithm for making OTUs of sites is as follows: 
\itemize{
 \item for each grouping & posID, fix values off by maxgap parameter
 \item create bins of fixed values per readID
 \item assign arbitrary numeric ID to each distinct bins above & obtain its frequency
 \item perform overlap b/w readIDs with only one value (singletons) to readIDs with >1 value (non-singletons)
 \item   - for any overlapping values, tag non-singleton readID with the ID of singleton readID
 \item   - if non-singleton readID matched with more than one singleton readID, then pick on at random
 \item for any non-tagged & non-singleton readIDs, perform an overlap of values within themselves using the maxgap parameter
 \item   - tag any overlapping positions across any readID with the ID of most frequently occuring bin
 \item positions with no overlap are left as is with the original arbitrary ID
}
}
\examples{
otuSites(posID = c('chr1-', 'chr1-', 'chr1-', 'chr2+', 'chr15-', 'chr16-', 'chr11-'),
value = c(1000, 1003, 5832, 1000, 12324, 65738, 928042), 
readID = paste('read', sample(letters, 7), sep = '-'), 
grouping = c('a', 'a', 'a', 'b', 'b', 'b', 'c'), parallel = FALSE)
}
\seealso{
\code{\link{clusterSites}}, \code{\link{isuSites}},
\code{\link{crossOverCheck}}, \code{\link{findIntegrations}}, 
\code{\link{getIntegrationSites}}, \code{\link{pslToRangedObject}}
}
