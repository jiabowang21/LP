class Tree:
    def __init__(self, x):
        self.rt = x
        self.child = []

    def add_child(self, a):
        self.child.append(a)

    def root(self):
        return self.rt

    def ith_child(self, i):
        return self.child[i]

    def num_children(self):
        l = len(self.child)
        for node in self.child:
            l += node.num_children()
        return l

class Pre(Tree):
    def preorder(self):
        R = [self.rt]
        for node in self.child:
            R += node.preorder()
        return R
"""
t = Pre(2)
t.add_child(Pre(3))
t.add_child(Pre(4))
print(t.num_children())
t.ith_child(1).add_child(Pre(5))
print(t.preorder())
"""