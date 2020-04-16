#' Title
#'
#' @param var_name 
#' @param str1 
#' @param n1 
#' @param str2 
#' @param n2 
#' @param sort 
#' @param name_index 
#' @param unlist 
#'
#' @return
#' @export
#'
#' @examples
create_var_names2 <- function(var_name, str1 = "s", n1, str2 = "i", n2, sort = c("str1", "str2"), name_index = FALSE, unlist = FALSE) {
  
  # sort = c("previous", "current"), sort = c("base", "addition")
  sort <- base::match.arg(sort)
  
  # Create string with variable names inclusing session ---
  str1_temp <- purrr::map2(.x = base::rep(base::paste(var_name, str1, sep = "_"), n1), .y = 1:n1, .f = base::paste0)
  str1_temp <-  base::unlist(str1_temp, use.names = FALSE)
  
  # Add items ----
  # This should be a separate function so it could be applied outside of this function to add items, or whatever to the end of the sting to a list
  # something like add_str() or add_suffix() or add_specifier()
  str2_temp <- purrr::map2(.x = base::rep(base::paste(str1_temp, str2, sep = "_"), n2), .y = rep(1:n2, each = n1), .f = base::paste0)
  str2_temp <-  base::unlist(str2_temp, use.names = FALSE)
  
  # Create list 1 ----
  # one element per list for n1
  return_list_1 <- list()
  
  # Create list 1 ----
  for (i in seq_along(1:n1)) {
    
    if (name_index == FALSE) {
      return_list_1[[i]] <- str2_temp[seq(1 + (i - 1), length(str2_temp), by = n1)]
    } else if (name_index == TRUE) {
      return_list_1[[paste0(var_name, "_", str1, i)]] <- str2_temp[seq(1 + (i - 1), length(str2_temp), by = n1)]
    }
  }
  
  # Create list 2 ----
  # one element per list for each n2
  return_list_2 <- list()
  
  for (i in seq_along(1:n2)) {
    if (name_index == FALSE) {
      return_list_2[[i]] <- str2_temp[seq(1, length(str2_temp), by = n1)[i]:(seq(1, length(str2_temp), by = n1)[i] + n1 - 1)]
    } else if (name_index == TRUE) {
      return_list_2[[paste0(var_name, "_", str2, i)]] <- str2_temp[seq(1, length(str2_temp), by = n1)[i]:(seq(1, length(str2_temp), by = n1)[i] + n1 - 1)]
    }
  }
  
  # Sort argument ----
  # Return list sorted by n1 or n2
  # Depending on unlist argument each sort element will be a separate list
  if (sort == "str1") {
    return_list <- return_list_1
  } else if (sort == "str2") {
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







#' Title
#'
#' @param var_name 
#' @param str 
#' @param n 
#'
#' @return
#' @export
#'
#' @examples
create_var_names <- function(var_name, str = "s", n, unlist = FALSE) {
  
  
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





#' Title
#'
#' @param varnames 
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
  
  n_varnames <- length(var_names)
  # sort = c("previous", "current"), sort = c("base", "addition")
  # sort <- base::match.arg(sort)
  # 
  # # Create string with variable names inclusing session ---
  # str1_temp <- purrr::map2(.x = base::rep(base::paste(var_name, str1, sep = "_"), n1), .y = 1:n1, .f = base::paste0)
  # str1_temp <-  base::unlist(str1_temp, use.names = FALSE)
  
  # Add items ----
  # This should be a separate function so it could be applied outside of this function to add items, or whatever to the end of the sting to a list
  # something like add_str() or add_suffix() or add_specifier()
  str2_temp <- purrr::map2(.x = base::rep(base::paste(var_names, str, sep = "_"), n), .y = rep(1:n, each = n_varnames), .f = base::paste0)
  str2_temp <-  base::unlist(str2_temp, use.names = FALSE)
  
  
  # str2_temp
  
  # Create list 1 ----
  # one element per list for n_varnames
  return_list_1 <- list()

  # Create list 1 ----
  for (i in seq_along(1:n_varnames)) {

    if (name_index == FALSE) {
      return_list_1[[i]] <- str2_temp[seq(1 + (i - 1), length(str2_temp), by = n_varnames)]
    } else if (name_index == TRUE) {
      return_list_1[[paste0(var_name, "_", str1, i)]] <- str2_temp[seq(1 + (i - 1), length(str2_temp), by = n_varnames)]
    }
  }

  # Create list 2 ----
  # one element per list for each n
  return_list_2 <- list()

  for (i in seq_along(1:n)) {
    if (name_index == FALSE) {
      return_list_2[[i]] <- str2_temp[seq(1, length(str2_temp), by = n_varnames)[i]:(seq(1, length(str2_temp), by = n_varnames)[i] + n_varnames - 1)]
    } else if (name_index == TRUE) {
      return_list_2[[paste0(var_name, "_", str2, i)]] <- str2_temp[seq(1, length(str2_temp), by = n_varnames)[i]:(seq(1, length(str2_temp), by = n_varnames)[i] + n_varnames - 1)]
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