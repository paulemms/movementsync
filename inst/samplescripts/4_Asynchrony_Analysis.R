# Introduces functions for calculating and summarising pairwise asynchronies
# from onset annotations.

rm(list=ls())
gc()
if (dev.cur() > 1) dev.off()
library(movementsync)
library(GGally)

# Splices based on OnsetSelected object
r1 <- get_recording("NIR_ABh_Puriya", fps = 25)
o1 <- get_onsets_selected_data(r1)
autoplot(o1)
r2 <- get_recording("NIR_DBh_Malhar_2Gats", fps = 25)
o2 <- get_onsets_selected_data(r2)
autoplot(o2)
r3 <- get_recording("NIRP1_MAK_Jaun", fps = 25)
o3 <- get_onsets_selected_data(r3)
autoplot(o3, instrument = 'Onset')
r4 <- get_recording("NIRP1_VS_Hams", fps = 25)
o4 <- get_onsets_selected_data(r4)
autoplot(o4, instrument = 'Onset')
r5 <- get_recording("Gagaku_5_Juha", fps = 60)
o5 <- get_onsets_selected_data(r5)
autoplot(o5, instrument = 'Hichiriki', tactus = 'SD_T')

instruments <- c("Shoko_L", "Shoko_R", "Taiko", "Kakko", "Kakko_1", "So", "Biwa",
                 "Ryuteki", "Hichiriki", "Sho", "Biwa_RW", "Shoko_RW", "Taiko_LW",
                 "Taiko_RW")

# Difference in onsets for each instrument pair
instruments1 <- c('Inst', 'Tabla')
po1 <- difference_onsets(o1, instrument = instruments1)
pair_pos1 <- get_pair_columns(po1, 'Inst-Tabla', instruments1, add_metre = TRUE)
ggpairs(po1, columns = pair_pos1, aes(colour = Metre)) + pairs_title(r1)

po2 <- difference_onsets(o2, instrument = instruments1)
pair_pos2 <- get_pair_columns(po2, 'Inst-Tabla', instruments1, add_metre = TRUE)
ggpairs(po2, columns = pair_pos2, aes(colour = Metre)) + pairs_title(r2)

po5 <- difference_onsets(o5, instrument = instruments)
instrument_pairs <- c('Shoko_L-Shoko_R', 'Shoko_L-Taiko', 'Shoko_L-Kakko')
pair_pos5 <- get_pair_columns(po5, instrument_pairs, instruments)
ggpairs(po5, columns = pair_pos5) + pairs_title(r5) # only one Metre in plot

# Partially match instrument names
pair_pos6 <- get_pair_columns(po5, "-So", instruments, partial = TRUE)
ggpairs(po5, columns = pair_pos6) + pairs_title(r5)

# Summary of difference in onsets (allows segmentation via splicing_dfr argument)
summary_dfr <- summary_onsets(o5, r5, instruments = instruments,
                              show_plot = TRUE, filter_pair = 'T') # note the filter
# Reduce number of x-labels
summary_dfr <- summary_onsets(o5, r5, instruments = instruments,
                              show_plot = TRUE, filter_pair = 'T', time_breaks = 3)


# Splice the processed onsets for summarisation on segments
d5 <- get_duration_annotation_data(r5)
splicing_section_dfr <- splice_time(d5, tier = 'Section')
segmented_po <- difference_onsets(o5, instruments = instruments, splicing_dfr = splicing_section_dfr)
head(segmented_po)
pair_seg_pos1 <- get_pair_columns(segmented_po, instrument_pairs, instruments1)
ggpairs(segmented_po, columns = pair_seg_pos1, aes(colour = Segment)) +
  pairs_title(r5)
pair_seg_pos2 <- get_pair_columns(segmented_po, instrument_pairs, instruments1, add_segment = TRUE)
ggpairs(segmented_po, columns = pair_seg_pos2, aes(colour = Segment)) +
  pairs_title(r5)
pair_seg_pos3 <- get_pair_columns(segmented_po, instrument_pairs, instruments1, add_ref_beat_time = TRUE)
ggpairs(segmented_po, columns = pair_seg_pos3, aes(colour = Segment)) +
  pairs_title(r5)

# Calculate summary statistics on the segments from splice
summary_segmented_dfr <- summary_onsets(o5, r5, instruments = instruments, splicing_section_dfr,
                                        show_plot = TRUE, filter_pair = 'K.*-S')
summary_segmented_dfr

# Summary for r1 of onset differences using splice from annotation data
d1 <- get_duration_annotation_data(r1)
splicing_tabla_solo_df <- splice_time(d1, tier = 'Event', comments = 'tabla solo')
summary_onsets(o1, r1, instruments = c('Inst', 'Tabla'),
               splicing_dfr = splicing_tabla_solo_df, show_plot = TRUE)

# Summary for r5 of onset differences using splice from annotation data
summary_onsets(o5, r5, instruments = instruments, splicing_section_dfr, filter_pair = "Taiko-",
               show_plot = TRUE)

# Summary for r5 of onsets differences on third beat
summary_onsets(o5, r5, instruments = instruments, splicing_section_dfr,
               expr = SD_T == 3, show_plot = TRUE)

