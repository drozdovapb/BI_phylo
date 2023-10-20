import requests          
import pylab             
from io import StringIO  
from Bio import Phylo    

import random
from ete3 import Tree, TreeStyle
##pip3 install --user PyQt5 ete3


raw_tree = StringIO(requests.get('https://www.jasondavies.com/tree-of-life/life.txt').text)
tree1 = Phylo.read(raw_tree, "newick")   

Phylo.draw_ascii(tree1)

Phylo.draw(tree1, do_show=False)

matplotlib.pyplot.savefig("py_tree1_phylo.svg",  branch_labels=lambda x: x.branch_length)
matplotlib.pyplot.savefig("py_tree1_phylo.png")

tree1 = tree1.as_phyloxml()
Phylo.write(tree1, "tree1.xml", "phyloxml")


#Phylo.draw_graphviz(tree1) #networkx

tree1.clade[0, 1].color = "blue"
matplotlib.rc('font', size=1)
matplotlib.pyplot.figure(figsize=(24,12))
Phylo.draw(tree1, do_show = False)
matplotlib.pyplot.savefig("py_tree1_phylo_blue.png", dpi=600)


raw_tree = requests.get('https://www.jasondavies.com/tree-of-life/life.txt').text
tree2 = Tree(raw_tree, format=1)


tree2.render("py_tree2_ete3.pdf")

circular_style = TreeStyle()
circular_style.mode = "c"
circular_style.scale = 20
tree2.render("py_tree2_ete3_circ.pdf", tree_style=circular_style)

ss = random.sample(tree2.get_leaf_names(), 42)
tree2.prune(ss)
tree2.render("py_tree2_ete3_random.pdf")

ts = TreeStyle()
ts.branch_vertical_margin = 15

nstyle = NodeStyle()
nstyle["shape"] = "square"
nstyle["size"] = 5 
nstyle["fgcolor"] = "lightblue"
for leaf in tree2.traverse(): 
   leaf.set_style(nstyle)

tree2.render("py_tree2_ete3_random_improved.png", tree_style=ts)

