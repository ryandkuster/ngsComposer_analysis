
#####################################
##### pick platform and R1/R2 read
#####################################
rm(list = ls())
title = "Filtering Methods Comparison"
platform = "MiSeq"
setwd("/media/ceres/composer_covid_work/miseq/ref_alignment/")

# platform = "HiSeq125"
# setwd("/media/ceres/composer_covid_work/hiseq125/ref_alignment/")

# platform = "HiSeq250"
# setwd("/media/ceres/composer_covid_work/hiseq250/ref_alignment/")
# 
# 
# read = "R1"
read = "R2"

fail_file_rot = paste("./rotifer_results/count_failed.combined.",read,".scores.txt", sep = '')
pass_file_rot = paste("./rotifer_results/count_se.combined.",read,".scores.txt", sep = '')

failed_100 = paste("./krill_results/count_failed._p100q30_combined.",read,".scores.txt", sep = '')
failed_90 = paste("./krill_results/count_failed._p90q30_combined.",read,".scores.txt", sep = '')
failed_80 = paste("./krill_results/count_failed._p80q30_combined.",read,".scores.txt", sep = '')
failed_70 = paste("./krill_results/count_failed._p70q30_combined.",read,".scores.txt", sep = '')
failed_60 = paste("./krill_results/count_failed._p60q30_combined.",read,".scores.txt", sep = '')
failed_50 = paste("./krill_results/count_failed._p50q30_combined.",read,".scores.txt", sep = '')
failed_40 = paste("./krill_results/count_failed._p40q30_combined.",read,".scores.txt", sep = '')
failed_30 = paste("./krill_results/count_failed._p30q30_combined.",read,".scores.txt", sep = '')
failed_20 = paste("./krill_results/count_failed._p20q30_combined.",read,".scores.txt", sep = '')
failed_10 = paste("./krill_results/count_failed._p10q30_combined.",read,".scores.txt", sep = '')

se_100 = paste("./krill_results/count_se._p100q30_combined.",read,".scores.txt", sep = '')
se_90 = paste("./krill_results/count_se._p90q30_combined.",read,".scores.txt", sep = '')
se_80 = paste("./krill_results/count_se._p80q30_combined.",read,".scores.txt", sep = '')
se_70 = paste("./krill_results/count_se._p70q30_combined.",read,".scores.txt", sep = '')
se_60 = paste("./krill_results/count_se._p60q30_combined.",read,".scores.txt", sep = '')
se_50 = paste("./krill_results/count_se._p50q30_combined.",read,".scores.txt", sep = '')
se_40 = paste("./krill_results/count_se._p40q30_combined.",read,".scores.txt", sep = '')
se_30 = paste("./krill_results/count_se._p30q30_combined.",read,".scores.txt", sep = '')
se_20 = paste("./krill_results/count_se._p20q30_combined.",read,".scores.txt", sep = '')
se_10 = paste("./krill_results/count_se._p10q30_combined.",read,".scores.txt", sep = '')


#####################################################################rotifer first

rm(list = ls())
title = "Threshold Filtering on Reads Failing Motif Test"
platform = "MiSeq"
setwd("/media/ceres/composer_covid_work/miseq/ref_alignment/rotifer/")

# platform = "HiSeq125"
# setwd("/media/ceres/composer_covid_work/hiseq125/ref_alignment/")

# platform = "HiSeq250"
# setwd("/media/ceres/composer_covid_work/hiseq250/ref_alignment/rotifer")

# read = "R1"
read = "R2"

#FILES FROM ROTIFER FAILURE
# fail_file_rot = paste("./count_failed.combined.",read,".scores.txt", sep = '')
# pass_file_rot = paste("./count_se.combined.",read,".scores.txt", sep = '')

failed_100 = paste("./rotifer_then_krill_results/count_failed._p100q30_failed.combined.",read,".scores.txt", sep = '')
failed_90 = paste("./rotifer_then_krill_results/count_failed._p90q30_failed.combined.",read,".scores.txt", sep = '')
failed_80 = paste("./rotifer_then_krill_results/count_failed._p80q30_failed.combined.",read,".scores.txt", sep = '')
failed_70 = paste("./rotifer_then_krill_results/count_failed._p70q30_failed.combined.",read,".scores.txt", sep = '')
failed_60 = paste("./rotifer_then_krill_results/count_failed._p60q30_failed.combined.",read,".scores.txt", sep = '')
failed_50 = paste("./rotifer_then_krill_results/count_failed._p50q30_failed.combined.",read,".scores.txt", sep = '')
failed_40 = paste("./rotifer_then_krill_results/count_failed._p40q30_failed.combined.",read,".scores.txt", sep = '')
failed_30 = paste("./rotifer_then_krill_results/count_failed._p30q30_failed.combined.",read,".scores.txt", sep = '')
failed_20 = paste("./rotifer_then_krill_results/count_failed._p20q30_failed.combined.",read,".scores.txt", sep = '')
failed_10 = paste("./rotifer_then_krill_results/count_failed._p10q30_failed.combined.",read,".scores.txt", sep = '')

se_100 = paste("./rotifer_then_krill_results/count_se._p100q30_failed.combined.",read,".scores.txt", sep = '')
se_90 = paste("./rotifer_then_krill_results/count_se._p90q30_failed.combined.",read,".scores.txt", sep = '')
se_80 = paste("./rotifer_then_krill_results/count_se._p80q30_failed.combined.",read,".scores.txt", sep = '')
se_70 = paste("./rotifer_then_krill_results/count_se._p70q30_failed.combined.",read,".scores.txt", sep = '')
se_60 = paste("./rotifer_then_krill_results/count_se._p60q30_failed.combined.",read,".scores.txt", sep = '')
se_50 = paste("./rotifer_then_krill_results/count_se._p50q30_failed.combined.",read,".scores.txt", sep = '')
se_40 = paste("./rotifer_then_krill_results/count_se._p40q30_failed.combined.",read,".scores.txt", sep = '')
se_30 = paste("./rotifer_then_krill_results/count_se._p30q30_failed.combined.",read,".scores.txt", sep = '')
se_20 = paste("./rotifer_then_krill_results/count_se._p20q30_failed.combined.",read,".scores.txt", sep = '')
se_10 = paste("./rotifer_then_krill_results/count_se._p10q30_failed.combined.",read,".scores.txt", sep = '')



#####################################################################krill first

rm(list = ls())
title = "Motif Test on Reads Passing Threshold Filtering "
platform = "MiSeq"
setwd("/media/ceres/composer_covid_work/miseq/ref_alignment/rotifer/")

# platform = "HiSeq125"
# setwd("/media/ceres/composer_covid_work/hiseq125/ref_alignment/")

# platform = "HiSeq250"
# setwd("/media/ceres/composer_covid_work/hiseq250/ref_alignment/rotifer")

read = "R1"
# read = "R2"


failed_100 = paste("./krill_then_rotifer_results/count_failed.se._p100q30_combined.",read,".scores.txt", sep = '')
failed_90 = paste("./krill_then_rotifer_results/count_failed.se._p90q30_combined.",read,".scores.txt", sep = '')
failed_80 = paste("./krill_then_rotifer_results/count_failed.se._p80q30_combined.",read,".scores.txt", sep = '')
failed_70 = paste("./krill_then_rotifer_results/count_failed.se._p70q30_combined.",read,".scores.txt", sep = '')
failed_60 = paste("./krill_then_rotifer_results/count_failed.se._p60q30_combined.",read,".scores.txt", sep = '')
failed_50 = paste("./krill_then_rotifer_results/count_failed.se._p50q30_combined.",read,".scores.txt", sep = '')
failed_40 = paste("./krill_then_rotifer_results/count_failed.se._p40q30_combined.",read,".scores.txt", sep = '')
failed_30 = paste("./krill_then_rotifer_results/count_failed.se._p30q30_combined.",read,".scores.txt", sep = '')
failed_20 = paste("./krill_then_rotifer_results/count_failed.se._p20q30_combined.",read,".scores.txt", sep = '')
failed_10 = paste("./krill_then_rotifer_results/count_failed.se._p10q30_combined.",read,".scores.txt", sep = '')

se_100 = paste("./krill_then_rotifer_results/count_se.se._p100q30_combined.",read,".scores.txt", sep = '')
se_90 = paste("./krill_then_rotifer_results/count_se.se._p90q30_combined.",read,".scores.txt", sep = '')
se_80 = paste("./krill_then_rotifer_results/count_se.se._p80q30_combined.",read,".scores.txt", sep = '')
se_70 = paste("./krill_then_rotifer_results/count_se.se._p70q30_combined.",read,".scores.txt", sep = '')
se_60 = paste("./krill_then_rotifer_results/count_se.se._p60q30_combined.",read,".scores.txt", sep = '')
se_50 = paste("./krill_then_rotifer_results/count_se.se._p50q30_combined.",read,".scores.txt", sep = '')
se_40 = paste("./krill_then_rotifer_results/count_se.se._p40q30_combined.",read,".scores.txt", sep = '')
se_30 = paste("./krill_then_rotifer_results/count_se.se._p30q30_combined.",read,".scores.txt", sep = '')
se_20 = paste("./krill_then_rotifer_results/count_se.se._p20q30_combined.",read,".scores.txt", sep = '')
se_10 = paste("./krill_then_rotifer_results/count_se.se._p10q30_combined.",read,".scores.txt", sep = '')



# was last line





rm(list = ls())
title = "Why not?"
platform = "MiSeq"
setwd("")

read = "R1"
# read = "R2"

fail_file_rot = paste("/media/ceres/composer_covid_work/miseq/last_ditch_effort/alignment_files/count_failed.combined.R1.scores.txt", sep = '')
pass_file_rot = paste("/media/ceres/composer_covid_work/miseq/last_ditch_effort/alignment_files/count_se.combined.R1.scores.txt", sep = '')


failed_100 = paste("/media/ceres/composer_covid_work/miseq/last_ditch_effort/alignment_files/count_failed._p90q30_combined.R1.scores.txt", sep = '')
se_100 = paste("/media/ceres/composer_covid_work/miseq/last_ditch_effort/alignment_files/count_se._p90q30_combined.R1.scores.txt", sep = '')
failed_90= paste("/media/ceres/composer_covid_work/miseq/last_ditch_effort/alignment_files/count_failed._p90q30_trimmed_se.combined.R1.scores.txt", sep = '')
se_90 = paste("/media/ceres/composer_covid_work/miseq/last_ditch_effort/alignment_files/count_se._p90q30_trimmed_se.combined.R1.scores.txt", sep = '')



