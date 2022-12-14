% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wavelet.R
\name{plot_cwt_energy}
\alias{plot_cwt_energy}
\title{Plot cross wavelet energy of a wavelet object}
\usage{
plot_cwt_energy(obj, view)
}
\arguments{
\item{obj}{analyze.wavelet object.}

\item{view}{View object.}
}
\value{
a ggplot object.
}
\description{
Plot cross wavelet energy of a wavelet object
}
\examples{
r <- get_sample_recording()
rv <- get_raw_view(r, "Central", "", "Sitar")
pv <- get_processed_view(rv)
co <- analyze_coherency(pv, columns = c("Nose_x", "Nose_y"))
plot_cwt_energy(co, pv)
}
\seealso{
Other wavelet functions: 
\code{\link{analyze_coherency}()},
\code{\link{analyze_wavelet}()},
\code{\link{get_local_max_average_power}()},
\code{\link{plot_average_coherency}()},
\code{\link{plot_average_power}()},
\code{\link{plot_cross_spectrum}()},
\code{\link{plot_phase_difference}()},
\code{\link{plot_power_spectrum}()},
\code{\link{plot_roll_resultant_length}()},
\code{\link{plot_sel_phases}()},
\code{\link{plot_wt_energy}()}
}
\concept{wavelet functions}
