#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    predict_words <- function(input_gram, dbname){
        
        result <- data.frame(prediction = character(), probability=numeric()) 
        
        # Clean the original sentence
        replace_reg <- "[^[:alpha:][:space:]]*" 
        
        clean_gram <- data_frame(text = input_gram) %>% 
            mutate(text = str_replace_all(text, replace_reg, "")) %>% 
            tolower %>% strsplit(split=" ") %>% unlist()
        
        n <- length(clean_gram) # input gram size
        max_gram_size <- 4
        k <- 0.4
        
        con <- dbConnect(SQLite(), dbname="./www/nGramdb.db")
        
        for (i in (min(n,max_gram_size)):1){
            
            
            if (i==4){
                # search quingram
                search_gram <- paste(tail(clean_gram, 4), collapse=" ")
                origin<-"quingram"
                multiplier <- 1
                sql <- paste("SELECT prediction, frequency FROM quingram WHERE ", 
                             " prior=='", paste(search_gram), "'", sep="")}
            
            if (i==3){
                # search quadgram
                search_gram <- paste(tail(clean_gram, 3), collapse=" ")
                origin<-"quadgram"
                multiplier <- k
                sql <- paste("SELECT prediction, frequency FROM quadgram WHERE ", 
                             " prior=='", paste(search_gram), "'", sep="")}
            
            if (i==2){
                # search trigram
                search_gram <- paste(tail(clean_gram, 2), collapse=" ")
                origin<-"trigram"
                multiplier <- k^2
                sql <- paste("SELECT prediction, frequency FROM trigram WHERE ", 
                             " prior=='", paste(search_gram), "'", sep="")}
            
            if (i==1){
                # search bigram
                search_gram <- paste(tail(clean_gram, 1), collapse=" ")
                origin<-"bigram"
                multiplier <- k^3
                sql <- paste("SELECT prediction, frequency FROM bigram WHERE ", 
                             " prior=='", paste(search_gram), "'", sep="")}
            
            res <- dbSendQuery(conn=con, sql)
            predictions <- dbFetch(res, n=-1)
            
            if (nrow(predictions) > 0) {
                predictions$origin <- origin
                predictions$probability <- multiplier*predictions$frequency/sum(predictions$frequency)
                result <- rbind(result, predictions)}
            
            dbClearResult(res)
            
        }
        
        if (nrow(result)==0) 
        {sql <- paste("SELECT prediction, frequency FROM unigram LIMIT 20")          
	       res <- dbSendQuery(conn=con, sql)
	       result <- dbFetch(res, n=-1)
         dbClearResult(res)
	       result$probability <- multiplier*result$frequency/sum(result$frequency)
	       result$origin <- "unigram"
         }
        
    
        dbDisconnect(con)
        
        result <- result %>% arrange(desc(probability)) %>% select(-origin,-frequency) %>% distinct(prediction, .keep_all= TRUE)
        return_number <- 20
        
        return(head(result,return_number))
        
    }
    
    # Change tabs on "Start"
    observeEvent(input$onStart, {
        updateNavbarPage(session, "navBar",
                          selected = "Text Predictor")
    })
    
  
    prediction <- eventReactive(input$onSubmit, {
        
        aux<- predict_words(input$input_ngram)
        if(dim(aux)[1]<1) return(aux)
        else {  output_table <- aux[1:input$number_predictions,]
                output_table$probability <- output_table$probability*100
                names(output_table) <- cbind("Prediction", "Probability [%]")
                return(output_table)}
    })
    

    output$out_text <- renderText({
        aux<-prediction()
        if(dim(aux)[1]<1) return("No predictions found for your input text")
        else return("**Note that the probability percentage shown on the table is based on all the predictions, not only on the ones filtered in the table")
    })
    
    output$table<-renderDT({prediction()}, options = list(dom = 'tp'))

    
    
})
