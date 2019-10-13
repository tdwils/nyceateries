# server.R


server <- function(input, output) {
  
  source("includes/functions.R")
  
  # Read in data --------------------------------------------------------------
  geodata <- reactive ({
    
    dataset <- read.csv("data/geodata.csv", 
                        stringsAsFactors = FALSE)
    
    return (dataset)
  })
  
  
  # Create Type dropdown menu -------------------------------------------------
  
  type_opts <- reactive ({
    unique(geodata()$type) %>% sort()
  })
  
  output$type_menu <- renderUI({
    tagList(
      pickerInput(inputId = "type",
                  label = "Cuisine",
                  choices = type_opts(),
                  options = list(`actions-box` = TRUE,
                                 `none-selected-text` = "Select a cuisine"),
                  multiple = TRUE
      )
    )
  })
  
  
  # Create map dataset --------------------------------------------------------
  get_map_dataset <- reactive ({
    
    dataset <- geodata() %>%
      arrange(type)
    
    return (dataset)
  })
  
  
  # Filter data ---------------------------------------------------------------
  filter_data <- reactive({   
    dataset <- get_map_dataset()
    
    if(!is.null(input$type)) {
      dataset <- filter(dataset, type %in% input$type)
    }
    return (dataset)
  })
  
  
  # Output map --------------------------------------------------------------
  output$eatery_map <- renderLeaflet({
    req(filter_data())
    
    plotdata <- filter_data()
    
    
    # Tooltips 
    plotdata$label_text <- paste0("<strong>%s</strong>"   # Name
    )
    labels <- sprintf(
      plotdata$label_text,
      plotdata$name 
    ) %>% lapply(htmltools::HTML)
    
    
    # Popups 
    # If a link is available, display it
    
    popup_with_url <- paste0(
      "<a href='%s' target='_blank'>%s</a>",             # URL and name
      "<br/><span>%s</span>"                             # Address
    )
    popup_no_url <- paste0(
      "%s",                                              # Name
      "<br/><span>%s</span>"                             # Address
    )
    
    plotdata$popup_text <- ifelse(plotdata$url != "", 
                                  popup_with_url, 
                                  popup_no_url
    )
    
    popups <- mapply(fill_popup, 
                     popup_text = plotdata$popup_text,
                     url = plotdata$url, 
                     name = plotdata$name, 
                     address = plotdata$address) %>% 
      lapply(htmltools::HTML) %>%
      as.character()
    
    
    if (input$cluster == "cluster_on") {
      cluster_options <- markerClusterOptions()
    } else {
      cluster_options <- NULL
    }
    
    
    icons <- awesomeIcons(
      icon = "ios-close",
      iconColor = "black",
      library = "ion",
      markerColor = "blue"
    )
    
    leaflet() %>%
      addTiles() %>%
      addAwesomeMarkers(data = plotdata, ~lon, ~lat,
                        icon = icons,
                        label = labels,
                        labelOptions = labelOptions(
                          style = list("font-weight" = "normal", 
                                       padding = "3px 8px"),
                          textsize = "15px",
                          direction = "auto"),
                        popup = popups,
                        clusterOptions = cluster_options
      )
  })
  
  
  # About button -------------------------------------------------------
  
  about_link <- "<a href='https://www.davidlebovitz.com/new-york-restaurants-and-bakeries/' target='_blank'>David Lebovitz</a>"
  github_link <- "<a href='https://www.github.com' target='_blank'>GitHub</a>"
  about_text <- htmltools::HTML(
    paste0(
      "The data are from the blog of ", about_link, ". ", 
      "Many thanks to Mr. Lebovitz for testing all this great food and compiling ", 
      "the list of eateries. ",
      "</br></br>Although all the credit for the list goes to Mr. Lebovitz, any errors ", 
      "in this app are solely my own. Before visiting a location, ", 
      "please be sure to verify the information, as businesses often change.",
      "</br></br>Code available at ", github_link, "."
    )
  )
  
  observeEvent(input$about, {
    showModal(modalDialog(
      title = "About",
      easyClose = TRUE,
      about_text
    ))
  })
  
  
}





