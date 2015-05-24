library(caret)
pmlTesting <- read.csv("pml-testing.csv")
pmlTraining <- read.csv("pml-training.csv")

# Some preproceccing

# Removing NAs
pmlTraining[is.na(pmlTraining)] <-0

# Removing near zero variables
nzv <- nearZeroVar(pmlTraining)
pmlTraining <- pmlTraining[, -nzv]

inTrain <- createDataPartition(pmlTraining$classe, p = 0.75, list=F)
training <- pmlTraining[inTrain,]
testing <- pmlTraining[-inTrain,]

modFit <- train(classe ~ ., method="rpart", data=training)
predictions <-predict(modFit, newdata = testing)
confusionMatrix(predictions, testing$classe)

pmlPredictions <-predict(modFit, newdata = pmlTesting)