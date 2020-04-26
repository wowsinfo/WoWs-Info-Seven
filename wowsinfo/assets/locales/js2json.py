'''
Convert JavaScript object to JSON format
'''

js = '''

'''

json = ''
for line in js.split('\n'):
    if '// ' in line:
        continue
    section = line.split(':')
    if len(section) > 1:
        json += '"{}":{}\n'.format(section[0].strip(), section[1].replace("'", '"'))
print(json)