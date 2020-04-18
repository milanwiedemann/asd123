#' Create variable names
#'
#' @param var_name String, specifying the variable name.
#' @param str String, specifying the suffix to be added after the \code{var_name}.
#' @param n Numeric, specifying the number of variables.
#' @param sep String, specifying the seperatpr between \code{var_name} and \code{str}.
#' @param unlist Logical, specifying whether a list or vactor should be returned.
#'
#' @return
#' @export
#'
#' @examples
create_var_names <- function(var_name, str = "s", n, sep = "_", unlist = FALSE) {
  
  # Create string with variable names inclusing session ---
  return_list <- purrr::map2(.x = base::rep(base::paste(var_name, str, sep = "_"), n), .y = 1:n, .f = base::paste0)

  # Unlist argument ----
  # No functionality to use names
  if (unlist == TRUE) {
    unlist(return_list, use.names = FALSE)
  } else if (unlist == FALSE) {
    return_list
  }
}

#' Add further specifications to variable names
#'
#' @param var_names List or vector of variable names 
#' @param str 
#' @param n 
#' @param sort 
#' @param name_index 
#' @param unlist 
#'
#' @return
#' @export
#'
#' @examples
add_specifier <- function(var_names, str = "i", n, sort = c("previous", "current"), name_index = FALSE, unlist = FALSE) {
  
  # Check input of sort arguemtn
  sort <- base::match.arg(sort)
  
  # Count length of input
  # I need to change this so it can also count vectors within lists
  n_varnames <- length(var_names)
  
  # Add string ----
  str_temp <- purrr::map2(.x = base::rep(base::paste(var_names, str, sep = "_"), n), .y = rep(1:n, each = n_varnames), .f = base::paste0)
  str_temp <-  base::unlist(str_temp, use.names = FALSE)
  
  # Create list 1 ----
  # one element per list for n_varnames
  return_list_1 <- list()

  # Create list 1 ----
  for (i in seq_along(1:n_varnames)) {

    if (name_index == FALSE) {
      return_list_1[[i]] <- str_temp[seq(1 + (i - 1), length(str_temp), by = n_varnames)]
    } else if (name_index == TRUE) {
      return_list_1[[paste0(var_name, "_", str1, i)]] <- str_temp[seq(1 + (i - 1), length(str_temp), by = n_varnames)]
    }
  }

  # Create list 2 ----
  # one element per list for each n
  return_list_2 <- list()

  for (i in seq_along(1:n)) {
    if (name_index == FALSE) {
      return_list_2[[i]] <- str_temp[seq(1, length(str_temp), by = n_varnames)[i]:(seq(1, length(str_temp), by = n_varnames)[i] + n_varnames - 1)]
    } else if (name_index == TRUE) {
      return_list_2[[paste0(var_name, "_", str2, i)]] <- str_temp[seq(1, length(str_temp), by = n_varnames)[i]:(seq(1, length(str_temp), by = n_varnames)[i] + n_varnames - 1)]
    }
  }

  # Sort argument ----
  # Return list sorted by n_varnames or n
  # Depending on unlist argument each sort element will be a separate list
  if (sort == "previous") {
    return_list <- return_list_1
  } else if (sort == "current") {
    return_list <- return_list_2
  }

  # Unlist argument ----
  # No functionality to use names
  if (unlist == TRUE) {
    unlist(return_list, use.names = FALSE)
  } else if (unlist == FALSE) {
    return_list
  }
}