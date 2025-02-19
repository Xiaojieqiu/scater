% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/plotting.R
\name{multiplot}
\alias{multiplot}
\title{Multiple plot function for ggplot2 plots}
\usage{
multiplot(..., plotlist = NULL, cols = 1, layout = NULL)
}
\arguments{
\item{...,plotlist}{ggplot objects can be passed in ..., or to plotlist (as
a list of ggplot objects)}

\item{cols}{numeric scalar giving the number of columns in the layout}

\item{layout}{a matrix specifying the layout. If present, \code{cols} is
ignored.}
}
\description{
Place multiple \code{\link[ggplot2]{ggplot}} plots on one page.
}
\details{
If the layout is something like
\code{matrix(c(1,2,3,3), nrow=2, byrow=TRUE)}, then plot 1 will go in the
upper left, 2 will go in the upper right, and 3 will go all the way across
the bottom. There is no way to tweak the relative heights or widths of the
plots with this simple function. It was adapted from
\url{http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/}
}
\examples{
library(ggplot2)
## This example uses the ChickWeight dataset, which comes with ggplot2
## First plot
p1 <- ggplot(ChickWeight, aes(x = Time, y = weight, colour = Diet, group = Chick)) +
   geom_line() +
   ggtitle("Growth curve for individual chicks")
## Second plot
p2 <- ggplot(ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
   geom_point(alpha = .3) +
   geom_smooth(alpha = .2, size = 1) +
   ggtitle("Fitted growth curve per diet")
## Third plot
p3 <- ggplot(subset(ChickWeight, Time == 21), aes(x = weight, colour = Diet)) +
   geom_density() +
   ggtitle("Final weight, by diet")
## Fourth plot
p4 <- ggplot(subset(ChickWeight, Time == 21), aes(x = weight, fill = Diet)) +
    geom_histogram(colour = "black", binwidth = 50) +
   facet_grid(Diet ~ .) +
   ggtitle("Final weight, by diet") +
   theme(legend.position = "none")        # No legend (redundant in this graph)
## Combine plots and display
multiplot(p1, p2, p3, p4, cols = 2)
}

