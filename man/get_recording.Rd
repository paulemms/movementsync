% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_data.R
\name{get_recording}
\alias{get_recording}
\title{Get a meta-data recording object}
\usage{
get_recording(stem, fps, folder_in = "Original", path = "~/movementsync")
}
\arguments{
\item{stem}{recording identifier.}

\item{fps}{frames per second.}

\item{folder_in}{input folder relative to recording home (default is 'Original').}

\item{path}{recording home folder.}
}
\value{
a \code{Recording} object.
}
\description{
Get a meta-data recording object
}
\examples{
\dontrun{
r <- get_recording("NIR_ABh_Puriya", fps = 25)
}
}
\seealso{
Other data functions: 
\code{\link{apply_filter_sgolay}()},
\code{\link{get_data_points}()},
\code{\link{get_duration_annotation_data}()},
\code{\link{get_feature_data}()},
\code{\link{get_filtered_views}()},
\code{\link{get_joined_view}()},
\code{\link{get_metre_data}()},
\code{\link{get_onsets_selected_data}()},
\code{\link{get_processed_views}()},
\code{\link{get_processed_view}()},
\code{\link{get_raw_optflow_view}()},
\code{\link{get_raw_views}()},
\code{\link{get_raw_view}()},
\code{\link{get_sample_recording}()}
}
\concept{data functions}
