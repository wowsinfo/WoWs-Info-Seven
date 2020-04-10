import pyperclip

'''
bool get firstLaunch => this.box.get(FIRST_LAUNCH) ?? true;
setFirstLaunch(bool value) => this.box.put(FIRST_LAUNCH, value);
'''

def write(constant_name, constant_type, default_value):
    one = '  {} get {} => this.box.get({}) ?? {};\n'.format(constant_type, getter(constant_name), constant_name, default_value)
    two = '  {}({} value) => this.box.put({}, value);'.format(setter(constant_name), constant_type, constant_name)
    pyperclip.copy(one + two)
    print('It has been copied :)')

def setter(name: str):
    '''
    from BOTTOM_TAB_INDEX to setBottomTabIndex
    '''
    return 'set' + ''.join(word.lower().title() for word in name.split('_'))

def getter(name: str):
    '''
    from BOTTOM_TAB_INDEX to bottomTabIndex
    '''
    return first_lower(''.join(word.lower().title() for word in name.split('_')))

def first_lower(s):
   if len(s) == 0:
      return s
   else:
      return s[0].lower() + s[1:]

write('GAME_SERVER', 'String', "1.0.8")
