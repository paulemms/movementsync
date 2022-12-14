% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wavelet.R
\name{plot_cross_spectrum}
\alias{plot_cross_spectrum}
\alias{plot_coherence}
\title{Plot a coherency of a wavelet object}
\usage{
plot_cross_spectrum(obj, view, ...)

plot_coherence(obj, view, ...)
}
\arguments{
\item{obj}{analyze.coherency object.}

\item{view}{View object.}

\item{...}{passed to \code{\link[WaveletComp:wc.image]{WaveletComp::wc.image()}}.}
}
\value{
a list of class \verb{graphical parameters},
}
\description{
Plot a coherency of a wavelet object
}
\examples{
r <- get_sample_recording()
rv <- get_raw_view(r, "Central", "", "Sitar")
pv <- get_processed_view(rv)
pv1 <- subset(pv, Time >= 10)
co <- analyze_coherency(pv1, c("Nose_x", "Nose_y"))
plot_cross_spectrum(co, pv1)
plot_coherence(co, pv1)
}
\seealso{
Other wavelet functions: 
\code{\link{analyze_coherency}()},
\code{\link{analyze_wavelet}()},
\code{\link{get_local_max_average_power}()},
\code{\link{plot_average_coherency}()},
\code{\link{plot_average_power}()},
\code{\link{plot_cwt_energy}()},
\code{\link{plot_phase_difference}()},
\code{\link{plot_power_spectrum}()},
\code{\link{plot_roll_resultant_length}()},
\code{\link{plot_sel_phases}()},
\code{\link{plot_wt_energy}()}
}
\concept{wavelet functions}
