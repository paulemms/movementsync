# functions to get recordings from OSF


#' List available recordings for movementsync from OSF
#'
#' @param node OSF node for movementsync.
#'
#' @return character vector of stem names
#' @export
#'
#' @examples
#' \dontrun{
#' list_osf_recordings()
#' }
list_osf_recordings <- function(node) {
  movementsync_project <- osfr::osf_retrieve_node(node)
  movementsync_files <- osfr::osf_ls_files(movementsync_project)
  file_names <- basename(movementsync_files$name)
  zip_files <- file_names[grepl('(.*)\\.zip$', file_names)]
  stem_names <- substr(zip_files, 1, nchar(zip_files) - 4)

  stem_names
}


#' Opens movementsync data home page at OSF
#'
#' @param node OSF node for movementsync.
#'
#' @export
open_movementsync_data <- function(node) {
  movementsync_project <- osfr::osf_retrieve_node(node)
  osfr::osf_open(movementsync_project)
}


#' Get movementsync recording from OSF
#'
#' @param stems vector of zip file stem(s).
#' @param node OSF node for movementsync.
#' @param to_dir directory to copy to (default is "~/movementsync/Original").
#' @param overwrite overwriting existing dataset files?
#'
#' @return invisible vector of downloaded CSV file names.
#' @export
#'
#' @examples
#' \dontrun{
#' get_osf_recordings()
#' }
get_osf_recordings <- function(stems, node, to_dir = "~/movementsync/Original",
                               overwrite = FALSE) {

  # Find the zip to download
  movementsync_project <- osfr::osf_retrieve_node(node)
  movementsync_files <- osfr::osf_ls_files(movementsync_project)
  zip_files <- paste0(stems, '.zip')
  matches <- match(zip_files, movementsync_files$name, nomatch = 0)
  ms_file <- movementsync_files[matches, ]
  found_stems <- stems[matches != 0]
  if (nrow(ms_file) == 0) stop(paste('Cannot find recording(s)',
                                     paste0(stems, collapse = ", "), 'at OSF'))
  if (any(matches == 0)) warning(paste('Cannot find recording(s)',
                                       paste0(stems[matches==0], collapse = ", "), 'at OSF'))

  message("Downloading recording(s) ", paste(found_stems, collapse = ", "), ' ...')
  downloaded_files <- osfr::osf_download(ms_file, conflicts = 'overwrite',
                                         path = tempdir())

  # Download zips to a temp directory
  unzipped_files <- c()
  for (j in seq_len(nrow(ms_file))) {
    stem <- found_stems[j]
    local_path <- downloaded_files$local_path[j]

    # Check the files don't already exist locally
    csv_files <- basename(utils::unzip(local_path, list = TRUE)$Name)
    if (!dir.exists(to_dir)) dir.create(to_dir, recursive = TRUE)
    if (any(file.exists(file.path(to_dir, csv_files))) && !overwrite) {
      warning(paste('Recording', stem, 'not downloaded because it already exists locally.
                    Use overwrite = TRUE to copy over existing local recordings.'))
      next
    }

    message(paste("Unzipping recording", stem, '...'))
    unzipped_files <- c(
      unzipped_files,
      utils::unzip(local_path, exdir = to_dir, junkpaths = TRUE)
    )
    message(paste('Saved', stem, 'to', to_dir))
  }

  invisible(unzipped_files)
}
