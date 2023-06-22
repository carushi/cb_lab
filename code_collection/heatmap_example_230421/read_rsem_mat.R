require(pheatmap)

for (count in c("TPM", "FPKM")) {
    df <- NULL
    for (i in 1:dim(s2c)[1]) {
        path <- s2c[i,3]
        mat <- read.table(path, header=T, sep="\t")
        rownames(mat) <- mat$gene_id
        print(head(mat))
        if (is.null(df)) {
            df <- data.frame(mat[,count])
            rownames(df) <- as.character(mat$gene_id)
            colnames(df) <- s2c[i,1]
        } else {
            tmat <- data.frame(mat[,count])
            rownames(tmat) <- as.character(mat$gene_id)
            colnames(tmat) <- s2c[i,1]
            df <- merge(df, tmat, by=0, all=TRUE, suffixes=c('', ''))
            rownames(df) <- df$Row.names
            df <- df[,-c(1)]
        }
        print(head(df))
    }
    gene_max = 20
    annotation = data.frame(Genotype=c(1, 1, 2, 2))
    rownames(annotation) = s2c[,1]
    pheatmap(log10(df[order(rowMeans(df), decreasing=TRUE) < gene_max,]+1), color = colorRampPalette(c("royalblue", "white", "firebrick3"))(100), filename=paste0('heatmap_', count, '.png'), cluster_row=TRUE, cluster_col=TRUE)
    pheatmap(log10(df[order(rowMeans(df), decreasing=TRUE) < gene_max,]+1), color = colorRampPalette(c("royalblue", "white", "firebrick3"))(100), filename=paste0('heatmap_', count, '_annot.png'), cluster_row=TRUE, cluster_col=TRUE, annotation_col=annotation)
    print(list.files())
}
