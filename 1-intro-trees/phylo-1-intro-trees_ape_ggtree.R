library(ape)

simpletree <- read.tree(text = "(((A,B), (C,D)), E);")
plot.phylo(simpletree)

png("simpletree.png")
plot.phylo(simpletree)
dev.off()

svg("simpletree.svg", width = 4, height = 4)
plot.phylo(simpletree)
dev.off()

treeoflife <- read.tree("https://www.jasondavies.com/tree-of-life/life.txt")

plot.phylo(treeoflife)
plot(treeoflife)

png(filename = "treeOfLife.png", width = 20, height = 20, units = "cm", res = 600)
plot.phylo(treeoflife, cex = 0.2)
dev.off()

plot.phylo(treeoflife, type = "unrooted", no.margin = T)
plot.phylo(treeoflife, type = "radial")


library(ggtree)

#treeoflife_text <- readLines("https://www.jasondavies.com/tree-of-life/life.txt")
#treeoflife <- ggtree::read.tree(text = treeoflife_text)

ggtree(treeoflife)

ggtree(treeoflife) + geom_tiplab(size = 1)

ggtree(treeoflife) + layout_circular() + geom_tiplab(size = 2) 
ggtree(treeoflife) + geom_tiplab(size = 2) + layout_circular()

is.human <- treeoflife$tip.label == "Homo_sapiens"


#which(treeoflife$tip.label == "Homo_sapiens")
#

treeoflife <- groupOTU(treeoflife, c("Homo_sapiens", "Pan_troglodytes"))
ggtree(treeoflife) + layout_circular() + 
  geom_tiplab2(size = 2) + geom_tippoint(aes(alpha = group), col = "red") + 
  scale_color_manual(values = c(0,1), aesthetics = "alpha") +
  theme(legend.position = 'null')


ggtree(treeoflife) + layout_circular() + geom_tiplab(size = 2) + 
  geom_text2(aes(subset=!isTip, label=node), size = 3, col = "red")
ggtree(treeoflife) + layout_circular() + geom_tiplab2(size = 2) + 
  geom_hilight(node = 219, fill = "gold") + 
  geom_cladelabel(node = 219, label = "Here", fontsize = 2, offset = 1)
