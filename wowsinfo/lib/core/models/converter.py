'''
This helps to check if the object isn't null before creating any new objects
'''
import glob
import re
from os import path as p

def convert(line):
    if ("!= null" in line or "as" in line or "cast" in line or "map" in line or "=>" in line or "{" in line or not "=" in line):
        return line
    else:
        m = re.search(r'\((.*)\);$', line)
        if m == None:
            return line
        return '    if ({} != null) {}'.format(m.group(1), line.lstrip())

# example = "this.nextShip = NextShip(json['next_ships']);"
# print(convert(example))

def convertAll(path):
    for d in glob.glob(path, recursive=True):
        with open(d, 'r') as f:
            # save all lines
            lines = []
            for line in f.readlines():
                lines.append(convert(line))
            with open(d, 'w') as w:
                w.writelines(lines)

convertAll('**/*.dart')
