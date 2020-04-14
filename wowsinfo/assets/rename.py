import os, glob

'''
Replace string with another string, like replace xxx@2x.png with xxx.png
'''

def replaceFileNameFromPath(path: str, findStr: str, replaceStr: str):
    for f in glob.glob(path):
        if findStr in f:
            os.rename(f, f.replace(findStr, replaceStr))
        else:
            os.rename(f, f.lower())

# replace @2x and @3x from the folder
replaceFileNameFromPath('images/*', '@2x', '')
replaceFileNameFromPath('images/2.0x/*', '@2x', '')
replaceFileNameFromPath('images/3.0x/*', '@3x', '')
