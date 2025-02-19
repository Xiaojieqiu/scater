#' Right-tailed gamma approximation to rank-product p-value
#'
#' @param r integer rank-product
#' @param k integer number of experiments
#' @param n integer number of genes
#' @return float aproximate p-value
#' @export
#' @examples
#' calcRankProdPvalsApprox(9720, 5, 500)
calcRankProdPvalsApprox <- function(r, k, n) {
    1 - pgamma(-log(r/(n+1)^k), k, scale = 1)
}


#' Calculate bounds on p-values for rank-product statistics
#'
#'
#' This function computes bounds on the p-value for rank products.
#'
#'
#' @param rho a vector of integers corresponding to the rank products
#' for which one wishes to compute the p-value.
#' @param n the number of features (e.g. genes).
#' @param k the number of replicates.
#' @param delta a character string indicating whether an upper bound
#' ('upper'), lower bound ('lower'), or the default,geometric
#' approximation (i.e. the geometric mean of the upper and lower
#' bounds) ('geometric') should be computed.
#'
#' @return a vector of p-values, one for each rank product.
#'
#' @details The exact p-value is guaranteed to be in between the lower
#' and the upper bound. The geometric mean of the two bounds can be
#' used as an approximation. Each bound is a piecewise continuous
#' function of the rank product. The different pieces each have an
#' analytic form, the parameters of which can be computed recursively.
#'
#' This implementation closely follows the description in Heskes,
#' Eisinga, Breitling: "A fast algorithm for determining bounds and
#' accurate approximate p-values of the rank product statistic for
#' replicate experiments", further referred to as HEB. More
#' specifically, this R function corresponds to the recursive variant,
#' sketched as pseudocode in the additional material of HEB.
#'
#' We thank HEB for making their R code available. Their original code
#' has been lightly modified for use in \pkg{scater}.
#'
#' @export
#' @examples
#' calcRankProdPValsBounds(c(10, 100, 1000), 2000, 10, "upper")
calcRankProdPValsBounds <- function(rho, n, k, delta = "geometric") {
    ## INPUT HANDLING
    if(any(rho > n^k) || any(rho < 1))
        stop('rho out of bounds')
    if(is.numeric(delta) == FALSE) {
        if(delta == 'geometric') {
            temp1 <- calcRankProdPValsBounds(rho, n, k, 'upper')
            temp2 <- calcRankProdPValsBounds(rho, n, k, 'lower')
            pvalue <- sqrt(temp1*temp2)   # geometric mean of upper and lower bound
            return(pvalue)
        }
        else {
            delta <- switch(delta,
                            upper = 1,        # for computing upper bound
                            lower = 0)        # for computing lower bound
        }
    }
    ## COMPUTE INTERVALS THAT CONTAIN THE RANK PRODUCTS
    logn <- log(n)
    allj <- ceiling(-(log(rho) / logn) + k)   # index specifying the interval that contains rho 
    minj <- min(allj)                     # lowest interval index
    maxj <- max(allj)                     # highest interval index
    ## INITIALIZE PARAMETERS
    param <- matrix(list(), nrow = k+1, ncol = maxj+1)
    for(i in 1:(k + 1)){
        for(j in 1:(maxj + 1)){
            param[[i, j]] <- list(a = c(), b = c(), c = c(), d = c(), e = c())
        }
    }
    ## param is a matrix of lists; each element of param is a list with values for the parameters
    ## a through e, which correspond to the parameters alpha through epsilon in HEB;
    ## specifially, param[[i+1,j+1]]$a corresponds to alpha_{i,j} in HEB, etc, where the offset
    ## of 1 is introduced to be able to represent, for example, alpha_{0,0};
    ## a, b, and c can be vectors (with possibly different lengths for different i and j),
    ## d and e are scalars
    ## COMPUTE PARAMETERS
    for(j in minj:maxj) {
        param <- updateParam(param, n, k, j, delta)
    }
    ## call to the function updateParam which recursively computes all parameters that are needed
    ## to calculate the p-value for a rank product rho that lies in the interval with index j
    ## COMPUTE RANK PRODUCTS GIVEN PARAMETERS
    k1 <- 1+k
    G <- rep(0, length(rho))   # G is a vector of the same length as rho,
    # for each rho bounding the number of rank products 
    for(j in minj:maxj) {
        j1 <- 1+j
        iii <- which(allj == j)         # indices of all rank products that fall in interval j:
        # bounds for these rank products can be computed with
        # the same set of parameters                                    
        thisrho <- rho[iii]
        thisparam <- param[[k1, j1]]
        thisG <- thisparam$e
        if(j != 0) {
            nrho <- length(thisrho)
            nterms <- length(thisparam$a)
            thisG <- thisG + thisparam$d * thisrho
            d1 <- matrix(thisparam$c) %*% thisrho
            d2 <- matrix(rep(log(thisrho), nterms), nrow = nterms, byrow = TRUE) -
                t(matrix(rep(logn * (k - j + thisparam$b), nrho), nrow = nrho, byrow = TRUE))
            d3 <- t(matrix(rep(thisparam$a, nrho), nrow = nrho, byrow = TRUE)) 
            thisG <- thisG + colSums(d1 * (d2^d3))
        }
        # the 10 lines above implement equation (8) in HEB
        G[iii] <- thisG
    }
    pvalue <- G/n^k
    return(pvalue)
}

#' Update parameters for computation of rank-product p-values
#'
#' This subroutine updates the current set of parameters to make sure
#' that the parameters corresponding to k replicates and the j'th
#' interval are included.
#'
#' @param param a matrix of lists, where each element of param is a
#' list with values for the parameters a through e; these parameters
#' specify the functional form of the bound; a, b, and c are all
#' vectors of unknown length, d and e are scalars.
#' @param n the number of features (e.g. genes).
#' @param k the number of replicates for which we need to compute the
#' corresponding parameters.
#' @param j the index of the interval for which we need to compute the
#' corresponding parameters.
#' @param delta 0 for the lower bound and 1 for the upper bound.
#'
#' @return A possibly updated set of parameters, at least including
#' those corresponding to (k,j).
#'
#' @details This subroutine makes sure that the parameters
#' corresponding to k replicates and a rank product within the j'th
#' interval are already present. If they already are (because
#' calculated before), it does not compute anything. Otherwise, it
#' recursively computes all parameters that are needed to arrive at
#' the parameters for (k,j).
#'
#' This implementation closely follows HEB, in particular equations (9) through (11).
#' 
updateParam <- function(param, n, k, j, delta) {
    k1 <- 1+k
    j1 <- 1+j
    if(length(param[[k1,j1]]$e) == 0) {  # apparently empty, so needs to be calculated
        if(j == 0) {   # initializing G_{k0}
            param[[k1,j1]]$e <- n^k
            param[[k1,j1]]$d <- 0
            # the 2 lines above implement equation (11) in HEB
        }
        else {
            k0 <- k1-1
            j0 <- j1-1
            param <- updateParam(param, n, k-1, j-1, delta)
            # checking that the parameters for (k-1,j-1) that are needed to compute the
            # parameters for (k,j) are indeed available; if not, they are themselves computed
            param00 = param[[k0, j0]]
            newa0 = param00$a + 1
            newb0 = param00$b
            newc0 = param00$c / newa0
            param11 = param00
            # the 5 lines above predefine some parameters common to equations (9) and (10) in HEB
            if(k == j){ # updates for G_{kk}
                param11$e <- (1 - delta) * (1 - param00$e)
                param11$d <- delta * param00$d + param00$e
                param11$a <- c(1, param00$a, newa0)
                param11$b <- c(0, param00$b, newb0)
                param11$c <- c(param00$d, delta * param00$c, newc0)
                # the 5 lines above implement equation (10) in HEB
            }
            else {  # updates for G_{kj}, j < k
                param <- updateParam(param, n, k-1, j, delta)
                # checking that the parameters for (k-1,j) that are needed to compute the
                # parameters for (k,j) are indeed available; if not, they are themselves computed
                param01 <- param[[k0, j1]]
                logn <- log(n)
                lognnkj <- (k - j) * logn
                newa1 <- param01$a + 1
                newa <- c(newa0, newa1)
                newb <- c(newb0, param01$b)
                newc <- c(newc0, -param01$c / newa1)
                param11$e <- n * param01$e + (delta - 1) * (param00$e - param01$e)
                lognminb <- c(-1 * param00$b * logn, (1 - param01$b) * logn)
                param11$d <- delta * param00$d + (1 - delta) * param01$d / n + 
                    (param00$e - param01$e) / exp(lognnkj) - sum(newc * (lognminb^newa))
                param11$a <- c(1, 1, param00$a, param01$a, newa)
                param11$b <- c(0, 1, param00$b, param01$b, newb)
                param11$c <- c(param00$d, -param01$d, delta * param00$c, (1-delta) * param01$c / n, newc)
                # the 15 lines above implement equation (9) in HEB
            }
            param[[k1, j1]] <- makeUnique(param11)
            # although not strictly necessary, the a, b and c vectors can possibly be shortened by
            # restricting oneselves to unique combinations of a and b values
        }
    }
    return(param)
}

#' Update the parameters so that they are unique
#'
#' This subroutine updates the parameters for a specific number of replicates and interval
#' such that it contains only unique combinations of the parameters a and b.
#'
#' @param param a single list with values for the parameters a through
#' e; these parameters specify the functional form of the bound; a, b,
#' and c are all vectors of unknown length, d and e are scalars.
#' 
#' @return A possibly updated and then more concise set of parameters
#' containing only unique combinations of the parameters a and b.
#'
#' @details While updating the vectors a and b, one may end up with
#' the exact same combinations of a and b. Given the functional form
#' of the bound, the representation can then be made more concise by
#' simply adding the corresponding elements of c.
makeUnique <- function(param) {
    ab <- t(rbind(param$a, param$b))
    uniqueab <- unique(ab)
    nunique <- dim(uniqueab)[1]
    param$a <- t(uniqueab[, 1])
    param$b <- t(uniqueab[, 2])
    newc <- rep(0, nunique)
    for(i in 1:nunique) {
        iii <- intersect(which(ab[, 1] == uniqueab[i, 1]), which(ab[, 2] == uniqueab[i, 2]))
        newc[i] <- sum(param$c[iii])  
    }
    param$c <- newc
    return(param)
}

