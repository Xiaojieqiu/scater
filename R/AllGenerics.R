# ### defining all generic methods
 
#' Replacement for phenoData
#' 
#' @name pData<-
#' @param x object containing phenoData to replace
#' @param value AnnotatedDataFrame to replace existing phenoData
#' @export
#' @docType methods
#' @rdname pData-replace
#' @importFrom Biobase pData<-
setGeneric("pData<-", signature = signature("x", "value"),
           function(x, value) {standardGeneric("pData<-")})

#' Replacement for featureData
#' 
#' @name fData<-
#' @param x object containing featureData to replace
#' @param value AnnotatedDataFrame to replace existing featureData
#' @export
#' @docType methods
#' @rdname fData-replace
#' @importFrom Biobase fData<-
setGeneric("fData<-", signature = signature("x", "value"),
           function(x, value) {standardGeneric("fData<-")})


#' @name is_exprs
#' @export
#' @docType methods
#' @rdname is_exprs
setGeneric("is_exprs", function(object) {standardGeneric("is_exprs")})

#' @name is_exprs<-
#' @export
#' @docType methods
#' @rdname is_exprs
setGeneric("is_exprs<-", function(object, value) {standardGeneric("is_exprs<-")})


#' @name norm_exprs
#' @export
#' @docType methods
#' @rdname norm_exprs
setGeneric("norm_exprs", function(object) {standardGeneric("norm_exprs")})

#' @name norm_exprs<-
#' @export
#' @docType methods
#' @rdname norm_exprs
setGeneric("norm_exprs<-", function(object, value) {standardGeneric("norm_exprs<-")})

#' @name stand_exprs
#' @export
#' @docType methods
#' @rdname stand_exprs
setGeneric("stand_exprs", function(object) {standardGeneric("stand_exprs")})

#' @name stand_exprs<-
#' @export
#' @docType methods
#' @rdname stand_exprs
setGeneric("stand_exprs<-", function(object, value) {standardGeneric("stand_exprs<-")})


#' @name tpm
#' @export
#' @docType methods
#' @rdname tpm
setGeneric("tpm", function(object) {standardGeneric("tpm")})

#' @name tpm<-
#' @export
#' @docType methods
#' @rdname tpm
setGeneric("tpm<-", function(object, value) {standardGeneric("tpm<-")})

#' @name cpm
#' @export
#' @docType methods
#' @rdname cpm
setGeneric("cpm", function(object) {standardGeneric("cpm")})

#' @name cpm<-
#' @export
#' @docType methods
#' @rdname cpm
setGeneric("cpm<-", function(object, value) {standardGeneric("cpm<-")})

#' @name fpkm
#' @export
#' @docType methods
#' @rdname fpkm
setGeneric("fpkm", function(object) {standardGeneric("fpkm")})

#' @name fpkm<-
#' @export
#' @docType methods
#' @rdname fpkm
setGeneric("fpkm<-", function(object, value) {standardGeneric("fpkm<-")})

#' @name norm_counts
#' @export
#' @docType methods
#' @rdname norm_counts
setGeneric("norm_counts", function(object) {standardGeneric("norm_counts")})

#' @name norm_counts<-
#' @export
#' @docType methods
#' @rdname norm_counts
setGeneric("norm_counts<-", function(object, value) {standardGeneric("norm_counts<-")})

#' @name norm_tpm
#' @export
#' @docType methods
#' @rdname norm_tpm
setGeneric("norm_tpm", function(object) {standardGeneric("norm_tpm")})

#' @name norm_tpm<-
#' @export
#' @docType methods
#' @rdname norm_tpm
setGeneric("norm_tpm<-", function(object, value) {standardGeneric("norm_tpm<-")})

#' @name norm_cpm
#' @export
#' @docType methods
#' @rdname norm_cpm
setGeneric("norm_cpm", function(object) {standardGeneric("norm_cpm")})

#' @name norm_cpm<-
#' @export
#' @docType methods
#' @rdname norm_cpm
setGeneric("norm_cpm<-", function(object, value) {standardGeneric("norm_cpm<-")})

#' @name norm_fpkm
#' @export
#' @docType methods
#' @rdname norm_fpkm
setGeneric("norm_fpkm", function(object) {standardGeneric("norm_fpkm")})

#' @name norm_fpkm<-
#' @export
#' @docType methods
#' @rdname norm_fpkm
setGeneric("norm_fpkm<-", function(object, value) {standardGeneric("norm_fpkm<-")})

#' @name bootstraps
#' @export
#' @docType methods
#' @rdname bootstraps
setGeneric("bootstraps", function(object) {standardGeneric("bootstraps")})

#' @name bootstraps<-
#' @export
#' @docType methods
#' @rdname bootstraps
setGeneric("bootstraps<-", function(object, value) {standardGeneric("bootstraps<-")})

#' @name cellPairwiseDistances
#' @export
#' @docType methods
#' @rdname cellPairwiseDistances
setGeneric("cellPairwiseDistances", function(object) {
    standardGeneric("cellPairwiseDistances")
    })

#' @name cellPairwiseDistances<-
#' @export
#' @docType methods
#' @rdname cellPairwiseDistances
setGeneric("cellPairwiseDistances<-", function(object, value) {
    standardGeneric("cellPairwiseDistances<-")
    })


#' @name cellDist
#' @export
#' @docType methods
#' @rdname cellPairwiseDistances
setGeneric("cellDist", function(object) {
    standardGeneric("cellDist")
})

#' @name cellDist<-
#' @export
#' @docType methods
#' @rdname cellPairwiseDistances
setGeneric("cellDist<-", function(object, value) {
    standardGeneric("cellDist<-")
})


#' @name featurePairwiseDistances
#' @export
#' @docType methods
#' @rdname featurePairwiseDistances
setGeneric("featurePairwiseDistances", function(object) {
    standardGeneric("featurePairwiseDistances")
})

#' @name featurePairwiseDistances<-
#' @export
#' @docType methods
#' @rdname featurePairwiseDistances
setGeneric("featurePairwiseDistances<-", function(object, value) {
    standardGeneric("featurePairwiseDistances<-")
})


#' @name featDist
#' @export
#' @docType methods
#' @rdname featurePairwiseDistances
setGeneric("featDist", function(object) {
    standardGeneric("featDist")
})

#' @name featDist<-
#' @export
#' @docType methods
#' @rdname featurePairwiseDistances
setGeneric("featDist<-", function(object, value) {
    standardGeneric("featDist<-")
})


#' @name reducedDimension
#' @export
#' @docType methods
#' @rdname reducedDimension
setGeneric("reducedDimension", function(object) {
    standardGeneric("reducedDimension")
})

#' @name reducedDimension<-
#' @export
#' @docType methods
#' @rdname reducedDimension
setGeneric("reducedDimension<-", function(object, value) {
    standardGeneric("reducedDimension<-")
})


#' @name redDim
#' @export
#' @docType methods
#' @rdname reducedDimension
setGeneric("redDim", function(object) {
    standardGeneric("redDim")
})

#' @name redDim<-
#' @export
#' @docType methods
#' @rdname reducedDimension
setGeneric("redDim<-", function(object, value) {
    standardGeneric("redDim<-")
})

#' @name plotReducedDim
#' @export
#' @docType methods
#' @rdname plotReducedDim
setGeneric("plotReducedDim", function(object, ...) {
    standardGeneric("plotReducedDim")
})

#' @name plotExpression
#' @export
#' @docType methods
#' @rdname plotExpression
setGeneric("plotExpression", function(object, ...) {
    standardGeneric("plotExpression")
})


#' @name plotPCA
#' @export
#' @docType methods
#' @rdname plotPCA
if ( !isGeneric("plotPCA") ) {
    ## plotPCA is a generic in BiocGenerics_0.14.0 in R 3.2.0 - for earlier
    ## versions need to manually add it as a generic
    setGeneric("plotPCA", function(object, ...) {
        standardGeneric("plotPCA")
    })
}

#' @name plotTSNE
#' @export
#' @docType methods
#' @rdname plotTSNE
setGeneric("plotTSNE", function(object, ...) {
    standardGeneric("plotTSNE")
})

