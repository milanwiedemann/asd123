#' Create variable names
#'
#' @param var_name String, specifying the variable name.
#' @param str String, specifying the suffix to be added after the \code{var_name}.
#' @param n Numeric, specifying the number of variables.
#' @param sep String, specifying the separator between \code{var_name} and \code{str}.
#' @param unlist Logical, specifying whether a "list" or "vector" should be returned.
#'
#' @return
#' @export
#'
#' @examples
create_var_names <- function(var_name, str = "s", n, sep = "_", unlist = FALSE) {

  # Create string with variable names including session ---
  var_names_list <- purrr::map2(.x = base::rep(base::paste(var_name, str, sep = sep), n), .y = 1:n, .f = base::paste0)

  # Unlist argument ----
  # No functionality to use names
  if (unlist == TRUE) {

    var_names_unlist <- unlist(var_names_list, use.names = FALSE)

    class(var_names_unlist) <- c("character") # create_varnames

    return(var_names_unlist)

  } else if (unlist == FALSE) {

    class(var_names_list) <-  c("character") # create_varnames

    return(var_names_list)

  }
}

#' Add further specifications to variable names
#'
#' @param var_names List or vector of variable names created using the \code{\link[varnames]{create_var_names}} function
#' @param str String, specifying the suffix to be added after the input string from \code{var_names}.
#' @param n Numeric, specifying the number of variables.
#' @param sep String, specifying the sep between  string from \code{var_names} and \code{str}.
#' @param sort String, specifying whether to arrange the output based on the \code{"previous"} or \code{"current"} function.
#' @param unlist Logical, specifying whether a "list" or "vector" should be returned.
#'
#' @return
#' @export
#'
#' @examples
add_specifier <- function(var_names, str = "i", n, sep = "_", sort = c("previous", "current"), unlist = FALSE) {

  # Think about name index functionality, see commented out loops later
  # name_index = FALSE

  # First test if a specifier was already added
  # if (inherits(var_names, "varnames_and_specifier") == TRUE) {
  #   stop("Only one specifier can be added.", call. = FALSE)
  # }
  #
  # # Next test if  var_names was created with create_var_names() function
  # if (inherits(var_names, "create_varnames") == FALSE) {
  #   stop("Object specified in 'var_names' was not created using 'create_var_names()' function.", call. = FALSE)
  # }

  # Check input of sort arguemtn
  sort <- base::match.arg(sort)

  # Count length of input
  # I need to change this so it can also count vectors within lists
  n_varnames <- length(var_names)

  # Add string ----
  str_temp <- purrr::map2(.x = base::rep(base::paste(var_names, str, sep = sep), n), .y = rep(1:n, each = n_varnames), .f = base::paste0)
  str_temp <-  base::unlist(str_temp, use.names = FALSE)

  # Create list 1 ----
  # one element per list for n_varnames
  return_list_1 <- list()

  # Create list 1 ----
  for (i in seq_along(1:n_varnames)) {

    # if (name_index == FALSE) {
      return_list_1[[i]] <- str_temp[seq(1 + (i - 1), length(str_temp), by = n_varnames)]
    # } else if (name_index == TRUE) {
      # return_list_1[[paste0(var_name, sep, str1, i)]] <- str_temp[seq(1 + (i - 1), length(str_temp), by = n_varnames)]
    # }
  }

  # Create list 2 ----
  # one element per list for each n
  return_list_2 <- list()

  for (i in seq_along(1:n)) {
    # if (name_index == FALSE) {
      return_list_2[[i]] <- str_temp[seq(1, length(str_temp), by = n_varnames)[i]:(seq(1, length(str_temp), by = n_varnames)[i] + n_varnames - 1)]

    # } else if (name_index == TRUE) {
      # return_list_2[[paste0(var_name, sep, str2, i)]] <- str_temp[seq(1, length(str_temp), by = n_varnames)[i]:(seq(1, length(str_temp), by = n_varnames)[i] + n_varnames - 1)]
    # }
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

    return_unlist <- unlist(return_list, use.names = FALSE)

    class(return_unlist) <- c("character") #varnames_and_specifier

    return(return_unlist)

  } else if (unlist == FALSE) {

    class(return_list) <- c("character") #varnames_and_specifier

    return(return_list)

  }
}
