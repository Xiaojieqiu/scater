% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/plotting.R
\docType{methods}
\name{plotPCA}
\alias{plotPCA}
\alias{plotPCA,SCESet-method}
\alias{plotPCASCESet}
\title{Plot PCA for an SCESet object}
\usage{
plotPCASCESet(object, ntop = 500, ncomponents = 2, colour_by = NULL,
  shape_by = NULL, size_by = NULL, feature_set = NULL,
  return_SCESet = FALSE, scale_features = TRUE, draw_plot = TRUE,
  theme_size = 10)

\S4method{plotPCA}{SCESet}(object, ntop = 500, ncomponents = 2,
  colour_by = NULL, shape_by = NULL, size_by = NULL, feature_set = NULL,
  return_SCESet = FALSE, scale_features = TRUE, draw_plot = TRUE)
}
\arguments{
\item{object}{an \code{SCESet} object}

\item{ntop}{numeric scalar indicating the number of most variable features to
use for the PCA. Default is \code{500}, but any \code{ntop} argument is
overrided if the \code{feature_set} argument is non-NULL.}

\item{ncomponents}{numeric scalar indicating the number of principal
components to plot, starting from the first principal component. Default is
2. If \code{ncomponents} is 2, then a scatterplot of PC2 vs PC1 is produced.
If \code{ncomponents} is greater than 2, a pairs plots for the top components
is produced.}

\item{colour_by}{character string defining the column of \code{pData(object)} to
be used as a factor by which to colour the points in the plot.}

\item{shape_by}{character string defining the column of \code{pData(object)} to
be used as a factor by which to define the shape of the points in the plot.}

\item{size_by}{character string defining the column of \code{pData(object)} to
be used as a factor by which to define the size of points in the plot.}

\item{feature_set}{character, numeric or logical vector indicating a set of
features to use for the PCA. If character, entries must all be in
\code{featureNames(object)}. If numeric, values are taken to be indices for
features. If logical, vector is used to index features and should have length
equal to \code{nrow(object)}.}

\item{return_SCESet}{logical, should the function return an \code{SCESet}
object with principal component values for cells in the
\code{reducedDimension} slot. Default is \code{FALSE}, in which case a
\code{ggplot} object is returned.}

\item{scale_features}{logical, should the expression values be standardised
so that each feature has unit variance? Default is \code{TRUE}.}

\item{draw_plot}{logical, should the plot be drawn on the current graphics
device? Only used if \code{return_SCESet} is \code{TRUE}, otherwise the plot
is always produced.}

\item{theme_size}{numeric scalar giving default font size for plotting theme
(default is 10).}
}
\description{
Produce a principal components analysis (PCA) plot of two or more principal
components for an \code{SCESet} dataset.
}
\details{
The function \code{\link{prcomp}} is used internally to do the PCA.
The function checks whether the \code{object} has standardised
expression values (by looking at \code{stand_exprs(object)}). If yes, the
existing standardised expression values are used for the PCA. If not, then
standardised expression values are computed using \code{\link{scale}} (with
feature-wise unit variances or not according to the \code{scale_features}
argument), added to the object and PCA is done using these new standardised
expression values.
}
\examples{
## Set up an example SCESet
data("sc_example_counts")
data("sc_example_cell_info")
pd <- new("AnnotatedDataFrame", data = sc_example_cell_info)
example_sceset <- newSCESet(countData = sc_example_counts, phenoData = pd)

## Examples plotting PC1 and PC2
plotPCA(example_sceset)
plotPCA(example_sceset, colour_by = "Cell_Cycle")
plotPCA(example_sceset, colour_by = "Cell_Cycle", shape_by = "Treatment")
plotPCA(example_sceset, colour_by = "Cell_Cycle", shape_by = "Treatment",
size_by = "Mutation_Status")
plotPCA(example_sceset, shape_by = "Treatment", size_by = "Mutation_Status")
plotPCA(example_sceset, feature_set = 1:100, colour_by = "Treatment",
shape_by = "Mutation_Status")

plotPCA(example_sceset, shape_by = "Treatment", return_SCESet = TRUE)

## Examples plotting more than 2 PCs
plotPCA(example_sceset, ncomponents = 8)
plotPCA(example_sceset, ncomponents = 4, colour_by = "Treatment",
shape_by = "Mutation_Status")
}

