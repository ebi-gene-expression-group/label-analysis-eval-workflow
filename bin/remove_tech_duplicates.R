#!/usr/bin/env Rscript
suppressPackageStartupMessages(require(optparse))
suppressPackageStartupMessages(require(workflowscriptscommon))

option_list = list(
    make_option(
        c("-i", "--input-metadata"),
        action = "store",
        default = NA,
        type = 'character',
        help = "Metadata file containing technical replicates"
    ),
    make_option(
        c("-c", "--barcode-col-ref"),
        action = "store",
        default = "cell_id",
        type = 'character',
        help = "Name of column containing cell barcodes"
    ),
    make_option(
    c("-o", "--output-file"),
    action = "store",
    default = NA,
    type = 'character',
    help = "Filtered metadata file in text fomat"
    )
)

opt = wsc_parse_args(option_list, mandatory = c("input_metadata", "output_file"))
metadata = read.table(opt$input_metadata, sep = "\t", header = TRUE)
# remove technical duplicate rows
metadata = metadata[which(!duplicated(metadata[, opt$barcode_col_ref])), ]
# write metadata file
write.table(metadata, file = opt$output_file, sep = "\t", row.names = FALSE)
