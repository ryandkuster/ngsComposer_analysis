### data
Four datasets were used for all analyses in the ngsComposer manuscript:

|platform|raw reads|demultiplexed reads|read length (raw)|read length for flush|R1 motif|R2 motif|
|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|
|miseq|1,033,607|835,261|251|235|TGCAT|CATG|
|hiseq 2500 high output|171,348,767|156,472,029|125|110|TCC,TCT|TCC,TCT|
|miseq 2500 rapid run|146,334,725|122,317,249|250|235|TCC,TCT|TCC,TCT|
|novaseq 6000|1,081,428,289|942,382,399|151|135|TGCAT|CATG|

### directory structure
- analyses/
  - adapter_trimming/
  - barcode_assignment/
  - empirical_barcodes/
  - pipeline/
  - unique_filtering/
- misc/
- README.md
