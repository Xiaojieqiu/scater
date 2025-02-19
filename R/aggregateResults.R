# Compare and aggregate results from different ranking methods using exact rank-product tests
# Davis McCarthy, July 2014

library(matrixStats)

#' Aggregate and compare results from different ranking methods using exact rank-product tests
#'
#' @param results a matrix or data.frame object where columns provide
#' results values (e.g. p-values) to be used for ranking features
#' (e.g. genes) and ordering of results.
#' @param nmax_genes integer giving the maximum number of features
#' (e.g. genes) for which to compute exact rank-product p-values
#' @param max_rankprod_exact integer giving the maximum rank-product for
#' which to compute exact p-values. Exact p-values are very slow to
#' compute for large rank-products, and converge to approximate
#' p-values.
#' @return data frame with mean rank, rank product, number of ways of
#' obtaining given rank product, approximate p-value and exact p-value
#' @export
aggregateResults <- function(results, nmax_genes = 500, max_rankprod_exact = 100000) {
    ranks <- matrix(NA, nrow = nrow(results), ncol = ncol(results), dimnames = list(rownames(results), colnames(results)))
    ## Define ranking for each feature, for each method
    for(i in seq_len(ncol(results))) {
        ranks[, i] <- rank(results[, i], ties.method = "average")
    }
    rank_products <- matrixStats::rowProds(ranks)
    names(rank_products) <- rownames(ranks)
    ranks <- ranks[order(rank_products), ]
    pvals <- calcRankProdPValsBounds(ranks, n=length(ranks), k=ncol(results))
    aggregated_results <- data.frame(Feature=rownames(results), 
                                     Rank_Prod=rank_products, P_Value=pvals, 
                                     Rank=ranks)
    aggregated_results[1:nmax_genes, ]
}
    

