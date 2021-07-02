library(delimitR)

nclasses <- 12
FullPrior <- makeprior(prefix='model', nspec=4, nclasses=12, mydir='./', traitsfile='traits', threshold=100, thefolder='Prior', ncores=20)

ReducedPrior <- Prior_reduced(FullPrior)

myRF <- RF_build_abcrf(ReducedPrior,FullPrior,500)
myRF
out <- capture.output(myRF)
cat("MyRF", out, file="myRF.txt", sep="n", append=TRUE)

observedSFS <- 'ant_MSFS'
traitsfile <- 'traits'
obsspecies <- 4

myobserved <- prepobserved(observedSFS,
  FullPrior,
  ReducedPrior,
  nclasses,
  obsspecies,
  traitsfile=traitsfile,
  threshold = 100)
  
prediction <- RF_predict_abcrf(myRF, myobserved, ReducedPrior, FullPrior, 500)
prediction
out2 <- capture.output(prediction)
cat("predictionq", out2, file="prediction.txt", sep="n", append=TRUE)


