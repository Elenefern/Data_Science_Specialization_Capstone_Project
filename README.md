# Data_Science_Specialization_Capstone_Project

This app has been produced in order to complete the Capstone Project for the Data Science Specialization provided by Johns Hopkins University (JHU) in Coursera. 

******

#### The Data

The data used to create the text prediction model can be downloaded from [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip), which comes from the corpus [HC Corpora](http://corpora.epizy.com/). Note that the text prediction model has only been developed from the English corpora. Therefore, any non-English entries will not produce correct prediction.

<small> The main data cleaning processes that have been performed are: </small>
* <small> punctuation mark and separator removal </small>
* <small>number and symbol removal </small>
* <small>conversion to lower case </small>
* <small>profanity filtering </small>

<small> Note that stemming and stopword removal have not been performed since this would result in a predictor that would not feel natural. </small>

******

#### The Algorithm

The prediction algorithm used is based on the [Katz back-off](https://en.wikipedia.org/wiki/Katz%27s_back-off_model#:~:text=Katz%20back%2Doff%20is%20a,history%20models%20under%20certain%20conditions]) n-gram language model. Based on the recommendations done by Len Greski, former mentor of this capstone, in [here](https://github.com/lgreski/datasciencectacontent/blob/master/markdown/capstone-choosingATextPackage.md), the simplest version of the KBO algorithm has been used, Stupid-Back_off. Indeed, due to the fact that the prediction model has to run on the Shiny servers and the need for a fast app, simplicity becomes key. However, the accuracy of the model is not affected too much in comparison with other more complex implementations such as the Kneser-Ney discounting Back-Off model.   

******

#### The n-gram Database

A SQL database has been used for storing all the cleaned n-grams, containing from unigrams to quingrams. In order to reduce the size of the database, some filtering was performed to remove the most unlikely n-grams. 

******

#### The GitHub content

* `create_ngram_db.Rmd`: performs all the data cleaning, creates 1-gram to 5-grams and stores them in the SQL database used by the app.  
* `Capstone_project_presentation.Rpres`: R presentation
* **app/:**
    * `ui.R`/`server.R`: shiny app files
    * `data/nGramdb.db`: SQL database
    * **www**: images used within the app
