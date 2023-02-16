from sys import stdin
admonition_active = False
fence_unindent = 0
for line in stdin:
    if line.startswith("\\begin{admonition_"):
        admonition_active = True
    elif line.startswith("\\end{admonition_"):
        admonition_active = False
    elif line.strip().startswith("```") and not line.strip().endswith("```"):
        fence_unindent = line.find("`")
        line = line[fence_unindent:]
    elif line.strip().startswith("```") and line.strip().endswith("```"):
        line = line[fence_unindent:]
        fence_unindent = 0
    else:
        if fence_unindent > 0:
            line = line[fence_unindent:]
        elif admonition_active and line.startswith("    "):
            line = line[4:]

    print(line, end='')
