# Jozias Martini
# Assembly with stack architecture
# Solve: S = ((A - C) * D) / (C - B)

push c
push b
sub
push a
push c
sub
push d
mul
div
