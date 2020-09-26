## Data Science Capstone Project - "Next Word Text Predictor"

This app has been produced in order to complete the Capstone Project for the Data Science Specialization provided by Johns Hopkins University (JHU) in Coursera. 

******

#### The Data

The data used to create the text prediction model can be downloaded from [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip), which comes from the corpus [HC Corpora](http://corpora.epizy.com/). Note that the text prediction model has only been developed from the English corpora. Therefore, any non-English entries will not produce correct prediction.

******

#### The Algorithm

The prediction algorithm used is based on the [Katz back-off](https://en.wikipedia.org/wiki/Katz%27s_back-off_model#:~:text=Katz%20back%2Doff%20is%20a,history%20models%20under%20certain%20conditions]) n-gram language model. Based on the recommendations done by Len Greski, former mentor of this capstone, in [here](https://github.com/lgreski/datasciencectacontent/blob/master/markdown/capstone-choosingATextPackage.md), the simplest version of the KBO algorithm has been used, Stupid-Back_off. Indeed, due to the fact that the prediction model has to run on the Shiny servers and the need for a fast app, simplicity becomes key. However, the accuracy of the model is not affected too much in comparison with other more complex implementations such as the Kneser-Ney discounting Back-Off model.   

******

#### The n-gram Database

A SQL database has been used for storing all the cleaned n-grams, containing from unigrams to quingrams. In order to reduce the size of the database, some filtering was performed to remove the most unlikely n-grams. 

******

#### How To Use

Pressing on the "Start" button of the "Home" tab will direct you to the "Text Predictor" tab. Once in this tab, all you need to do is select the amount of predictions you want to visualize and enter your text. Press "Submit" to get the results.

<img src="how_to_use.png" width="500px"/>


******

#### More

* [GitHub link] (https://github.com/Elenefern/Data_Science_Specialization_Capstone_Project)


