import i3
import re
import subprocess
import getopt
import sys
import os
current_win = i3.filter(nodes=[], focused=True)
for win in current_win:
    parent = find_parent(win['id'])
    if (parent and "rect" in parent
               and parent['layout'] != 'tabbed'
               and parent['layout'] != 'stacked'):
        height = parent['rect']['height']
        width = parent['rect']['width']
        print(width)