
args = "data/exp3/exp3_12cleaners.csv"


if (length(args)==0) {
  stop("É necessario fornecer o arquivo para extrair dados", call.=FALSE)
} 

data = read.csv(args,  header=TRUE)

print(colnames(data))
print(colMeans(data["total.utility"]))


# medias para variação de sujeira inicial

lst <-  split(data, data$num.users)
Rscripout <- data.frame(amb_dirty = integer(0), utilidade = double(0),  qtd_sujeira = double(0))

out <- data.frame(x= numeric(0), y= integer(0), z = character(0))

for (i in 1:length(lst)) {
    
    tmp <- lst[[i]]
    #print(c(as.double(colMeans(tmp["total.utility"])), colMeans(tmp["dirty.percentage"])))
    #colnames(tmp) <- colnames(data)
    amb_dirty = as.integer(colMeans(tmp["num.users"]))
    util = as.double(colMeans(tmp["total.utility"]))
    dirty = as.double(colMeans(tmp["dirty.percentage"]))



    out = rbind(out, list(round(amb_dirty, 3), round(util, 3), round(dirty, 3)))
 	#out[i,] <- c(colMeans(tmp["total.utility"]), colMeans(tmp["dirty.percentage"]))
}
colnames(out) <- c("numero usuarios", "Utilidade", "Qtd Sujeira")
rownames(out) <- 1:nrow(out)


filename = gsub(".csv", "_means.csv", args)
print(filename)
write.csv2(out, file=filename)

