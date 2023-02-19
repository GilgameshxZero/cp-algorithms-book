from sys import stdin
admonition_active = None
fence_unindent = 0
for line in stdin:
    if admonition_active and not (line.startswith("    ") or line.startswith("\t")) and not len(line.strip()) == 0:
        print("\\End{admonition_" + admonition_active + "}")
        admonition_active = None
    if line.startswith("!!!") or line.startswith("???"):
        admonition_active = line.strip().split(" ")[1].lower()
        print("\\Begin{admonition_" + admonition_active + "}")
        continue

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
        elif admonition_active and line.startswith("\t"):
            line = line[1:]

    print(line, end='')
