# functions.R


fill_popup <- function(popup_text, url, name, address) {
  
  if (url != "") {
    result <- sprintf(
      popup_text,
      url, name, address)
  } else {
    result <- sprintf(
      popup_text,
      name, address)
  }
  return (result)
}