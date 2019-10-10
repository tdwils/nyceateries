# ui.R


ui <- fluidPage(
  includeCSS("www/style.css"),
  dashboardPage(skin = "blue",
                dashboardHeader(disable = FALSE, 
                                title = 'New York City Eateries', 
                                titleWidth = 250),
                dashboardSidebar(
                  disable = FALSE, width = 250,
                  tags$div(id = "map_sidebar",
                           tags$div(
                             uiOutput("type_menu"),
                             radioButtons(inputId = "cluster",
                                          label = "Clusters",
                                          choices = c("Off" = "cluster_off",
                                                      "On" = "cluster_on"
                                          ),
                                          inline = TRUE)
                           ),
                           tags$div(id = "sidebar_text", class = "sidebar-text",
                                    h3("Instructions"),
                                    p("Hover over symbol for name."),
                                    p("Click for hyperlink and address."),
                                    p("Use mouse to pan and zoom."),
                                    br(),
                                    br()
                           ),
                           actionBttn(
                             inputId = "about",
                             label = "About",
                             color = "success",
                             style = "gradient",
                             size = "sm"
                           )
                  )
                ),
                dashboardBody(class = 'clearfix',
                              leafletOutput("eatery_map", height=600) %>% 
                                withSpinner(type = 8, size = 0.5)
                ) # END OF DASHBOARD BODY
  ) # END OF DASHBOARD PAGE
) # END OF FLUID PAGE

