% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/scaleAmp.R
\name{scaleVar}
\alias{scaleVar}
\title{Scale expression values to have unit variance in expressing cells}
\usage{
scaleVar(expr_matrix, is_expr, vars = NULL)
}
\arguments{
\item{expr_matrix}{a numeric matrix containing expression values
counts.}

\item{is_expr}{a logical matrix of same dimensions as
\code{expr_matrix} indicating which cells are expressed for each
gene.}

\item{vars}{optional vector of variance values to apply for the
scaling of the expression values. If \code{NULL} (default), then
variance is computed for each gene only from the cells with
non-zero expression for the gene.}
}
\value{
A matrix object.
}
\description{
Scale expression values to have unit variance in expressing cells
}
\details{
This function is intended to process RNA-Seq or ChIP-Seq
data prior to modeling with RankProduct. Written by Davis McCarthy.
}

